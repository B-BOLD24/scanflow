import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'features/home/pages/home_page.dart';

late List<CameraDescription> cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();

  runApp(const ScanFlowApp());
}

class ScanFlowApp extends StatelessWidget {
  const ScanFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ScanFlow',
      home: HomePage(),
    );
  }
}