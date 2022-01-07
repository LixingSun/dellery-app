import 'dart:math';

import 'package:dellery_app/components/button.dart';
import 'package:flutter/material.dart';

class DicePage extends StatefulWidget {
  const DicePage({Key? key}) : super(key: key);

  @override
  _DicePageState createState() => _DicePageState();
}

const defaultDiceValue = "?";

class _DicePageState extends State<DicePage> {
  final addController = TextEditingController();
  final List<String> options = [];

  String currentValue = defaultDiceValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Dice")),
        body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/dice_bg.jpg"),
                    fit: BoxFit.cover)),
            child: Center(
                child: Card(
                    child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.amber,
                      child: Text(
                        currentValue,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                    onTap: () {
                      if (options.isNotEmpty) {
                        setState(() {
                          currentValue =
                              options[Random().nextInt(options.length)];
                        });
                      }
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: SizedBox(
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
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: TextFormField(
                          controller: addController,
                          decoration: const InputDecoration(
                            labelText: 'New Item',
                            border: OutlineInputBorder(),
                            hintText: 'Enter the name',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: CustomTextButton(
                          child: const Text("ADD"),
                          onPressed: () {
                            setState(() {
                              options.add(addController.text);
                              addController.text = '';
                            });
                          },
                          isPrimary: true,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )))));
  }
}
