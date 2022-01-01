import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.title,
    required this.percent,
    required this.icon,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  final String title;
  final double percent;
  final Widget icon;
  final Function onEdit;
  final Function onDelete;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onEdit();
        },
        onHorizontalDragEnd: (details) {
          onDelete();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: LinearPercentIndicator(
              linearStrokeCap: LinearStrokeCap.butt,
              lineHeight: 40.0,
              progressColor: Colors.deepPurple.shade600,
              backgroundColor: Colors.grey[800],
              percent: percent,
              trailing: icon,
              center: Text(title, style: const TextStyle(fontSize: 16))),
        ));
  }
}
