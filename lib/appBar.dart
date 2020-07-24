import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dark.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({this.appBar});

  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: GestureDetector(
          child: Image(
            image: AssetImage(Provider.of<Dark>(context).dark
                ? 'assets/appBar/darkTheme.png'
                : 'assets/appBar/lightTheme.png'),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
