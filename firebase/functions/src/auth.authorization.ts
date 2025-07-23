import * as functions from "firebase-functions/v2";
import * as logger from "firebase-functions/logger";

export const setDefaultUserClaims = functions.identity.beforeUserCreated(
  async (event) => {
    logger.info(
      ` Use created, id: ${event.data?.uid}, email: ${event.data?.email}`
    );
    return {
      customClaims: {
        role: "member"
      }
    };
  }
);
