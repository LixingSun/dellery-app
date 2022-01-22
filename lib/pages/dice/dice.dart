import 'dart:io';
import 'dart:math';

import 'package:dellery_app/components/button.dart';
import 'package:dellery_app/store.dart';
import 'package:flutter/material.dart';

class DicePage extends StatefulWidget {
  const DicePage(
      {Key? key, required this.presetList, required this.localStorage})
      : super(key: key);

  final List<DiceOptionSet> presetList;
  final LocalStorage localStorage;

  @override
  _DicePageState createState() => _DicePageState();
}

const defaultDiceValue = "?";

class _DicePageState extends State<DicePage> {
  final addController = TextEditingController();
  final presetNameController = TextEditingController();
  final _presetNameFormKey = GlobalKey<FormState>();

  List<String> options = [];

  String currentValue = defaultDiceValue;

  String? presetNameValidator(value) {
    if (value.isEmpty) return "Cannot be empty";

    return null;
  }

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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomTextButton(
                        child: const Text("ADD PRESET"),
                        onPressed: () {
                          presetNameController.text = '';

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Add new preset"),
                                  content: Form(
                                    key: _presetNameFormKey,
                                    child: TextFormField(
                                      controller: presetNameController,
                                      validator: presetNameValidator,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                        labelText: 'Title',
                                        border: OutlineInputBorder(),
                                        hintText: 'Enter the title',
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    CustomTextButton(
                                      child: const Text("SAVE"),
                                      onPressed: () {
                                        if (_presetNameFormKey.currentState!
                                            .validate()) {
                                          Navigator.pop(context);

                                          widget.localStorage.addDiceOptionSet(
                                              presetNameController.text,
                                              options);
                                        }
                                      },
                                      isPrimary: true,
                                    ),
                                    CustomTextButton(
                                        child: const Text("CANCEL"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                );
                              });
                        },
                        isPrimary: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: CustomTextButton(
                            child: const Text("RESET"),
                            onPressed: () {
                              setState(() {
                                options = [];
                              });
                            }),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12, bottom: 36),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 20,
                      runSpacing: 20,
                      children: widget.presetList
                          .map((optionSet) => GestureDetector(
                                child: Chip(label: Text(optionSet.name)),
                                onTap: () {
                                  setState(() {
                                    options = optionSet.options;
                                  });
                                },
                              ))
                          .toList(),
                    ),
                  ),
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
