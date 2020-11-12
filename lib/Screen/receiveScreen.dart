import 'package:flutter/material.dart';
import '../Services/helper.dart';
import '../Providers/user.dart';
import '../Services/global.dart';
import 'package:nearby_connections/nearby_connections.dart';
import '../Widgets/buttons.dart';
import '../Widgets/appBar.dart';

class ReceiveScreen extends StatefulWidget {
  @override
  _ReceiveScreenState createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  bool advertising = false;

  @override
  void initState() {
    startAdvertising();
    // WidgetsBinding.instance.addPostFrameCallback((_) => );
    super.initState();
  }

  @override
  void dispose() {
    Nearby().stopAdvertising();
    super.dispose();
  }

  void startAdvertising() async {
    try {
      advertising = await Nearby().startAdvertising(
        getP<User>().nickName,
        Strategy.P2P_POINT_TO_POINT,
        onConnectionInitiated: (String id, ConnectionInfo info) {
          // Called whenever a discoverer requests connection
          if (info.isIncomingConnection) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  backgroundColor: Colors.black,
                  title: Text("${info.endpointName} wants to share files"),
                  actions: <Widget>[
                    ReceiveButton(
                      text: Text("Deny"),
                      color: Colors.white12,
                      onPressed: () {
                        RouteWay.navigator.pop();
                      },
                    ),
                    ReceiveButton(
                      text: Text("Allow"),
                      color: Color(0xFF4C992B),
                      onPressed: () {
                        Nearby().acceptConnection(id,
                            onPayLoadRecieved:
                                PayloadHandler().onPayloadReceived,
                            onPayloadTransferUpdate: PayloadHandler()
                                .onPayloadTransferUpdateReceiver);
                        RouteWay.navigator
                            .pushReplacementNamed(RouteWay.receiverTransfer);
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        onConnectionResult: (String id, Status status) {
          // Called when connection is accepted/rejected
        },
        onDisconnected: (String id) {
          // Called whenever a discoverer disconnects from advertiser
        },
        serviceId: serviceId,
      );
      setState(() {});
    } catch (e) {
      // platform exceptions like unable to start bluetooth or insufficient permissions
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            backgroundColor: Colors.black,
            title: Text("Some Error occurred :("),
            content: Text(e.toString()),
            actions: <Widget>[
              ReceiveButton(
                color: Color(0xFF4C992B),
                text: Text("Go back"),
                onPressed: () {
                  RouteWay.navigator.pop();
                  RouteWay.navigator.pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBar: AppBar(),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ),
            Text(advertising ? "Waiting for Sender" : "Initialising"),
          ],
        ),
      ),
    );
  }
}
