import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:dellery_app/pages/home/highway.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class StoreObject {
  List<OngoingItem> inProgressList;

  StoreObject({this.inProgressList = const <OngoingItem>[]});

  factory StoreObject.fromJson(Map<String, dynamic> json) {
    final List data = json['inProgressList'] as List<dynamic>;
    final list =
        data.map((item) => OngoingItem.fromJson(item)).toList();

    return StoreObject(inProgressList: list);
  }

  Map<String, dynamic> toJson() => {'inProgressList': inProgressList};
}

class LocalStorage extends ChangeNotifier {
  StoreObject store = StoreObject();

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
      // If encountering an error, return 0
      store = StoreObject();
    } finally {
      notifyListeners();
    }
  }

  Future<File> writeStore(StoreObject newStore) async {
    store = newStore;

    notifyListeners();

    stderr.writeln("write");

    final file = await _localFile;

    // Write the file
    return file.writeAsString(json.encode(newStore));
  }
}
