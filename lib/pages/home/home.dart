import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import 'package:dellery_app/pages/home/radio.dart';
import 'package:dellery_app/pages/home/parkinglot.dart';
import 'package:dellery_app/pages/home/skillset.dart';
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
  double temperature = 0;
  String weather = '';
  String weatherIcon = '01d';
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    super.initState();

    widget.localStorage.readStore();
    getWeather();
  }

  void getWeather() async {
    await dotenv.load(fileName: ".env");
    var url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=Chengdu,cn&APPID=${dotenv.env['WEATHER_API_APP_ID']}&units=metric');
    var response = await http.get(url);

    setState(() {
      final weatherData = json.decode(response.body);
      temperature = weatherData['main']['temp'];
      weather = weatherData['weather'][0]['main'];
      weatherIcon = weatherData['weather'][0]['icon'];
    });
  }

  @override
  Widget build(BuildContext context) {
    final localStorage = widget.localStorage;
    final today = DateFormat('yMMMEd').format(DateTime.now());

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(today),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.green[300],
                      backgroundImage:
                          AssetImage('assets/weather/$weatherIcon@2x.png'),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 6),
                      child: Text('$weather, ${temperature.round()}°C')),
                ],
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        final directory =
                            (await getApplicationDocumentsDirectory()).path;
                        String fileName =
                            DateTime.now().microsecondsSinceEpoch.toString();

                        screenshotController.captureAndSave(directory,
                            fileName: 'dellery_screenshot_$fileName.png');
                      },
                      child: const Icon(
                        Icons.screenshot_outlined,
                        size: 32,
                        color: Colors.white,
                      ))
                ],
              )
            ],
          ),
        ),
        body: Screenshot(
            controller: screenshotController,
            child: Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/bg.jpg"), fit: BoxFit.cover)),
                child: LayoutBuilder(builder:
                    (BuildContext context, BoxConstraints constraints) {
                  bool useVerticalLayout =
                      MediaQuery.of(context).size.width < 1024;
                  if (useVerticalLayout) {
                    return SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                          SizedBox(
                              height: 400,
                              child: HomeCard(
                                  title: "进展/Highway",
                                  child: HighwayContent(
                                    ongoingList: localStorage.inProgressList,
                                    localStorage: localStorage,
                                  ))),
                          SizedBox(
                              height: 400,
                              child: HomeCard(
                                  title: "待学/Parking Lot",
                                  child: ParkingLotContent(
                                    toDoList: localStorage.toDoList,
                                    localStorage: localStorage,
                                  ))),
                          SizedBox(
                              height: 400,
                              child: HomeCard(
                                  title: "技能/Skillset",
                                  child: SkillsetContent(
                                      skillset: localStorage.skillset,
                                      localStorage: localStorage))),
                          SizedBox(
                              height: 400,
                              child: HomeCard(
                                  title: "灵感/Radio",
                                  child: RadioContent(
                                    ideaList: localStorage.ideaList,
                                    localStorage: localStorage,
                                  ))),
                          const SizedBox(
                              height: 400,
                              child: HomeCard(
                                  title: "工具/Rest Area", child: Text("")))
                        ]));
                  } else {
                    return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                Expanded(
                                    child: HomeCard(
                                        title: "进展/Highway",
                                        child: HighwayContent(
                                          ongoingList:
                                              localStorage.inProgressList,
                                          localStorage: localStorage,
                                        ))),
                                Expanded(
                                    child: HomeCard(
                                        title: "待学/Parking Lot",
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
                                        title: "技能/Skillset",
                                        child: SkillsetContent(
                                            skillset: localStorage.skillset,
                                            localStorage: localStorage)))
                              ],
                            ),
                          ),
                          Expanded(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                Expanded(
                                    child: HomeCard(
                                        title: "灵感/Radio",
                                        child: RadioContent(
                                          ideaList: localStorage.ideaList,
                                          localStorage: localStorage,
                                        ))),
                                const Expanded(
                                    child: HomeCard(
                                        title: "工具/Rest Area",
                                        child: Text(""))),
                              ])),
                        ]);
                  }
                }))));
  }
}
