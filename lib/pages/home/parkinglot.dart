import 'package:flutter/material.dart';

import '../../store.dart';

class ParkingLotContent extends StatefulWidget {
  const ParkingLotContent(
      {Key? key, required this.toDoList, required this.localStorage})
      : super(key: key);

  final List<String> toDoList;
  final LocalStorage localStorage;

  @override
  _ParkingLotContentState createState() => _ParkingLotContentState();
}

class _ParkingLotContentState extends State<ParkingLotContent> {
  final titleController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final list = widget.toDoList.map((toDoItem) {
      return GestureDetector(
          onHorizontalDragEnd: (details) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Create"),
                    content: Text('Confirm to delete the $toDoItem'),
                    actions: [
                      TextButton(
                          child: const Text("SAVE"),
                          onPressed: () {
                            Navigator.pop(context);
                            widget.localStorage
                                .deleteToDoItem(toDoItem);
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
          child: Chip(label: Text(toDoItem)));
    }).toList();

    list.add(GestureDetector(
        onTap: () {
          titleController.text = "";

          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Create"),
                  content: Padding(
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
                  actions: [
                    TextButton(
                        child: const Text("SAVE"),
                        onPressed: () {
                          Navigator.pop(context);
                          widget.localStorage.addToDoItem(titleController.text);
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
        child: const Chip(
            backgroundColor: Colors.transparent,
            label: Icon(
              Icons.add,
              size: 16,
              color: Colors.amber,
            ))));

    return Wrap(spacing: 12, runSpacing: 12, children: list);
  }
}
