import 'dart:io';

import 'package:flutter/material.dart';

class PagePreview extends StatelessWidget {
  final File image;

  const PagePreview({
    super.key,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
      ),
      body: InteractiveViewer(
        child: Center(
          child: Image.file(image),
        ),
      ),
    );
  }
}