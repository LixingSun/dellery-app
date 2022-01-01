import 'package:flutter/material.dart';
import 'package:dellery_app/components/progress_bar.dart';

class HighwayContent extends StatefulWidget {
  const HighwayContent({Key? key}) : super(key: key);

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

  OngoingItem(this.title, this.percent, this.type);
}

class _HighwayContentState extends State<HighwayContent> {
  final List<OngoingItem> _ongoingList = [
    OngoingItem("Test 1", 0.5, OngoingTypes.book),
    OngoingItem("Test 2", 0.5, OngoingTypes.book),
    OngoingItem("Test 3", 0.5, OngoingTypes.article)
  ];

  Widget _buildBody() {
    return ListView.builder(
        itemCount: _ongoingList.length,
        itemBuilder: (context, index) {
          return ProgressBar(
              title: _ongoingList[index].title,
              percent: _ongoingList[index].percent,
              icon: Icon(typeMap[_ongoingList[index].type]));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(),
    );
  }
}
