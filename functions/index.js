/* eslint-disable max-len */
const {initializeApp} = require("firebase-admin/app");
const functions = require("firebase-functions");
const admin = require("firebase-admin");
initializeApp();

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started


exports.userDataAvailableCheck = functions.https.onCall(async(data, context) => {
      if (context.auth!=null || context.auth!=undefined || !context.auth) {
        const documentRef = await admin.firestore().collection("user-data").doc(context.auth.uid).get();
        if(documentRef.exists && documentRef.data()!=undefined){
          return true;
        }
        else{
          return false;
        }
      } else {
        throw new functions.https.HttpsError("not-authenticated", "Operation cannot be proceeded without Authentication");
      }
});

exports.uploadUserData = functions.https.onCall(async(data , context)=>{
  if(context.auth!=null || context.auth!=undefined || !context.auth){
    const userDataCollectionReference = await admin.firestore().collection("user-data");
    userDataCollectionReference.doc(context.auth.uid).set({
      firstName : data.firstName,
      lastName : data.lastName,
      dateOfBirth : data.dob,
      salary : data.salary
    });
    return "User-data uploaded successfully";
  }
  else{
    throw new functions.https.HttpsError("not-authenticated", "Operation cannot be proceeded without Authentication");
  }
});