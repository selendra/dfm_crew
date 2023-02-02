import 'package:flutter/material.dart';
import 'package:mdw_crew/model/mdw_m.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MDWSocketProvider with ChangeNotifier {

  VGA vga = VGA();
  TGA tga = TGA();

  IO.Socket? _socket;
  
  void initSocket(String url){
    print("initSocket url $url");
    _socket = IO.io(
      url, <String, dynamic>{
        'autoConnect': true,
        'transports': ['websocket'],
      }
    );

    _socket!.connect();

    _socket!.onConnect((_) {
      
      listenAdmission();

      getAllData();

    });
    
  }

  void emitSocket(String mgs, Map<String, dynamic> data){
    _socket!.emit(mgs, [ data ]);
  }

  void dispose(){

    _socket!.disconnect();
    _socket!.dispose();
  }

  void getAllData(){
    _socket!.emit('getAllData');

  }
  
  void listenAdmission(){

    _socket!.on('allData', (data) {

      vga = VGA().fromSocket(data['vga']);

      tga = TGA().fromSocket(data['tga']);

      notifyListeners();
    });

    // _socket.emit("check-in", { 'hallId': 'vga' });

  }

  void test(){

    _socket!.emit("check-in", { 'hallId': 'vga' });
  }

  void listenCheckOut(){

    _socket!.on('event', (data) {
      // print("listenAdmission ata $data");
    });

  }

}