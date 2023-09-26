import 'dart:math';

import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postvideo/controllers/login_controller.dart';
import 'package:postvideo/views/video_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        title: const Text(
          "Login Screen",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: loginController.phoneText,
              decoration: InputDecoration(
                labelText: "Phone Number",
                fillColor: Colors.grey.shade100,
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
              onPressed: () {
                if (loginController.phoneText.text.isEmpty ||
                    loginController.phoneText.text.length < 10) {
                  Get.snackbar("Error", "Enter valid phone number");
                } else {
                  loginController.sendOTP();
                }
              },
              child: const Text("Send OTP"),
            ),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: (){
                Get.to(()=>const VideoScreen());
              },
              child: const Text(
                "Skip",
                style:
                    TextStyle(color: Colors.black45, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
