import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mdw_crew/constants/download_status.dart';
import 'package:mdw_crew/service/storage.dart';

import '../components/dialog_c.dart';
import '../components/text_c.dart';

class AppUpdateProvider with ChangeNotifier {

  int progress = 0;

  bool isAvailale = false;
  bool isUpdate = false;

  ReceivePort _port = ReceivePort();

  List<String> msg = [];

  String? newVer;

  void registerIsolation(BuildContext context, Function? installApps) async {

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
      _port.listen((dynamic data) async {
        print("listen _port $data");
        String id = data[0];
        DownloadTaskStatus status = data[1];
        print("status.value ${status.value}");
        if (status.value == 4){
          await DialogCom().dialogMessage(
            context, 
            title: MyText(text: "Oops",), 
            content: MyText(text: "It seem you already install"), 
            action2: TextButton(
              onPressed: () async {
                await installApps!();
              }, 
              child: MyText(text: "Install now",)
            )
          );
        }

        if (data[2] != -1) {
          progress = data[2];

          if (progress == 100){
            await StorageServices.storeData(DLStatus.DOWNLOADED.toString(), dotenv.get("DOWNLOAD_STATUS"));
          }
          
        }

        notifyListeners();
        
      });
  }

  void dispose(){

    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort? send = IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
    
  }
}