import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideosController extends GetxController {
  XFile? video = XFile('');
  RxBool isPlaying = false.obs;
  VideoPlayerController? videoPlayerController;
  RxBool isUploading = false.obs;
  List<String> videoUrls = [];

  pickVideo() async {
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
      return url;
    } catch (e) {
      print('Error uploading video: $e');
      Get.snackbar(
        'Error',
        'Error uploading video: $e',
        snackPosition: SnackPosition.BOTTOM,
      );

      // Handle the error here
      throw e;
    }
  }

  Future<List<String>> fetchVideosFromFirebase() async {
    try {
      final storage = FirebaseStorage.instance;
      final videosFolderRef = storage
          .ref()
          .child('videos'); // Change 'videos' to your storage folder name

      final ListResult result = await videosFolderRef.list();

      // List to store the URLs of the videos

      for (final Reference ref in result.items) {
        final url = await ref.getDownloadURL();
        videoUrls.add(url);
      }

      return videoUrls;
    } catch (e) {
      print('Error fetching videos: $e');
      // Handle the error here
      throw e;
    }
  }
}
