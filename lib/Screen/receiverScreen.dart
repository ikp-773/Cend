import 'package:flutter/material.dart';
import '../transfer.dart';
import '../global.dart';
import '../elementTile.dart';
import 'package:provider/provider.dart';
import '../Widgets/appBar.dart';

class ReceiverTransferScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          appBar: AppBar(),
        ),
        body: Consumer<Transfer>(
          builder: (_, transfer, __) {
            if (transfer.transferElements.length < 1) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Scaffold(
                body: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  itemCount: getP<Transfer>().transferElements.length,
                  itemBuilder: (context, i) {
                    return TransferElementTile(
                      getP<Transfer>().transferElements[i],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
