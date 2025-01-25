import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String msg,
  SnackBarAction? action,
  Duration? duration,
}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: duration ?? const Duration(seconds: 4),
      // showCloseIcon: true,
      action: action,
    ),
  );
}
