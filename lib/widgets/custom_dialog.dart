import 'package:flutter/material.dart';

import '../configs/color_config.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.hasDescription,
  }) : super(key: key);

  final String title, description, image;
  final bool hasDescription;

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context));
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: [
        hasDescription
            ? Container(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 10,
                  right: 10,
                ),
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(17),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 5.0),
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.kPrimaryColor,
                          radius: 16,
                          backgroundImage: AssetImage('assets/images/' + image),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(description,
                        style: const TextStyle(
                          fontSize: 16,
                        )),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            : Container(
                padding: const EdgeInsets.only(
                  top: 16,
                  bottom: 16,
                  left: 0,
                  right: 0,
                ),
                margin: const EdgeInsets.only(top: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(17),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.black,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 5.0),
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.kPrimaryColor,
                          radius: 16,
                          backgroundImage: AssetImage('assets/images/' + image),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              )
      ],
    );
  }
}
