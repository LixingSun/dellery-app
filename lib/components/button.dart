import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {Key? key, this.isPrimary = false, required this.child, required this.onPressed})
      : super(key: key);

  final bool isPrimary;
  final Widget child;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    if (isPrimary) {
      return Stack(children: [
        Positioned.fill(
            child: Container(
                decoration: const BoxDecoration(color: Colors.green))),
        TextButton(
            style: TextButton.styleFrom(primary: Colors.white),
            child: child,
            onPressed: () {
              onPressed();
            }),
      ]);
    } else {
      return TextButton(
          style: TextButton.styleFrom(primary: Colors.grey[400]),
          child: const Text("CANCEL"),
          onPressed: () {
            Navigator.pop(context);
          });
    }
  }
}
