
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mdw_crew/components/text_c.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class InstallApp extends StatelessWidget {

  String? newVer;
  
  Function? installApps;

  InstallApp({super.key, required this.newVer, required this.installApps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        MyText(
          text: "New version $newVer download completely",
          bottom: 30,
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
            onPressed: () async {

              // setState(() {
              //   prog = 50;
              // });
              
              await installApps!();
            }, 
            child: MyText(
              width: MediaQuery.of(context).size.width,
              top: 20,
              bottom: 20,
              fontWeight: FontWeight.w600,
              text: "Install",
            )
          ),
        )
      ],
    );
  }
}