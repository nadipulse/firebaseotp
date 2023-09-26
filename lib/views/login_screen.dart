import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postvideo/controllers/login_controller.dart';
import 'package:postvideo/views/video_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: GetBuilder<LoginController>(builder: (controller) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: loginController.phoneText,
                  decoration: const InputDecoration(
                    prefix: Text('+91'),
                    hintText: 'Enter Phone Number',
                  ),
                ),
                TextField(
                  controller: loginController.otpText,
                  decoration: const InputDecoration(
                    hintText: 'Enter OTP',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Get.to(() => VideoScreen());
                    if (controller.isSend) {
                      controller.verifyOTPCode();
                    } else {
                      loginController.sendOTP(
                          phone: loginController.phoneText.text);
                    }
                  },
                  child: Text(controller.isSend ? 'Verify' : 'Login'),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
