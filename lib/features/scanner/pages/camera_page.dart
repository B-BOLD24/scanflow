import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:scanflow_new/core/services/capture_services.dart';
import '../../../main.dart';
import 'dart:io';
import '../../../core/services/gallery_service.dart';
import '../widgets/filmstrip.dart';

class CameraScreen extends StatefulWidget {
  final Directory session;

  const CameraScreen({super.key, required this.session});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  List<File> pages = [];
  late CameraController controller;
  bool initialized = false;
  bool isCapturing = false;

  @override
  void initState() {
    super.initState();
    initCamera();
    loadPages();
  }

  Future<void> loadPages() async {
    pages = await GalleryService.getPages(widget.session);

    if (mounted) {
      setState(() {});
    }
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
            bottom: 120,
            left: 0,
            right: 0,
            child: FilmStrip(pages: pages),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: isCapturing
                    ? null
                    : () async {
                        setState(() {
                          isCapturing = true;
                        });

                        try {
                          final XFile image = await controller.takePicture();

                          final savedFile = await CaptureService.saveImage(
                            source: File(image.path),
                            session: widget.session,
                          );

                          debugPrint("Saved to:");
                          debugPrint(savedFile.path);

                          await File(image.path).delete();

                          await loadPages();

                          debugPrint("Pages in session: ${pages.length}");
                        } finally {
                          if (mounted) {
                            setState(() {
                              isCapturing = false;
                            });
                          }
                        }
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
