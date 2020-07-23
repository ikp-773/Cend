import 'package:flutter/material.dart';

class FileTile extends StatelessWidget {
  FileTile({this.task});
  final String task;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        color: Colors.white12,
        child: ListTile(
          title: Text(
            task,
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
