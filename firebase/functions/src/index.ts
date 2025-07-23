import * as admin from "firebase-admin";
import { setGlobalOptions } from "firebase-functions/v2";

admin.initializeApp();
setGlobalOptions({ region: "europe-west1" });

export * from "./auth.authorization";
export * from "./chat.notification";
export * from "./shift.notification";
