




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


String verifId="NULL";

class ApiAuth {

  BuildContext context;

  ApiAuth(this.context);

  ///========================================================================================================

  Future<void> verifyPhone(String phone, VoidCallback onSent,) async
  {
    // HelpFun.showLoading(context);
    debugPrint("PhoneNumber===> $phone");

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async
      {
        debugPrint("verificationCompleted");
      },
      verificationFailed: (FirebaseAuthException e) {
        debugPrint("verificationFailed ${e.toString()}");
      },
      codeSent: (String? verificationId, int? resendToken) {
        verifId = verificationId!;
        debugPrint('*' * 100);
        debugPrint("verificationId $verificationId");
        debugPrint("resendToken $resendToken");
        onSent();
      },
      codeAutoRetrievalTimeout: (String verificationID) {
        debugPrint("codeAutoRetrievalTimeout");
      },

    );
    //HelpFun.closeLoading(context);
  }

 ///========================================================================================================
  Future<bool> checkCode(String userCode) async
  {
   // HelpFun.showLoading(context);
    try {
      debugPrint("verifId $verifId");
      PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verifId, smsCode: userCode);
      await FirebaseAuth.instance.signInWithCredential(credential);
      print("User Verify Successfully ");

      //HelpFun.closeLoading(context);
      return true;
    }
    catch (ex) {
      //HelpFun.closeLoading(context);

      debugPrint("ERR ${ex.toString()}");
      print("User Verify Failed ");
      return false;
    }
  }




}