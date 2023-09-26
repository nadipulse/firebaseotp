import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postvideo/controllers/videos_controller.dart';
import 'package:postvideo/views/video_play_screen.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.teal.shade100,
        title: const Text(
          'Videos',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
      ),
      body: GetBuilder<VideosController>(builder: (controller) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Center(
              child: videoScreen.isLoading
                  ? const CircularProgressIndicator()
                  : videoScreen.isUploading.value
                      ? const Text('Uploding Video...')
                      : videoScreen.fileNames.isEmpty
                          ? const Text('Videos not found')
                          : ListView.builder(
                              itemCount: videoScreen.fileNames.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.to(() => VideoPlayerScreen(
                                          url: videoScreen.videoUrls[index]));
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 200,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: controller
                                                .generatedRandomColor()
                                                .withOpacity(.2),
                                          ),
                                          child: const Icon(
                                            Icons.play_arrow,
                                            size: 50,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          videoScreen.fileNames[index],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )

             
              ),
        );
      }),
      floatingActionButton: GetBuilder<VideosController>(
    
        builder: (controller) {
          return FloatingActionButton.extended(
            onPressed: () {
              showBottomSheett(context);
            
            },
            label: const Text('Upload Video'),
            icon:controller.isUploading.value?const CircularProgressIndicator(): const Icon(Icons.upload),
          );
        }
      ),
    );
  }

  void showBottomSheett(BuildContext context){
    showModalBottomSheet(
      context: context,
      builder: (context){
        return SizedBox(
          height: 140,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Pick from camera'),
                onTap: (){
                  Navigator.pop(context);
                    videoScreen.pickVideoCamera();
                 
                },
              ),
              ListTile(
                leading: const Icon(Icons.video_library),
                title: const Text('Pick from gallery'),
                onTap: (){
                  Navigator.pop(context);
                  videoScreen.pickVideo();
              
                },
              ),
            ],
          ),
        );
      }
    );

  }
}
