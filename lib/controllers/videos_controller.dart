import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideosController extends GetxController {
  XFile? video = XFile('');
  RxBool isPlaying = false.obs;
  VideoPlayerController? videoPlayerController;
  RxBool isUploading = false.obs;
  bool isLoading=false;
  List<String> videoUrls = [];
  List<String> fileNames = [];
  List<Color> colors= [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.brown,
    Colors.indigo,
    Colors.lime,
    Colors.amber,
    Colors.cyan,
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.lightGreen,
    Colors.limeAccent,
    Colors.pinkAccent,
    Colors.purpleAccent,
    Colors.tealAccent,
    Colors.yellowAccent,
    Colors.amberAccent,
    Colors.cyanAccent,
    Colors.deepOrangeAccent,
    Colors.deepPurpleAccent,
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.redAccent,
    Colors.greenAccent,
    Colors.blueAccent,
  ];
  Color generatedRandomColor(){
    return colors[Random().nextInt(colors.length)];
  }


  pickVideo() async {
    final ImagePicker picker = ImagePicker();

    video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) {
      uploadOnFirebase();
    } else {
      Get.snackbar(
        'Video Not Selected',
        'Video Not Selected Successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
    pickVideoCamera() async {
    final ImagePicker picker = ImagePicker();

    video = await picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      uploadOnFirebase();
    } else {
      Get.snackbar(
        'Video Not Selected',
        'Video Not Selected Successfully',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<String> uploadOnFirebase() async {
    isUploading.value = true;
    UploadTask? uploadTask;
    final path = 'videos/${video!.name}';
    final ref = FirebaseStorage.instance.ref().child(path);

    try {
      uploadTask = ref.putFile(File(video!.path));
      await uploadTask.whenComplete(() {});
      final url = await ref.getDownloadURL();
      print('URL Is $url');
      isUploading.value = false;
      Get.snackbar(
        'Upload Successfull',
        '',
        snackPosition: SnackPosition.BOTTOM,
      );
      fetchVideosFromFirebase();
      update();
      return url;
    } catch (e) {
      print('Error uploading video: $e');
      Get.snackbar(
        'Error',
        'Error uploading video: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
      update();

      // Handle the error here
      rethrow;
    }
  }

  Future<List<String>> fetchVideosFromFirebase() async {
    isLoading=true;
    try {
      final storage = FirebaseStorage.instance;
      final videosFolderRef = storage
          .ref()
          .child('videos'); 

      final ListResult result = await videosFolderRef.list();



      for (final Reference ref in result.items) {
        
        final url = await ref.getDownloadURL();
        fileNames.add(ref.name);
        videoUrls.add(url);
      }
      isLoading=false;
      update();

      return videoUrls;
    } catch (e) {
      update();
      isLoading=false;
      print('Error fetching videos: $e');
      // Handle the error here
      rethrow;
    }
    
  }
}
