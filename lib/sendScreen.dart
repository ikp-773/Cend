import 'package:flutter/material.dart';
import 'helper.dart';
import 'endpoints.dart';
import 'files.dart';
import 'user.dart';
import 'global.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'buttons.dart';
import 'fileListTile.dart';

class SendScreen extends StatefulWidget {
  @override
  _SendScreenState createState() => _SendScreenState();
}

class _SendScreenState extends State<SendScreen> {
  @override
  void initState() {
    // start discovery
    startDiscovery();
    // WidgetsBinding.instance.addPostFrameCallback((_) => );
    super.initState();
  }

  @override
  void dispose() {
    // stop discovery
    Nearby().stopDiscovery();
    super.dispose();
  }

  void startDiscovery() async {
    try {
      await Nearby()
          .startDiscovery(getP<User>().nickName, Strategy.P2P_POINT_TO_POINT,
              onEndpointFound: (String id, String nickName, String serviceId) {
        getP<Endpoints>().addUser(id, nickName);
      }, onEndpointLost: (String id) {
        getP<Endpoints>().removeUser(id);
      }, serviceId: serviceId);
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
              RaisedButton(
                child: Text("Go back"),
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
    return SafeArea(
      child: Scaffold(
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
        body: SizedBox(
          height: 1000,
          child: Consumer<Files>(
            builder: (context, files, child) {
              if (files.files.length == 0) {
                return Center(
                  child: Text("No files selected"),
                );
              } else
                return ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  itemCount: files.files.length,
                  itemBuilder: (context, index) {
                    return FileTile(
                        task: files.files[index].path.split('/').last);
                  },
                );
//				  Text("${files.files.length} files selected");
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFFA4DE00),
          child: Icon(
            Icons.add,
            size: 30,
          ),
          onPressed: () async {
            getP<Files>().add(await FilePicker.getMultiFile());
          },
        ),
        bottomNavigationBar: Consumer<Files>(
          builder: (_, files, __) {
            return SendButton(
              color: Color(0xFF2BCF6C),
              text: Text(
                "Send",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              icon: Icon(
                Icons.send,
                color: Colors.black,
              ),
              onPressed: files.files.length < 1
                  ? null
                  : () {
                      //open list of advertisers to send files to..
                      showAdvertisersDialog();
                    },
            );
          },
        ),
//          child: SizedBox(
//            height: 100,
//            child: Consumer<Files>(
//              builder: (context, files, child) {
//                return ListView.builder(
//                  itemCount: files.files.length,
//                  scrollDirection: Axis.vertical,
//                  itemBuilder: (context, index) {
//                    return FileTile(
//                      task: files.files[index].path,
//                    );
//                  },
//                );
////				  Text("${files.files.length} files selected");
//              },
//            ),
//          ),
      ),
    );
  }

  void showAdvertisersDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Receivers Near You"),
          content: Container(
            width: double.maxFinite,
            child: Center(
              child: Consumer<Endpoints>(
                builder: (_, endpoints, __) {
                  if (endpoints.externalUsers.length < 1)
                    return CircularProgressIndicator();

                  return EndpointListView(endpoints);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class EndpointListView extends StatefulWidget {
  final Endpoints endpoints;
  EndpointListView(
    this.endpoints, {
    Key key,
  }) : super(key: key);

  @override
  _EndpointListViewState createState() => _EndpointListViewState();
}

class _EndpointListViewState extends State<EndpointListView> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.endpoints.externalUsers.length,
      itemBuilder: (_, i) {
        return Padding(
          padding: EdgeInsets.all(6),
          child: FlatButton(
            child: Text("${widget.endpoints.externalUsers[i].nickName}"),
            onPressed: () {
              // request connection to advertiser
              requestConnection(i, context);
            },
          ),
        );
      },
    );
  }

  void requestConnection(int i, BuildContext context) {
    Nearby().requestConnection(
      getP<User>().nickName,
      widget.endpoints.externalUsers[i].endpointId,
      onConnectionInitiated: (id, info) {
        if (!info.isIncomingConnection) {
          Nearby().acceptConnection(
            id,
            onPayLoadRecieved: null,
            onPayloadTransferUpdate:
                PayloadHandler().onPayloadTransferUpdateSender,
          );
        }
      },
      onConnectionResult: (id, status) {
        //send files to user..
        if (status == Status.CONNECTED) {
          Router.navigator
              .pushReplacementNamed(Router.senderTransfer, arguments: id);
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Connection was Rejected"),
            ),
          );
        }
      },
      onDisconnected: (id) {},
    );
  }
}
