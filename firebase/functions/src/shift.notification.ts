import * as admin from "firebase-admin";
import { onDocumentWritten } from "firebase-functions/v2/firestore";
import * as logger from "firebase-functions/logger";

const _userPreviewColPath = "/usersPreview";
const _fcmDeviceColPath = "/devices";

export const shiftAddNotification = onDocumentWritten(
  "users/{userId}/shifts/{shiftId}",
  async (event) => {
    const userId = event.params.userId;
    logger.info(`The employee whose ID is ${userId} has shifted.`, {
      structuredData: true
    });

    const db = admin.firestore();

    logger.info("Attempting to retrieve user preview information.", {
      structuredData: true
    });
    const userPreviewSnapshot = await db
      .collection(_userPreviewColPath)
      .where("userId", "==", userId)
      .limit(1)
      .get();

    if (userPreviewSnapshot.empty) {
      logger.warn(
        `No user preview found for userId: ${userId}. Notification will not be sent.`,
        { structuredData: true }
      );
      return null;
    }

    const userPreviewData = userPreviewSnapshot.docs[0].data();
    const userPreviewId = userPreviewData["id"];

    if (!userPreviewId) {
      logger.warn(
        `User preview found for userId: ${userId} but 'id' field is missing. Notification will not be sent.`,
        { structuredData: true }
      );
      return null;
    }

    logger.info(
      `Retrieving device information for userPreviewId: ${userPreviewId}.`,
      { structuredData: true }
    );
    const deviceSnapshot = await db
      .collection(_fcmDeviceColPath)
      .where("userId", "==", userPreviewId)
      .limit(1)
      .get();

    if (deviceSnapshot.empty) {
      logger.warn(
        `No device found for userPreviewId: ${userPreviewId}. Notification will not be sent.`,
        { structuredData: true }
      );
      return null;
    }

    const deviceData = deviceSnapshot.docs[0].data();
    const fcmToken = deviceData["fcmToken"];

    if (!fcmToken || typeof fcmToken !== "string") {
      logger.warn(
        `FCM token is missing or invalid for userPreviewId: ${userPreviewId}. Notification will not be sent.`,
        { structuredData: true }
      );
      return null;
    }

    const notificationMessage: admin.messaging.Message = {
      token: fcmToken,
      data: {
        deepLinkRoute: "/home/shift"
      },
      android: {
        notification: {
          titleLocKey: "notification.shift_add_title",
          channelId: "shift_channel",
          icon: "ic_launcher_round"
        }
      },
      apns: {
        payload: {
          aps: {
            alert: {
              titleLocKey: "notification.shift_add_title"
            },
            sound: "default"
          }
        }
      }
    };

    try {
      const response = await admin.messaging().send(notificationMessage);
      logger.info("Notification sent successfully.", {
        response: response,
        structuredData: true
      });
      return response;
    } catch (error) {
      logger.error("Failed to send notification.", {
        error: error,
        fcmToken: fcmToken,
        structuredData: true
      });

      return null;
    }
  }
);
