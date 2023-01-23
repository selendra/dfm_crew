
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mdw_crew/components/text_c.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class UpdateNow extends StatelessWidget {

  String? msg;
  bool? isAvailable;
  Function? downloadFunc;

  UpdateNow({super.key, required this.isAvailable, required this.msg, required this.downloadFunc});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
        //   child: LinearPercentIndicator(
        //     // width: MediaQuery.of(context).size.width / 1.5,
        //     lineHeight: 14.0,
        //     percent: percent! / 100,
        //     center: Text(
        //       "${percent}",
        //       style: new TextStyle(fontSize: 12.0),
        //     ),
        //     linearStrokeCap: LinearStrokeCap.roundAll,
        //     backgroundColor: Colors.grey,
        //     progressColor: Colors.blue,
        //   ),
        // ),

        MyText(text: msg, bottom: 30,),

        isAvailable! ? Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
            onPressed: () async {
        
              downloadFunc!();
            }, 
            child: MyText(
              width: MediaQuery.of(context).size.width,
              top: 20,
              bottom: 20,
              fontWeight: FontWeight.w600,
              text: "Update Now",
            )
          ),
        ) : Container()
      ],
    );
  }
}