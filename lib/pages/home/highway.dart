import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:dellery_app/components/progress_bar.dart';

import '../../store.dart';

class HighwayContent extends StatefulWidget {
  const HighwayContent(
      {Key? key, required this.ongoingList, required this.localStorage})
      : super(key: key);

  final List<OngoingItem> ongoingList;
  final LocalStorage localStorage;

  @override
  _HighwayContentState createState() => _HighwayContentState();
}

const OngoingTypes defaultType = OngoingTypes.book;

class _HighwayContentState extends State<HighwayContent> {
  final titleController = TextEditingController();
  final percentController = TextEditingController();
  OngoingTypes typeController = defaultType;

  Widget _buildBody() {
    final ongoingList = widget.ongoingList;

    return Column(mainAxisSize: MainAxisSize.min, children: [
      ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: ongoingList.length,
          itemBuilder: (context, index) {
            return ProgressBar(
              title: ongoingList[index].title,
              percent: ongoingList[index].percent,
              icon: Icon(typeMap[ongoingList[index].type]),
              onEdit: () {
                titleController.text = ongoingList[index].title;
                percentController.text = ongoingList[index].percent.toString();
                typeController = ongoingList[index].type;

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Edit"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                controller: titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Title',
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter the title',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFormField(
                                controller: percentController,
                                decoration: const InputDecoration(
                                  labelText: 'Percent',
                                  border: OutlineInputBorder(),
                                  hintText: 'Enter the percent',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: DropdownButtonFormField(
                                value: typeController,
                                items: OngoingTypes.values
                                    .map((value) => DropdownMenuItem(
                                        child: Text(
                                          value
                                              .toString()
                                              .split('.')[1]
                                              .toUpperCase(),
                                        ),
                                        value: value))
                                    .toList(),
                                decoration: const InputDecoration(
                                  labelText: 'Type',
                                  border: OutlineInputBorder(),
                                  hintText: 'Select the type',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    typeController = EnumToString.fromString(
                                            OngoingTypes.values,
                                            value.toString().split('.')[1]) ??
                                        defaultType;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              child: const Text("SAVE"),
                              onPressed: () {
                                Navigator.pop(context);
                                final newItem = OngoingItem(
                                    title: titleController.text,
                                    percent:
                                        double.parse(percentController.text),
                                    type: typeController);
                                widget.localStorage
                                    .updateInProgressItem(index, newItem);
                              }),
                          TextButton(
                              child: const Text("CANCEL"),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ],
                      );
                    });
              },
              onDelete: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete"),
                        content: Text(
                            'Confirm to delete the ${index < ongoingList.length ? ongoingList[index].title : ""}'),
                        actions: [
                          TextButton(
                              child: const Text("DELETE"),
                              onPressed: () {
                                Navigator.pop(context);
                                widget.localStorage
                                    .deleteInProgressItem(ongoingList[index]);
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
            );
          }),
      Center(
        child: TextButton(
          child: const Text("ADD"),
          onPressed: () {
            titleController.text = "";
            percentController.text = '0';
            typeController = OngoingTypes.book;

            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Add"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                              border: OutlineInputBorder(),
                              hintText: 'Enter the title',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: TextFormField(
                            controller: percentController,
                            decoration: const InputDecoration(
                              labelText: 'Percent',
                              border: OutlineInputBorder(),
                              hintText: 'Enter the percent',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: DropdownButtonFormField(
                            value: typeController,
                            items: OngoingTypes.values
                                .map((value) => DropdownMenuItem(
                                    child: Text(
                                      value
                                          .toString()
                                          .split('.')[1]
                                          .toUpperCase(),
                                    ),
                                    value: value))
                                .toList(),
                            decoration: const InputDecoration(
                              labelText: 'Type',
                              border: OutlineInputBorder(),
                              hintText: 'Select the type',
                            ),
                            onChanged: (value) {
                              setState(() {
                                typeController = EnumToString.fromString(
                                        OngoingTypes.values,
                                        value.toString().split('.')[1]) ??
                                    defaultType;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                          child: const Text("SAVE"),
                          onPressed: () {
                            Navigator.pop(context);
                            final newItem = OngoingItem(
                                title: titleController.text,
                                percent: double.parse(percentController.text),
                                type: typeController);
                            widget.localStorage.addInProgressItem(newItem);
                          }),
                      TextButton(
                          child: const Text("CANCEL"),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                    ],
                  );
                });
          },
        ),
      )
    ]);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    titleController.dispose();
    percentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(),
    );
  }
}
