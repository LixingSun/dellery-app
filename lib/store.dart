import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

enum OngoingTypes { book, article, course }

Map<OngoingTypes, IconData> typeMap = {
  OngoingTypes.book: Icons.book,
  OngoingTypes.article: Icons.article,
  OngoingTypes.course: Icons.fact_check,
};

class OngoingItem {
  String title;
  double percent;
  OngoingTypes type;

  OngoingItem({required this.title, required this.percent, required this.type});

  factory OngoingItem.fromJson(Map<String, dynamic> json) {
    final typeValue = EnumToString.fromString(
        OngoingTypes.values, json['type'].toString().split('.')[1]);

    return OngoingItem(
        title: json['title'] as String,
        percent: json['percent'] as double,
        type: typeValue ?? OngoingTypes.book);
  }

  Map<String, dynamic> toJson() =>
      {'title': title, 'percent': percent, 'type': type.toString()};
}

class StoreObject {
  List<OngoingItem> inProgressList;
  List<String> toDoList;

  StoreObject(
      {this.inProgressList = const <OngoingItem>[],
      this.toDoList = const <String>[]});

  factory StoreObject.fromJson(Map<String, dynamic> json) {
    final inProgressData = json['inProgressList'] as List<dynamic>;
    final toDoData = json['toDoList'] as List<dynamic>;

    return StoreObject(
        inProgressList:
            inProgressData.map((item) => OngoingItem.fromJson(item)).toList(),
        toDoList: toDoData.map((item) => item.toString()).toList());
  }

  Map<String, dynamic> toJson() =>
      {'inProgressList': inProgressList, 'toDoList': toDoList};
}

class LocalStorage extends ChangeNotifier {
  StoreObject store = StoreObject();

  List<OngoingItem> get inProgressList {
    return store.inProgressList;
  }

  List<String> get toDoList {
    return store.toDoList;
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/store.json');
  }

  void readStore() async {
    stderr.writeln("read");

    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      store = StoreObject.fromJson(json.decode(contents));
    } catch (e) {
      stderr.writeln(e);
      // If encountering an error, return 0
      store = StoreObject();
    } finally {
      notifyListeners();
    }
  }

  void addInProgressItem(OngoingItem newItem) {
    store.inProgressList.add(newItem);
    notifyListeners();

    writeStore(store);
  }

  void deleteInProgressItem(OngoingItem item) {
    store.inProgressList.remove(item);
    notifyListeners();

    writeStore(store);
  }

  void updateInProgressItem(index, OngoingItem newItem) {
    store.inProgressList[index] = newItem;
    notifyListeners();

    writeStore(store);
  }

  void addToDoItem(newItem) {
    store.toDoList.add(newItem);
    notifyListeners();

    writeStore(store);
  }

  Future<File> writeStore(StoreObject newStore) async {
    stderr.writeln("write");

    final file = await _localFile;

    // Write the file
    return file.writeAsString(json.encode(newStore));
  }
}
