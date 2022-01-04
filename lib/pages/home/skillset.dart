import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

import 'package:dellery_app/components/button.dart';
import 'package:dellery_app/constants/colors.dart';

import '../../store.dart';

class SkillsetContent extends StatefulWidget {
  const SkillsetContent(
      {Key? key, required this.skillset, required this.localStorage})
      : super(key: key);

  final List<SkillItem> skillset;
  final LocalStorage localStorage;

  @override
  _SkillsetContentState createState() => _SkillsetContentState();
}

class _SkillsetContentState extends State<SkillsetContent> {
  final ticks = [1, 2, 3, 4, 5];
  final _editFormKey = GlobalKey<FormState>();
  final _addFormKey = GlobalKey<FormState>();

  String? titleValidator(value) {
    if (value.isEmpty) return "Cannot be empty";

    return null;
  }

  String? ratingValidator(value) {
    if (value.isEmpty) return "Cannot be empty";

    final number = int.parse(value);
    if (number < 0 || number > 5) {
      return "Valid from 0 to 5";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final features = widget.skillset.map((item) => item.title).toList();
    final data = widget.skillset.map((item) => item.rating).toList();

    return Column(children: [
      widget.skillset.isEmpty
          ? Container()
          : Expanded(
              child: RadarChart.dark(
                  ticks: ticks, features: features, data: [data])),
      Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                  icon: Icon(
                    Icons.add,
                    size: 24,
                    color: toolColor,
                  ),
                  iconSize: 24,
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          final newSkill = SkillItem(title: "", rating: 0);

                          return AlertDialog(
                            title: const Text("Add Skillset"),
                            content: Form(
                              key: _addFormKey,
                              child: Row(
                                children: [
                                  Container(
                                    width: 300,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: TextFormField(
                                      initialValue: newSkill.title,
                                      validator: titleValidator,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                        labelText: 'Title',
                                        hintText: '',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          newSkill.title = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: TextFormField(
                                      initialValue: newSkill.rating.toString(),
                                      validator: ratingValidator,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                        labelText: 'Rating',
                                        hintText: 'Enter the rating',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          newSkill.rating = int.parse(
                                              value.isEmpty ? '0' : value);
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              CustomTextButton(
                                child: const Text("SAVE"),
                                onPressed: () {
                                  if (_addFormKey.currentState!.validate()) {
                                    Navigator.pop(context);
                                    widget.localStorage.addSkillset(newSkill);
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
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 24,
                  color: toolColor,
                ),
                iconSize: 24,
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        List<SkillItem> tempSkills = List.from(widget.skillset);

                        return AlertDialog(
                          title: const Text("Edit Skillset"),
                          content: Form(
                            key: _editFormKey,
                            child: SingleChildScrollView(
                                child: Column(
                                    children: List.generate(tempSkills.length,
                                        (index) {
                              return Row(
                                children: [
                                  Container(
                                    width: 200,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: TextFormField(
                                      initialValue: tempSkills[index].title,
                                      validator: titleValidator,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                        labelText: 'Title',
                                        hintText: '',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          tempSkills[index].title = value;
                                        });
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 150,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      initialValue:
                                          tempSkills[index].rating.toString(),
                                      validator: ratingValidator,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      decoration: const InputDecoration(
                                        labelText: 'Rating',
                                        hintText: 'Enter the rating',
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          tempSkills[index].rating = int.parse(
                                              value.isEmpty ? '0' : value);
                                        });
                                      },
                                    ),
                                  )
                                ],
                              );
                            }).toList())),
                          ),
                          actions: [
                            CustomTextButton(
                              child: const Text("SAVE"),
                              onPressed: () {
                                if (_editFormKey.currentState!.validate()) {
                                  Navigator.pop(context);
                                  widget.localStorage
                                      .updateSkillset(tempSkills);
                                }
                              },
                              isPrimary: true,
                            ),
                            CustomTextButton(
                                child: const Text("CANCEL"),
                                onPressed: () {
                                  Navigator.pop(context);
                                })
                          ],
                        );
                      });
                },
              ),
            )
          ]))
    ]);
  }
}
