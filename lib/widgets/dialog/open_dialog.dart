import 'package:flutter/material.dart';
import 'package:flutter_project_1/widgets/dialog/custom_dialog_widget.dart';

class OpenDialog {
  static void onFail(BuildContext context, String assetsNamePng, String content,
      String title, Color mainColor) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CustomDialogWidget(
            assetsNamePng: assetsNamePng,
            content: content,
            mainColor: mainColor,
            title: title,
          );
        });
  }

  static void onSuccess(BuildContext context, String assetsNamePng,
      String content, String title, Color mainColor) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return CustomDialogWidget(
            assetsNamePng: assetsNamePng,
            content: content,
            mainColor: mainColor,
            title: title,
          );
        });
  }
}
