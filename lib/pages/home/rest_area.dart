import 'package:dellery_app/components/button.dart';
import 'package:dellery_app/pages/dice/dice.dart';
import 'package:dellery_app/store.dart';
import 'package:flutter/material.dart';

class ToolCell extends StatelessWidget {
  const ToolCell(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onPressed})
      : super(key: key);

  final IconData icon;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return CustomTextButton(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(children: [
            Icon(
              icon,
              size: 32,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20),
                ))
          ])),
      onPressed: onPressed,
      isPrimary: true,
    );
  }
}

class RestAreaContent extends StatefulWidget {
  const RestAreaContent({Key? key, required this.localStorage})
      : super(key: key);

  final LocalStorage localStorage;

  @override
  _RestAreaContentState createState() => _RestAreaContentState();
}

class _RestAreaContentState extends State<RestAreaContent> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ToolCell(
          icon: Icons.crop_square,
          title: "Dice",
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DicePage(
                          presetList: widget.localStorage.diceOptionSetList,
                          localStorage: widget.localStorage,
                        )));
          })
    ]);
  }
}
