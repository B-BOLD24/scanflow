import 'dart:io';

class CaptureService {
  static Future<File> saveImage({
    required File source,
    required Directory session,
  }) async {
    final pagesDir = Directory("${session.path}/pages");

    final pageCount = await pagesDir
        .list()
        .where((entity) => entity is File)
        .length;

    final fileName =
        "page_${(pageCount + 1).toString().padLeft(4, '0')}.jpg";

    final destination =
        File("${pagesDir.path}/$fileName");

    return source.copy(destination.path);
  }
}