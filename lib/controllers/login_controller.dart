import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postvideo/views/otp_screen.dart';
import 'package:postvideo/views/video_screen.dart';

class LoginController extends GetxController {
  TextEditingController phoneText = TextEditingController();
  TextEditingController otpText = TextEditingController();
  String verificationIds = '';
  FirebaseAuth auth = FirebaseAuth.instance;
  bool isSend = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _verificationId = "";


  
  Future<void> sendOTP() async {
    String phoneNumber = "+91${phoneText.text}"; 

    verificationCompleted(PhoneAuthCredential phoneAuthCredential) async {
      
      final UserCredential userCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      print("Auto retrieved: ${userCredential.user?.uid}");
    }

    verificationFailed(FirebaseAuthException e) {
      print("Verification failed: ${e.message}");
    }

    codeSent(String verificationId, int? resendToken) {
      print("Code sent to $phoneNumber");
      Get.to(()=>const OtpScreen());
   
        _verificationId = verificationId;
      
    }

    codeAutoRetrievalTimeout(String verificationId) {
      print("Auto retrieval timeout");
    }

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  // Function to manually verify the SMS code
  Future<void> verifyOTP() async {
    String smsCode = otpText.text;

    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId,
        smsCode: smsCode,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      print("Manual verification successful: ${userCredential.user!.uid}");
      Get.to(()=>const VideoScreen());
    } catch (e) {
      print("Manual verification failed: $e");
    }
  }
}
