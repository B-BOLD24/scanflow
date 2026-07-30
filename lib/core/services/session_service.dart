import 'dart:io';

import 'storage_service.dart';

class SessionService {
  static Future<Directory> createSession() async {
    final sessionsDir = await StorageService.getSessionsDirectory();

    final sessionName =
        "session_${DateTime.now().millisecondsSinceEpoch}";

    final session = Directory("${sessionsDir.path}/$sessionName");

    await session.create();

    await Directory("${session.path}/pages").create();

    await Directory("${session.path}/thumbnails").create();

    await Directory("${session.path}/exports").create();

    return session;
  }
}