
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mdw_crew/components/text_c.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadProgress extends StatelessWidget {

  int? percentage;

  DownloadProgress({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [

        Icon(Icons.download, size: 30,),
        
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15),
          child: LinearPercentIndicator(
            // width: MediaQuery.of(context).size.width / 1.5,
            lineHeight: 14.0,
            percent: percentage! / 100,
            center: Text(
              "$percentage",
              style: TextStyle(fontSize: 12.0),
            ),
            linearStrokeCap: LinearStrokeCap.roundAll,
            backgroundColor: Colors.grey,
            progressColor: Colors.blue,
          ),
        ),

      ],
    );
  }
}