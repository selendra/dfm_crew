import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mdw_crew/backend/get_api.dart';
import 'package:mdw_crew/provider/mdw_socket_p.dart';
import 'package:mdw_crew/registration/login.dart';
import 'package:mdw_crew/service/storage.dart';
import 'package:provider/provider.dart';

void main() async {

  await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([ DeviceOrientation.portraitUp ]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MDWSocketProvider>(create: (context) => MDWSocketProvider())
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

    GetRequest.queryDFMApiJson().then((value) {
      print("value ${value.body}");
      StorageServices.storeData(json.decode(value.body), 'dfm_api');
    });
    Provider.of<MDWSocketProvider>(context, listen: false).initSocket();
    super.initState();
  }
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Barlow",
      ),
      home: LoginPage(),
    );
  }
}