import 'package:flutter/material.dart';
import 'global.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'buttons.dart';
import 'usernameCard.dart';
import 'package:provider/provider.dart';
import 'avatarScreen.dart';
import 'avatar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: GestureDetector(
            child: Image(
              image: AssetImage('assets/logo.png'),
            ),
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30,
            left: 20,
            right: 20,
            bottom: 70,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Flexible(
                child: GestureDetector(
                  child: CircleAvatar(
                    backgroundImage:
                        AssetImage(Provider.of<Avatar>(context).avatar),
                    radius: 120,
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      context: context,
                      builder: (context) => SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: AvatarChooser(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              UserNameWidget(),
              Flexible(
                  child: SizedBox(
                height: 1500,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RoundedButton(
                    color: Color(0xFF2BCF6C),
                    text: "Send",
                    onPressed: onClickSend,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RoundedButton(
                    color: Color(0xFF9AF11F),
                    text: "Receive",
                    onPressed: onClickReceive,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onClickSend() async {
    if (await _checkAndAskPermissions()) {
      Router.navigator.pushNamed(Router.send);
    }
  }

  void onClickReceive() async {
    if (await _checkAndAskPermissions()) {
      Router.navigator.pushNamed(Router.receive);
    }
  }

  Future<bool> _checkAndAskPermissions() async {
    if (await allPermissionsGranted()) {
      return true;
    } else {
      Nearby().askLocationAndExternalStoragePermission();
    }

    return await allPermissionsGranted();
  }

  Future<bool> allPermissionsGranted() async =>
      await Nearby().checkExternalStoragePermission() &&
      await Nearby().checkLocationPermission();
}
