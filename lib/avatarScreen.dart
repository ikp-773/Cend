import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'avatar.dart';

class AvatarChooser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 390,
        decoration: BoxDecoration(
          color: Color(0x9F68C140),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  UserAvatar(avatarNew: 'assets/Boy1.png'),
                  SizedBox(
                    width: 10,
                  ),
                  UserAvatar(avatarNew: 'assets/Girl1.png'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  UserAvatar(
                    avatarNew: 'assets/Girl2.png',
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  UserAvatar(
                    avatarNew: 'assets/Boy2.png',
                  )
                ],
              ),
            ],
          ),
        ));
  }
}

class UserAvatar extends StatelessWidget {
  UserAvatar({this.avatarNew});
  final String avatarNew;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: CircleAvatar(
        radius: 60,
        backgroundImage: AssetImage(avatarNew),
      ),
      onTap: () {
        Provider.of<Avatar>(context, listen: false).newAvatar(avatarNew);
        Navigator.pop(context);
      },
    );
  }
}
