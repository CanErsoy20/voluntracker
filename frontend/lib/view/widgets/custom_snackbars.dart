import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class CustomSnackbars {
  static void errorSnackbar(
      BuildContext context, String title, String description) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: AwesomeSnackbarContent(
          color: Colors.red,
          title: title,
          message: description,
          contentType: ContentType.failure,
        )));
  }

  static void successSnackbar(BuildContext context, String title,
      String description, Function onDismiss) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              color: Colors.green,
              title: title,
              message: description,
              contentType: ContentType.success,
            )))
        .closed
        .then(((value) {
      onDismiss;
    }));
  }
}
