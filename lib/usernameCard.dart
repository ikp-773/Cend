import 'package:flutter/material.dart';
import 'user.dart';
import 'package:provider/provider.dart';
import 'global.dart';

class UserNameWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //edit the userNickName onTap
        var textController = TextEditingController();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Set NickName"),
              content: TextField(
                controller: textController,
                decoration: InputDecoration(
                  hintText: "Nick Name",
                ),
                autofocus: true,
                textAlign: TextAlign.center,
              ),
              actions: <Widget>[
                RaisedButton(
                  child: Text(
                    "Set",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    if (textController.text.trim().isNotEmpty) {
                      getP<User>().nickName = textController.text.trim();
                      Prefs.preferences.setString(
                          Prefs.nickName, textController.text.trim());
                      Router.navigator.pop(); // pop alertdialog
                    }
                  },
                )
              ],
            );
          },
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        color: Color(0x1F2ED85F),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Consumer<User>(
                builder: (_, user, __) {
                  return Text(
                    user.nickName,
                    style: TextStyle(fontSize: 25, color: Colors.green),
                  );
                },
              ),
              SizedBox(
                width: 15,
              ),
              Icon(
                Icons.edit,
                color: Colors.lightGreen,
              )
            ],
          ),
        ),
      ),
    );
  }
}
