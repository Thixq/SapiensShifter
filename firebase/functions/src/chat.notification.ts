import * as admin from "firebase-admin";
import { onDocumentUpdated } from "firebase-functions/v2/firestore";
import * as logger from "firebase-functions/logger";

interface Device {
  userId: string;
  fcmToken: string;
}

export const sendLastMessageNotification = onDocumentUpdated(
  "chats/{chatId}",
  async (event) => {
    const chatId = event.params.chatId;
    logger.info("sendLastMessageNotification triggered", { chatId });

    const before = event.data?.before.data();
    const after = event.data?.after.data();

    // If lastMessage timestamp hasn't changed, exit early
    if (before?.lastMessage?.timeStamp === after?.lastMessage?.timeStamp) {
      logger.info("No change in lastMessage; skipping notification.");
      return null;
    }

    const lastMessage = after?.lastMessage;
    const isGroup: boolean = after?.isGroup;
    const members: string[] = after?.members || [];
    const senderId = lastMessage?.senderId;

    if (!lastMessage || !members.length || !senderId) {
      logger.warn("Missing required fields in chat document", { after });
      return null;
    }

    // Determine recipients (all members except the sender)
    const receiverIds = members.filter((id) => id !== senderId);
    if (!receiverIds.length) {
      logger.info("No recipients found for notification.");
      return null;
    }

    // Fetch FCM tokens for each recipient
    const devicesSnap = await admin
      .firestore()
      .collection("devices")
      .where("userId", "in", receiverIds)
      .get();

    const tokens = devicesSnap.docs
      .map((doc) => (doc.data() as Device).fcmToken)
      .filter((t) => !!t);

    if (!tokens.length) {
      logger.warn("No valid FCM tokens found for recipients.", { receiverIds });
      return null;
    }

    const senderDoc = await admin
      .firestore()
      .collection("usersPreview")
      .doc(senderId)
      .get();
    const senderName =
      (isGroup
        ? `${after?.groupName}: ${senderDoc.data()?.name}`
        : senderDoc.data()?.name) || "Someone";

    // Prepare data payload
    const dataPayload = {
      deepLinkRoute: `/chatRoom/${chatId}`
    };

    // Build multicast message
    const multicastMessage: admin.messaging.MulticastMessage = {
      tokens: Array.from(new Set(tokens)),
      notification: {
        title: `${senderName}`,
        body: lastMessage.text
      },
      data: dataPayload,
      android: { notification: { channelId: "chat_channel" } },
      apns: { payload: { aps: { sound: "default" } } }
    };

    // Send data-only messages using sendEachForMulticast (replaces deprecated sendMulticast)
    try {
      // dryRun = false for actual delivery
      const response = await admin
        .messaging()
        .sendEachForMulticast(multicastMessage, false);
      logger.info(
        `Notifications sent: ${response.successCount}/${response.responses.length}`,
        response
      );
      response.responses.forEach((resp, idx) => {
        if (!resp.success) {
          logger.error(
            `Failed to send to ${multicastMessage.tokens[idx]}:`,
            resp.error
          );
        }
      });
      return response;
    } catch (error) {
      logger.error("Error sending FCM messages", error);
      throw error;
    }
  }
);
