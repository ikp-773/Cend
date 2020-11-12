import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Providers/transfer.dart';

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
        color: Colors.white12,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        margin: const EdgeInsets.all(8.0),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    widget.element.name,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                backgroundColor: Colors.black,
                value: widget.element.progress,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
