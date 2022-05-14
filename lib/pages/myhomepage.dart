import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/mood_controllers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final mood = Get.put(MoodController());

  @override
  void initState() {
    super.initState();
    mood.initCamera();
    mood.loadmodelData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Emotion Detect Flutter ML',
        ),
      ),
      body: GetBuilder<MoodController>(builder: (cont) {
        return Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: cont.cameraController!.value.isInitialized
                  ? Container()
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: AspectRatio(
                        aspectRatio: cont.cameraController!.value.aspectRatio,
                        child: CameraPreview(cont.cameraController!),
                      ),
                    ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Mood: ${cont.labels}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.red,
              letterSpacing: 1,
            ),
          )
        ]);
      }),
    );
  }
}
