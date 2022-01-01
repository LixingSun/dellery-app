import 'package:flutter/material.dart';

import 'package:dellery_app/components/card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                        Expanded(
                            child: HomeCard(title: "Highway", child: Text(""))),
                        Expanded(
                            child: HomeCard(
                                title: "Parking Lot", child: Text(""))),
                      ])),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: const [
                        Expanded(
                            child: HomeCard(title: "Skillset", child: Text("")))
                      ],
                    ),
                  ),
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: const [
                        Expanded(
                            child: HomeCard(title: "Radio", child: Text(""))),
                        Expanded(
                            child:
                                HomeCard(title: "Rest Area", child: Text(""))),
                      ])),
                ])));
  }
}
