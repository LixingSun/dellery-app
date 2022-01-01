import 'package:flutter/material.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({Key? key, required this.title, required this.child})
      : super(key: key);

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(8.0),
        color: Colors.grey.shade900.withOpacity(0.7),
        child: Column(children: [
          Text(
            title.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                height: 2),
          ),
          Expanded(child: child)
        ]));
  }
}
