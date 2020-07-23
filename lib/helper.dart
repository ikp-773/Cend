import 'dart:io';
import 'transfer.dart';
import 'package:nearby_connections/nearby_connections.dart';
import 'global.dart';

class PayloadHandler {
  // making this singleton
  static PayloadHandler _handler;
  factory PayloadHandler() {
    if (_handler == null) {
      _handler = PayloadHandler._();
    }
    return _handler;
  }
  PayloadHandler._();

  /// called on receiver end
  void onPayloadReceived(String endid, Payload payload) {
    // could be meta or filename or file payload
    if (payload.type == PayloadType.BYTES) {
      String rawdata = String.fromCharCodes(payload.bytes);
      List<String> data = rawdata.split(":::");
      if (data.length < 1) {
        print("sender error: empty payload");
        return;
      }
      if (data[0] == "FILE") {
        getP<Transfer>().mappedElements[int.parse(data[1])] = getP<Transfer>()
            .transferElements
            .firstWhere((e) => data[2] == e.name);
        // set flag to 1 or increment it by 1
        getP<Transfer>().flagForElement[int.parse(data[1])] =
            (getP<Transfer>().flagForElement[int.parse(data[1])] ?? 0) + 1;

        if (getP<Transfer>().flagForElement[int.parse(data[1])] > 1) {
          // rename this file
          renamePayload(int.parse(data[1]));
        }
      } else if (data[0] == "META") {
        for (int i = 1; i < data.length; i += 2) {
          getP<Transfer>().addWithNoNotification(
            data[i],
            int.parse(data[i + 1]),
          );
        }
        getP<Transfer>().notify();
      }
    } else {
      // file payload

      // set flag to 1 or increment it by 1 for knowing when to rename
      getP<Transfer>().flagForElement[payload.id] =
          (getP<Transfer>().flagForElement[payload.id] ?? 0) + 1;

      // save file path for later use
      getP<Transfer>().payloadFilePaths[payload.id] = payload.filePath;
    }
  }

  void onPayloadTransferUpdateReceiver(
    String endpointId,
    PayloadTransferUpdate ptu,
  ) {
    getP<Transfer>().mappedElements[ptu.id]?.progress =
        (ptu.bytesTransferred / ptu.totalBytes);
    getP<Transfer>().mappedElements[ptu.id]?.status = ptu.status;

    if (ptu.status == PayloadStatus.SUCCESS &&
        getP<Transfer>().flagForElement.containsKey(ptu.id) &&
        getP<Transfer>().flagForElement[ptu.id] > 1) {
      // rename this file
      renamePayload(ptu.id);
    }
  }

  void onPayloadTransferUpdateSender(
    String endpointId,
    PayloadTransferUpdate ptu,
  ) {
    getP<Transfer>().mappedElements[ptu.id]?.progress =
        (ptu.bytesTransferred / ptu.totalBytes);
    getP<Transfer>().mappedElements[ptu.id]?.status = ptu.status;
  }

  void renamePayload(int id) async {
    try {
      File file = File(getP<Transfer>().payloadFilePaths[id]);
      File f = await file.rename(
          file.parent.path + "/" + getP<Transfer>().mappedElements[id].name);
      getP<Transfer>().mappedElements[id].finalFilePath = f.path;
    } catch (e) {
      print(e);
    }
  }
}
