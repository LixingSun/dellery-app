import 'package:flutter/material.dart';

import 'package:dellery_app/store.dart';
import 'package:dellery_app/pages/home/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => LocalStorage(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalStorage>(builder: (context, localStorage, child) {
      return MaterialApp(
        title: 'Dellery',
        theme: ThemeData(
            fontFamily: "Play",
            brightness: Brightness.dark,
            primarySwatch: Colors.green,
            scaffoldBackgroundColor: Colors.black,
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.green[900],
            )),
        home: HomePage(localStorage: localStorage),
        debugShowCheckedModeBanner: false,
      );
    });
  }
}
