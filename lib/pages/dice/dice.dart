import 'dart:math';

import 'package:flutter/material.dart';

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  _DicePageState createState() => _DicePageState();
}

const defaultDiceValue = "?";

class _DicePageState extends State<DicePage> {
  final List<String> options = ["AAAAAAA", "BBBBBBB", "CCCCCCC", "DDDDDDD", "EEEEEEE", "FFFFFFF", "GGGGGGG", "HHHHHH"];

  String currentValue = defaultDiceValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Dice")),
        body: Center(
            child: Card(
                child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 36, horizontal:60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: GestureDetector(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.amber,
                      child: Text(
                        currentValue,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        currentValue =
                            options[Random().nextInt(options.length)];
                      });
                    },
                  )),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Center(
                    child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 20,
                  runSpacing: 20,
                  children: options
                      .map((name) => Chip(
                            label: Text(name),
                          ))
                      .toList(),
                )),
              ),
            ],
          ),
        ))));
  }
}
