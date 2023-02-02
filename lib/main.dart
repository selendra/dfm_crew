import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:mdw_crew/backend/get_api.dart';
import 'package:mdw_crew/provider/download_p.dart';
import 'package:mdw_crew/provider/mdw_socket_p.dart';
import 'package:mdw_crew/registration/login.dart';
import 'package:mdw_crew/service/storage.dart';
import 'package:provider/provider.dart';


void main() async {

  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp ]);

  // await FlutterDownloader.initialize(
  //   debug: true, // optional: set to false to disable printing logs to console (default: true)
  //   ignoreSsl: true // option: set to false to disable working with http links (default: false)
  // );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MDWSocketProvider>(create: (context) => MDWSocketProvider()),
        ChangeNotifierProvider<AppUpdateProvider>(create: (context) => AppUpdateProvider())
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {

    // FlutterDownloader.registerCallback( AppUpdateProvider.downloadCallback );

    GetRequest.queryDFMApiJson().then((value) async {
      
      StorageServices.storeData(json.decode(value.body), 'dfm_api');

      // Initialize Socket
      Provider.of<MDWSocketProvider>(context, listen: false).initSocket(json.decode(value.body)['ws']);
    });

    super.initState();
  }
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DFM Crew',
      theme: ThemeData(
        fontFamily: "Barlow",
      ),
      home: const LoginPage(),
    );
  }
}