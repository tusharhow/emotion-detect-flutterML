import 'package:camera/camera.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tflite/tflite.dart';

class MoodController extends GetxController {
  List<CameraDescription>? cameras;
  CameraImage? cameraImage;
  CameraController? cameraController;
  String labels = '';

  initCamera() {
    cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraController!.initialize().then((value) {
      cameraController!.startImageStream((imageStream) {
        cameraImage = imageStream;
        runModel();
        update();
      });
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var predictions = await Tflite.runModelOnFrame(
          bytesList: cameraImage!.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage!.height,
          imageWidth: cameraImage!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 2,
          threshold: 0.1,
          asynch: true);
      for (var element in predictions!) {
        labels = element['label'];
        update();
      }
    }
  }

  loadmodelData() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
    );
  }
}
