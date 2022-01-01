import 'package:flutter/material.dart';

class HighwayContent extends StatefulWidget {
  const HighwayContent({Key? key}) : super(key: key);

  @override
  _HighwayContentState createState() => _HighwayContentState();
}

class OngoingItem {
  String title;
  double percent;

  OngoingItem(this.title, this.percent);
}

class _HighwayContentState extends State<HighwayContent> {
  final List<OngoingItem> _ongoingList = [
    OngoingItem("Test 1", 0.5),
    OngoingItem("Test 2", 0.5),
    OngoingItem("Test 3", 0.5)
  ];

  Widget _buildBody() {
    return ListView.builder(
        itemCount: _ongoingList.length,
        itemBuilder: (context, index) {
          return Text(
              '${_ongoingList[index].title} ${_ongoingList[index].percent.toString()}');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(),
    );
  }
}
