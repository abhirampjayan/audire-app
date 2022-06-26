import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({Key? key}) : super(key: key);

  @override
  State<CaptureScreen> createState() => _CaptureScreenState();
}

class _CaptureScreenState extends State<CaptureScreen> {
  CameraController? cameraController;
  CameraImage? cameraImage;

  initCamera() {
    cameraController = CameraController(
        const CameraDescription(
            name: "Camera 1",
            lensDirection: CameraLensDirection.back,
            sensorOrientation: 0),
        ResolutionPreset.veryHigh);
    cameraController!.initialize().then((value) {
      if (!mounted) return;

      setState(() {
        cameraController!.startImageStream((image) => {
              if (true) {cameraImage = image, log("hello")}
            });
      });
    });
  }

  @override
  initState() {
    super.initState();
    initCamera();
  }

  @override
  void dispose() async {
    super.dispose();

    // await Tflite.close();
    cameraController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        child: cameraImage != null
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.blue,
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.yellow.shade700,
              ),
      )),
    );
  }
}
