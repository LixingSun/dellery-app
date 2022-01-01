import 'dart:math';

import 'package:flutter/material.dart';

import 'package:dellery_app/components/card.dart';
import './highway.dart';

import '../../store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.localStorage}) : super(key: key);

  final LocalStorage localStorage;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    widget.localStorage.readStore();
  }

  @override
  Widget build(BuildContext context) {
    final localStorage = widget.localStorage;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent[700],
        title: const Text("Title"),
      ),
      body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                  Expanded(
                      child: HomeCard(
                          title: "Highway",
                          child: HighwayContent(
                              ongoingList: localStorage.store.inProgressList))),
                  const Expanded(
                      child: HomeCard(title: "Parking Lot", child: Text(""))),
                ])),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Expanded(child: HomeCard(title: "Skillset", child: Text("")))
                ],
              ),
            ),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                  Expanded(child: HomeCard(title: "Radio", child: Text(""))),
                  Expanded(
                      child: HomeCard(title: "Rest Area", child: Text(""))),
                ])),
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newStore = localStorage.store;
          newStore.inProgressList = [
            OngoingItem(
                title: "Test 1",
                percent: Random().nextDouble(),
                type: OngoingTypes.book),
            OngoingItem(
                title: "Test 2",
                percent: Random().nextDouble(),
                type: OngoingTypes.book),
            OngoingItem(
                title: "Test 3",
                percent: Random().nextDouble(),
                type: OngoingTypes.article)
          ];

          localStorage.writeStore(newStore);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
