import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ml/pages/myhomepage.dart';
import 'package:get/get.dart';

import 'controllers/mood_controllers.dart';

void main() async {
  final mood = Get.put(MoodController());
  WidgetsFlutterBinding.ensureInitialized();
  mood.cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.deepPurple),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
