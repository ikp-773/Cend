import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.color, this.onPressed, this.text});
  final Color color;
  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          splashColor: null,
          onPressed: onPressed,
          minWidth: 150.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  SendButton({this.color, this.onPressed, this.text, this.icon});
  final Color color;
  final text;
  final Function onPressed;
  final Icon icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 80),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          splashColor: null,
          onPressed: onPressed,
          minWidth: 150.0,
          height: 42.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              text,
              SizedBox(
                width: 20,
              ),
              icon,
            ],
          ),
        ),
      ),
    );
  }
}

class ReceiveButton extends StatelessWidget {
  ReceiveButton({this.color, this.onPressed, this.text});
  final Color color;
  final text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          splashColor: null,
          onPressed: onPressed,
          minWidth: 100.0,
          height: 42.0,
          child: text,
        ),
      ),
    );
  }
}
