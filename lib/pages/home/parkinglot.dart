import 'package:dellery_app/components/button.dart';
import 'package:flutter/material.dart';
import 'package:dellery_app/constants/colors.dart';
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
  final _addFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    titleController.dispose();
    super.dispose();
  }

  String? titleValidator(value) {
    if (value.isEmpty) return "Cannot be empty";

    return null;
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
                    title: const Text("Delete"),
                    content: Text('Confirm to delete the $toDoItem'),
                    actions: [
                      CustomTextButton(
                        child: const Text("DELETE"),
                        onPressed: () {
                          Navigator.pop(context);
                          widget.localStorage.deleteToDoItem(toDoItem);
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
                  content: Form(
                      key: _addFormKey,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          controller: titleController,
                          validator: titleValidator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                            labelText: 'Title',
                            border: OutlineInputBorder(),
                            hintText: 'Enter the title',
                          ),
                        ),
                      )),
                  actions: [
                    CustomTextButton(
                      child: const Text("SAVE"),
                      onPressed: () {
                        if (_addFormKey.currentState!.validate()) {
                          Navigator.pop(context);
                          widget.localStorage.addToDoItem(titleController.text);
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
        child: Chip(
            backgroundColor: Colors.transparent,
            label: Icon(
              Icons.add,
              size: 20,
              color: toolColor,
            ))));

    return Wrap(spacing: 12, runSpacing: 12, children: list);
  }
}
