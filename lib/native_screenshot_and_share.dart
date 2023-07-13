library native_screenshot_and_share;

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_screenshot/flutter_native_screenshot.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

class Screenshot {
  late BuildContext context;

  Screenshot(this.context);

  Future<void> moveFile(String sourcePath, String destinationFile) async {
    File sourceFile = File(sourcePath);
    try {
      // preferred way to move the file
      await sourceFile.rename(destinationFile);
    } catch (e) {
      // if rename fails, copy the source file and then delete it
      await sourceFile.copy(destinationFile);
      await sourceFile.delete();
    }
  }

  Future<void> _doTakeScreenshot() async {
    String? path = await FlutterNativeScreenshot.takeScreenshot();
    debugPrint('Screenshot taken, path: $path');
    if (path == null || path.isEmpty) {
      // if error
      await _popup();
      return;
    }

    String destinationFile =
        '${(await getTemporaryDirectory()).path}/screenshot.png';
    await moveFile(path, destinationFile);
    await Share.shareFiles([destinationFile]);
  }

  List<Widget> _actions() {
    return [
      TextButton(
        child: const Text("Update"),
        onPressed: () {
          openAppSettings();
          Navigator.pop(context);
        },
      ),
      TextButton(
        child: const Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ];
  }

  Future<void> _popup() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Permission"),
        content: const Text("You have permanently denied the permission."),
        actions: _actions(),
      ),
    );
  }

  Future<void> shareScreenShot() async {
    PermissionStatus resultPermissionStorage =
        await Permission.storage.request();

    if (resultPermissionStorage == PermissionStatus.granted) {
      _doTakeScreenshot();
      return;
    } else {
      if (resultPermissionStorage == PermissionStatus.denied) {
        await shareScreenShot();
      } else if (resultPermissionStorage ==
          PermissionStatus.permanentlyDenied) {
        await _popup();
      }
    }
  }
}
