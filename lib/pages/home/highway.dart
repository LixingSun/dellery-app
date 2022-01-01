import 'package:flutter/material.dart';
import 'package:dellery_app/components/progress_bar.dart';

import '../../store.dart';

class HighwayContent extends StatefulWidget {
  const HighwayContent(
      {Key? key, required this.ongoingList, required this.localStorage})
      : super(key: key);

  final List<OngoingItem> ongoingList;
  final LocalStorage localStorage;

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
            icon: Icon(typeMap[widget.ongoingList[index].type]),
            onEdit: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return const AlertDialog(title: Text("Edit"));
                  });
            },
            onDelete: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Delete"),
                      content: Text(
                          'Confirm to delete the ${index < widget.ongoingList.length ? widget.ongoingList[index].title : ""}'),
                      actions: [
                        TextButton(
                            child: const Text("DELETE"),
                            onPressed: () {
                              Navigator.pop(context);
                              widget.localStorage.deleteInProgressItem(
                                  widget.ongoingList[index]);
                            }),
                        TextButton(
                            child: const Text("CANCEL"),
                            onPressed: () {
                              Navigator.pop(context);
                            })
                      ],
                    );
                  });
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _buildBody(),
    );
  }
}
