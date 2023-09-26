import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postvideo/controllers/videos_controller.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    videoScreen.fetchVideosFromFirebase();
    super.initState();
  }

  final videoScreen = Get.put(VideosController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Center(
            child: videoScreen.isUploading.value
                ? Text('Uploding Video...')
                : ListView.builder(
                    itemCount: videoScreen.videoUrls.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 300,
                            width: 300,
                            child: VideoPlayer(VideoPlayerController.network(
                                videoScreen.videoUrls[index])),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              videoScreen.videoPlayerController!.play();
                              videoScreen.isPlaying.value = true;
                            },
                            child: const Text('Play'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              videoScreen.videoPlayerController!.pause();
                              videoScreen.isPlaying.value = false;
                            },
                            child: const Text('Pause'),
                          ),
                        ],
                      );
                    },
                  )

            //  Column(
            //     children: [
            //       SizedBox(
            //         height: 300,
            //         width: 300,
            //         child: VideoPlayer(videoScreen.videoPlayerController!),
            //       ),
            //       ElevatedButton(
            //         onPressed: () {
            //           videoScreen.videoPlayerController!.play();
            //           videoScreen.isPlaying.value = true;
            //         },
            //         child: const Text('Play'),
            //       ),
            //       ElevatedButton(
            //         onPressed: () {
            //           videoScreen.videoPlayerController!.pause();
            //           videoScreen.isPlaying.value = false;
            //         },
            //         child: const Text('Pause'),
            //       ),
            //     ],

            //   ),
            ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          videoScreen.pickVideo();
        },
        label: Text('Upload Video'),
        icon: Icon(Icons.upload),
      ),
    );
  }
}
