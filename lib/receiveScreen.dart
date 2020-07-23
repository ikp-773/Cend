import 'package:flutter/material.dart';
import 'helper.dart';
import 'user.dart';
import 'global.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'buttons.dart';

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
                  backgroundColor: Colors.black38,
                  title: Text("${info.endpointName} wants to share files"),
                  actions: <Widget>[
                    ReceiveButton(
                      color: Color(0xFF4C992B),
                      text: Text("Deny"),
                      onPressed: () {
                        Router.navigator.pop();
                      },
                    ),
                    ReceiveButton(
                      text: Text("Allow"),
                      onPressed: () {
                        Nearby().acceptConnection(id,
                            onPayLoadRecieved:
                                PayloadHandler().onPayloadReceived,
                            onPayloadTransferUpdate: PayloadHandler()
                                .onPayloadTransferUpdateReceiver);
                        Router.navigator
                            .pushReplacementNamed(Router.receiverTransfer);
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
            title: Text("Some Error occurred :("),
            content: Text(e.toString()),
            actions: <Widget>[
              ReceiveButton(
                text: Text("Go back"),
                onPressed: () {
                  Router.navigator.pop();
                  Router.navigator.pop();
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