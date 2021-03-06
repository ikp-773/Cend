import 'package:flutter/material.dart';
import '../Services/global.dart';
import 'package:nearby_connections/nearby_connections.dart';
import '../Widgets/buttons.dart';
import '../Widgets/usernameCard.dart';
import 'package:provider/provider.dart';
import 'avatarScreen.dart';
import '../Providers/avatar.dart';
import '../Widgets/appBar.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
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
            mainAxisAlignment: MainAxisAlignment.start,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }

  void onClickSend() async {
    if (await _checkAndAskPermissions()) {
      RouteWay.navigator.pushNamed(RouteWay.send);
    }
  }

  void onClickReceive() async {
    if (await _checkAndAskPermissions()) {
      RouteWay.navigator.pushNamed(RouteWay.receive);
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
