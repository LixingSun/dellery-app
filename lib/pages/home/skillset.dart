import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

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
  List<SkillItem> tempSkills = [];

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
        child: IconButton(
          icon: const Icon(
            Icons.edit,
            size: 24,
            color: Colors.green,
          ),
          iconSize: 24,
          onPressed: () {
            tempSkills = List.from(widget.skillset);

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Edit Skillset"),
                    content: SingleChildScrollView(
                        child: Column(
                            children: List.generate(tempSkills.length, (index) {
                      return Row(
                        children: [
                          Container(
                            width: 200,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: TextFormField(
                              initialValue: tempSkills[index].title,
                              decoration: const InputDecoration(
                                labelText: 'Title',
                                hintText: '',
                              ),
                              onChanged: (value) {
                                stderr.writeln(value);
                                setState(() {
                                  tempSkills[index].title = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: 100,
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: TextFormField(
                              initialValue: tempSkills[index].rating.toString(),
                              decoration: const InputDecoration(
                                labelText: 'Rating',
                                hintText: 'Enter the rating',
                              ),
                              onChanged: (value) {
                                stderr.writeln(value);
                                setState(() {
                                  tempSkills[index].rating = int.parse(value.isEmpty ? '0' : value);
                                });
                              },
                            ),
                          )
                        ],
                      );
                    }).toList())),
                    actions: [
                      TextButton(
                          child: const Text("SAVE"),
                          onPressed: () {
                            Navigator.pop(context);
                            stderr.writeln(tempSkills.toString());
                            widget.localStorage.updateSkillset(tempSkills);
                          }),
                      TextButton(
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
    ]);
  }
}
