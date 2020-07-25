import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'transfer.dart';

class TransferElementTile extends StatefulWidget {
  final TransferElement element;

  TransferElementTile(this.element);

  @override
  _TransferElementTileState createState() => _TransferElementTileState();
}

class _TransferElementTileState extends State<TransferElementTile> {
  @override
  void initState() {
    widget.element.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    widget.element.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(widget.element.name),
                Flexible(
                  child: SizedBox(
                    width: 20,
                  ),
                ),
                Icon(widget.element.progress == 0
                    ? Icons.check_box_outline_blank
                    : widget.element.progress < 1
                        ? Icons.indeterminate_check_box
                        : Icons.check_box)
              ],
            ),
            LinearProgressIndicator(
              backgroundColor: Colors.lightGreenAccent,
              value: widget.element.progress,
            ),
          ],
        ),
      ),
    );
  }
}
