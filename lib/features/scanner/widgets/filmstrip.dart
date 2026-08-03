import 'dart:io';

import 'package:flutter/material.dart';

import '../../editor/pages/page_preview.dart';

class FilmStrip extends StatelessWidget {
  final List<File> pages;

  const FilmStrip({
    super.key,
    required this.pages,
  });

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return _buildThumbnail(context, index);
        },
      ),
    );
  }

  Widget _buildThumbnail(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PagePreview(
              image: pages[index],
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.file(
            pages[index],
            width: 60,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}