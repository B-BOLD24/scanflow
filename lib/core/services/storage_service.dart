import 'dart:io';

import 'package:path_provider/path_provider.dart';

class StorageService {
  static Future<Directory> getRootDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();

    final root = Directory("${appDir.path}/ScanFlow");

    if (!await root.exists()) {
      await root.create(recursive: true);
    }

    return root;
  }

  static Future<Directory> getSessionsDirectory() async {
    final root = await getRootDirectory();

    final sessions = Directory("${root.path}/sessions");

    if (!await sessions.exists()) {
      await sessions.create(recursive: true);
    }

    return sessions;
  }
}