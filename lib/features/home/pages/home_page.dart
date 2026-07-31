import 'package:flutter/material.dart';
import '../../scanner/pages/camera_page.dart';

import '../../../core/services/session_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ScanFlow")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final session = await SessionService.createSession();

            debugPrint("Session Created:");
            debugPrint(session.path);

            if (!context.mounted) return;

            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CameraScreen(session: session)),
            );
          },
          child: const Text("New Scan"),
        ),
      ),
    );
  }
}
