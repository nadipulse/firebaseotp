import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController phoneText = TextEditingController();
  TextEditingController otpText = TextEditingController();
  String verificationIds = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isSend = false;

  Future sendOTP({required String phone}) async {
    var data = await auth.verifyPhoneNumber(
      phoneNumber: '+91$phone',
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {
        print('Verification Completed');
      },
      verificationFailed: (FirebaseAuthException e) {
        Get.snackbar(
          'Error',
          'Error Verifying Phone Number: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        print(verificationId);
        print(resendToken);
        verificationId = verificationId;
        isSend = true;

        Get.snackbar(
          'OTP Sent',
          'OTP Sent Successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
        update();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Get.snackbar(
          'Error',
          'Error Verifying Phone Number: $verificationId',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
    );
    // print("data is $data");
  }

  Future<void> verifyOTPCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIds,
      smsCode: otpText.text,
    );
    await auth
        .signInWithCredential(credential)
        .then((value) => print('User Login In Successful'));
  }

  Future sendonphone() async {
    auth.signInWithPhoneNumber('+918445166556');
  }
}
