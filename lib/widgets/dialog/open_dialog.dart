import 'package:flutter/material.dart';
import 'package:flutter_project_1/widgets/dialog/confirm_dialog_widget.dart';
import 'package:flutter_project_1/widgets/dialog/custom_dialog_widget.dart';

class OpenDialog {
  void onFail(BuildContext context, String assetsNamePng, String content,
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

  void onSuccess(BuildContext context, String assetsNamePng, String content,
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

  void confirmDialog(
    BuildContext context,
    String assetsNamePng,
    String content,
    String title,
    VoidCallback onTapConfirm,
    Color confirmColorButton,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return ConfirmDialogWidget(
            assetsNamePng: assetsNamePng,
            content: content,
            confirmColorButton: confirmColorButton,
            onTapConfirm: onTapConfirm,
            title: title,
          );
        });
  }
}
