import 'package:flutter/material.dart';
import 'package:mdw_crew/model/mdw_m.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MDWSocketProvider with ChangeNotifier {

  VGA vga = VGA();
  TGA tga = TGA();

  IO.Socket _socket = IO.io(
    'https://socket.doformetaverse.com', <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    }
  );
  
  void initSocket(){

    _socket.connect();

    _socket.onConnect((_) {

      print('connect');
      
      listenAdmission();

      getAllData();

    });
    
  }

  void emitSocket(String mgs, Map<String, dynamic> data){
    _socket.emit(mgs, [ data ]);
  }

  void dispose(){

    _socket.disconnect();
    _socket.dispose();
  }

  void getAllData(){
    print("getAllData");
    _socket.emit('getAllData');

  }
  
  void listenAdmission(){

    _socket.on('allData', (data) {
      print("allData");
      print("data $data");
      vga = VGA().fromSocket(data['vga']);

      print("vga ${vga.checkIn.toString()}");

      tga = TGA().fromSocket(data['tga']);

      notifyListeners();
    });

    // _socket.emit("check-in", { 'hallId': 'vga' });

  }

  void test(){

    _socket.emit("check-in", { 'hallId': 'vga' });
  }

  void listenCheckOut(){

    _socket.on('event', (data) {
      print("listenAdmission ata $data");
    });

  }

}