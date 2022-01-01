
import 'package:flutter/material.dart';
import 'package:dellery_app/components/progress_bar.dart';

import '../../store.dart';

class HighwayContent extends StatefulWidget {
  const HighwayContent({Key? key, required this.ongoingList}) : super(key: key);

  final List<OngoingItem> ongoingList;

  @override
  _HighwayContentState createState() => _HighwayContentState();
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
