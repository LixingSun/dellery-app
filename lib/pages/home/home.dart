import 'package:dellery_app/pages/home/parkinglot.dart';
import 'package:dellery_app/pages/home/skillset.dart';
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
        backgroundColor: Colors.green[900],
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
                            ongoingList: localStorage.inProgressList,
                            localStorage: localStorage,
                          ))),
                  Expanded(
                      child: HomeCard(
                          title: "Parking Lot",
                          child: ParkingLotContent(
                            toDoList: localStorage.toDoList,
                            localStorage: localStorage,
                          ))),
                ])),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: HomeCard(
                          title: "Skillset",
                          child: SkillsetContent(
                              skillset: localStorage.skillset,
                              localStorage: localStorage)))
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
    );
  }
}
