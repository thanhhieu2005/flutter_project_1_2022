import 'package:flutter/material.dart';
import 'package:flutter_project_1/widgets/dialog/confirm_dialog_widget.dart';
import 'package:flutter_project_1/widgets/dialog/custom_dialog_widget.dart';

class OpenDialog {
  void onFail({
    required BuildContext context,
    required String assetsNamePng,
    required String content,
    required String title,
    required Color mainColor,
  }) {
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

  void onSuccess({
    required BuildContext context,
    required String assetsNamePng,
    required String content,
    required String title,
    required Color mainColor,
  }) {
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

  void confirmDialog({
    required BuildContext context,
    required String assetsNamePng,
    required String content,
    required String title,
    required VoidCallback onTapConfirm,
    required Color confirmColorButton,
  }) {
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
