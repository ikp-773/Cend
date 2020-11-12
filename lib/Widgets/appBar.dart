import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({this.appBar});

  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
        child: GestureDetector(
          child: Image(
            image: AssetImage('assets/appBar/darkTheme.png'),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
