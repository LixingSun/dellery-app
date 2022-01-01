import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:dellery_app/components/progress_bar.dart';

class HighwayContent extends StatefulWidget {
  const HighwayContent({Key? key, required this.ongoingList}) : super(key: key);

  final List<OngoingItem> ongoingList;

  @override
  _HighwayContentState createState() => _HighwayContentState();
}

enum OngoingTypes { book, article }

Map<OngoingTypes, IconData> typeMap = {
  OngoingTypes.book: Icons.book,
  OngoingTypes.article: Icons.article
};

class OngoingItem {
  String title;
  double percent;
  OngoingTypes type;

  OngoingItem({required this.title, required this.percent, required this.type});

  factory OngoingItem.fromJson(Map<String, dynamic> json) {
    final typeValue = EnumToString.fromString(
            OngoingTypes.values, json['type'] as String);

    return OngoingItem(
        title: json['title'] as String,
        percent: json['percent'] as double,
        type: typeValue ?? OngoingTypes.book);
  }

  Map<String, dynamic> toJson() =>
      {'title': title, 'percent': percent, 'type': type.toString()};
}

class _HighwayContentState extends State<HighwayContent> {
  Widget _buildBody() {
    return ListView.builder(
        itemCount: widget.ongoingList.length,
        itemBuilder: (context, index) {
          return ProgressBar(
              title: widget.ongoingList[index].title,
              percent: widget.ongoingList[index].percent,
              icon: Icon(typeMap[widget.ongoingList[index].type]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(),
    );
  }
}
