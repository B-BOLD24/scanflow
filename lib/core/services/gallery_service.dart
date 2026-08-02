import 'dart:io';

class GalleryService {
  static Future<List<File>> getPages(Directory session) async {
    final pagesDir = Directory("${session.path}/pages");

    final files = pagesDir
        .listSync()
        .whereType<File>()
        .toList();

    files.sort(
      (a, b) => a.path.compareTo(b.path),
    );

    return files;
  }
}