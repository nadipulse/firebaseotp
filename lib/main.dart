


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:postvideo/views/login_screen.dart';
import 'package:postvideo/views/video_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              // backgroundColor: Colors.teal,
              iconTheme: IconThemeData(color: Colors.black),
            ),
      
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 0, 150, 136),
            ),
            useMaterial3: true,
          ),
      home: const LoginScreen(),
    );
  }
}
