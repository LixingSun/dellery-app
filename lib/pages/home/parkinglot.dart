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
  @override
  Widget build(BuildContext context) {
    final list = widget.toDoList.map((toDoItem) {
      return Chip(label: Text(toDoItem));
    }).toList();

    list.add(const Chip(
        backgroundColor: Colors.transparent,
        label: Icon(
          Icons.add,
          size: 16,
          color: Colors.amber,
        )));

    return Wrap(spacing: 12, runSpacing: 12, children: list);
  }
}
