import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    if (widget.skillset.isEmpty) return Container();

    final features = widget.skillset.map((item) => item.title).toList();
    final data = widget.skillset.map((item) => item.rating).toList();

    return Column(children: [
      Expanded(
          child:
              RadarChart.dark(ticks: ticks, features: features, data: [data])),
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
                            content: Row(
                              children: [
                                Container(
                                  width: 200,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: TextFormField(
                                    initialValue: newSkill.title,
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
                                  width: 100,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: TextFormField(
                                    initialValue: newSkill.rating.toString(),
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
                            actions: [
                              CustomTextButton(
                                child: const Text("SAVE"),
                                onPressed: () {
                                  Navigator.pop(context);
                                  widget.localStorage.addSkillset(newSkill);
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
                          content: SingleChildScrollView(
                              child: Column(
                                  children:
                                      List.generate(tempSkills.length, (index) {
                            return Row(
                              children: [
                                Container(
                                  width: 200,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: TextFormField(
                                    initialValue: tempSkills[index].title,
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
                                  width: 100,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  child: TextFormField(
                                    initialValue:
                                        tempSkills[index].rating.toString(),
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
                          actions: [
                            CustomTextButton(
                              child: const Text("SAVE"),
                              onPressed: () {
                                Navigator.pop(context);
                                widget.localStorage.updateSkillset(tempSkills);
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
