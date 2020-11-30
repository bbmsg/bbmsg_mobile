import 'package:flutter/material.dart';

//
class ToastUtils {
  static void showSuccessToast(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      duration: Duration(seconds: 5),
      backgroundColor: Colors.green,
    ));
  }
}
