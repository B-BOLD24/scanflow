import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scanflow_new/core/services/capture_services.dart';
import '../../../main.dart';
import 'dart:io';

class CameraScreen extends StatefulWidget {
  final Directory session;

  const CameraScreen({super.key, required this.session});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController controller;
  bool initialized = false;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await controller.initialize();

    setState(() {
      initialized = true;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!initialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: Stack(
        children: [
          Center(child: CameraPreview(controller)),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () async {
                  final XFile image = await controller.takePicture();

                  final savedFile = await CaptureService.saveImage(
                    source: File(image.path),
                    session: widget.session,
                  );

                  debugPrint("Saved to:");
                  debugPrint(savedFile.path);

                  await File(image.path).delete();
                },
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
