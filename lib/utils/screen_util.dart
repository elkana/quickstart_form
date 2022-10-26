import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenUtil {
  static void showToast(String message, {bool error = false, bool success = false, String title = ''}) {
    debugPrint('Toast => $message');
    Get.snackbar(title, message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: error
            ? Colors.red.shade700.withOpacity(0.55)
            : success
                ? Colors.green.shade700.withOpacity(0.55)
                : Colors.black.withOpacity(0.55),
        colorText: Colors.white);
  }

  static void showError(Object? message, {StackTrace? stacktrace, String title = ''}) {
    if (stacktrace != null) print(stacktrace);
    showToast(message.toString(), error: true, title: title);
  }

  /// recommend to use
  /// ```
  /// if (!await ScreenUtil.confirm('Konfirm keluar aplikasi ?')) return;
  /// ```
  static Future<bool> confirm(String message, {String title = ''}) async =>
      await showDialog(
          context: Get.context!,
          builder: (_) => AlertDialog(
                  title: Text(title),
                  content: Text(message, style: const TextStyle(fontWeight: FontWeight.bold)),
                  actions: <Widget>[
                    TextButton(onPressed: () => Get.back(result: false), child: const Text('Tidak')),
                    TextButton(onPressed: () => Get.back(result: true), child: const Text('Ya'))
                  ])) ??
      false;

  static Future<bool> exitApp() => confirm('Keluar dari Aplikasi ?');
}
