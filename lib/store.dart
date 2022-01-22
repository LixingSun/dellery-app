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
  int percent;
  OngoingTypes type;

  OngoingItem({required this.title, required this.percent, required this.type});

  factory OngoingItem.fromJson(Map<String, dynamic> json) {
    final typeValue = EnumToString.fromString(
        OngoingTypes.values, json['type'].toString().split('.')[1]);

    return OngoingItem(
        title: json['title'] as String,
        percent: json['percent'] as int,
        type: typeValue ?? OngoingTypes.book);
  }

  Map<String, dynamic> toJson() =>
      {'title': title, 'percent': percent, 'type': type.toString()};
}

class SkillItem {
  String title;
  int rating;

  SkillItem({required this.title, required this.rating});

  factory SkillItem.fromJson(Map<String, dynamic> json) {
    return SkillItem(
        title: json['title'], rating: int.parse(json['rating'].toString()));
  }

  Map<String, dynamic> toJson() => {'title': title, 'rating': rating};
}

class DiceOptionSet {
  String name;
  List<String> options;

  DiceOptionSet({required this.name, required this.options});

  factory DiceOptionSet.fromJson(Map<String, dynamic> json) {
    final optionsData = json['options'] as List<dynamic>;

    return DiceOptionSet(
        name: json['name'],
        options: optionsData.map((option) => option.toString()).toList());
  }

  Map<String, dynamic> toJson() => {'name': name, 'options': options};
}

class StoreObject {
  List<OngoingItem> inProgressList;
  List<String> toDoList;
  List<SkillItem> skillset;
  List<String> ideaList;
  List<DiceOptionSet> diceOptionSetList;

  StoreObject(
      {required this.inProgressList,
      required this.toDoList,
      required this.skillset,
      required this.ideaList,
      required this.diceOptionSetList});

  factory StoreObject.fromJson(Map<String, dynamic> json) {
    final inProgressData = (json['inProgressList'] ?? []) as List<dynamic>;
    final toDoData = (json['toDoList'] ?? []) as List<dynamic>;
    final skillData = (json['skillset'] ?? []) as List<dynamic>;
    final ideaListData = (json['ideaList'] ?? []) as List<dynamic>;
    final diceOptionSetListData =
        (json['diceOptionSetList'] ?? []) as List<dynamic>;

    return StoreObject(
      inProgressList:
          inProgressData.map((item) => OngoingItem.fromJson(item)).toList(),
      toDoList: toDoData.map((item) => item.toString()).toList(),
      skillset: skillData.map((item) => SkillItem.fromJson(item)).toList(),
      ideaList: ideaListData.map((item) => item.toString()).toList(),
      diceOptionSetList: diceOptionSetListData
          .map((item) => DiceOptionSet.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'inProgressList': inProgressList,
        'toDoList': toDoList,
        'skillset': skillset,
        'ideaList': ideaList,
        'diceOptionSetList': diceOptionSetList
      };
}

class LocalStorage extends ChangeNotifier {
  StoreObject store = StoreObject(
      inProgressList: [],
      toDoList: [],
      skillset: [],
      ideaList: [],
      diceOptionSetList: []);

  List<OngoingItem> get inProgressList {
    return store.inProgressList;
  }

  List<String> get toDoList {
    return store.toDoList;
  }

  List<SkillItem> get skillset {
    return store.skillset;
  }

  List<String> get ideaList {
    return store.ideaList;
  }

  List<DiceOptionSet> get diceOptionSetList {
    return store.diceOptionSetList;
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
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      store = StoreObject.fromJson(json.decode(contents));
    } catch (e) {
      stderr.writeln('Parse Store Failed');
      stderr.writeln(e);
      // If encountering an error, return 0
      store = StoreObject(
          inProgressList: [],
          toDoList: [],
          skillset: [],
          ideaList: [],
          diceOptionSetList: []);
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

  void addToDoItem(String newItem) {
    store.toDoList.add(newItem);
    notifyListeners();

    writeStore(store);
  }

  void deleteToDoItem(String item) {
    store.toDoList.remove(item);
    notifyListeners();

    writeStore(store);
  }

  void updateSkillset(List<SkillItem> newValue) {
    store.skillset = newValue;
    notifyListeners();

    writeStore(store);
  }

  void addSkillset(SkillItem newValue) {
    store.skillset.add(newValue);
    notifyListeners();

    writeStore(store);
  }

  void removeSkillset(String title) {
    store.skillset.removeWhere((element) => element.title == title);
    notifyListeners();

    writeStore(store);
  }

  void addIdeaItem(String newItem) {
    store.ideaList.add(newItem);
    notifyListeners();

    writeStore(store);
  }

  void deleteIdeaItem(String item) {
    store.ideaList.remove(item);
    notifyListeners();

    writeStore(store);
  }

  void addDiceOptionSet(name, options) {
    store.diceOptionSetList.add(DiceOptionSet(name: name, options: options));
    notifyListeners();

    writeStore(store);
  }

  Future<File> writeStore(StoreObject newStore) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsString(json.encode(newStore));
  }
}
