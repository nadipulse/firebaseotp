
import 'dart:math';

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postvideo/controllers/login_controller.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final loginController = Get.put(LoginController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
      
        title: const Text("Verify OTP",
        
        style: TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.bold
        ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: loginController.otpText,
              decoration:  InputDecoration(labelText: "Enter OTP",
              fillColor: Colors.grey.shade100,
              hintMaxLines: 6,
              isDense: true,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),

              ),
              
              ),
              
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: (){
                if(loginController.otpText.text.isEmpty|| loginController.otpText.text.length<6){
                  Get.snackbar("Error", "Enter valid OTP");
                }
                else {
                  loginController.verifyOTP();
                }
              },
              child: const Text("Verify OTP"),
            ),
          
          ],
        ),
      ),
    );
  }
}
