import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lottie/lottie.dart';
import 'package:mdw_crew/auth/google_login_a.dart';
import 'package:mdw_crew/backend/post_api.dart';
import 'package:mdw_crew/components/dialog_c.dart';
import 'package:mdw_crew/components/input_field_c.dart';
import 'package:mdw_crew/components/text_c.dart';
import 'package:mdw_crew/home/home.dart';
import 'package:mdw_crew/model/login_m.dart';
import 'package:mdw_crew/service/storage.dart';
import 'package:transition/transition.dart';
import 'package:vibration/vibration.dart';
import 'package:auth_buttons/auth_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  LoginModel _loginModel = LoginModel();
  
  @override
  void initState() {
    
    // _loginModel.email.text = "vga_crew01@doformetaverse.com";
    // _loginModel.pwd.text = "vga1671119615710";

    cacheCheck();

    super.initState();
  }

  String onSubmit(String value){
    submitLogin();
    return '';
  }

  void cacheCheck() async {
    
    await StorageServices.fetchData(dotenv.get('REGISTRAION')).then((value) {

      DialogCom().dialogLoading(context);

      if (value != null){

        Navigator.pushAndRemoveUntil(
          context, 
          Transition(child: const Home()), 
          (route) => false
        );

      } else {

        // Close Dialog
        Navigator.pop(context);
      }

    });

  }

  Future<void> submitLogin() async {

    DialogCom().dialogLoading(context);

    try {
      print("login");
      await PostRequest.login(_loginModel.email.text, _loginModel.pwd.text).then((value) async {
        print("value ${value.body}");
        _loginModel.decode = await json.decode(value.body);
        if (  _loginModel.decode!.containsKey('success') ){

          Vibration.hasVibrator().then((value) async {

            if (value == true) {
              await Vibration.vibrate(duration: 90);
            }
          });

          // Close Dialog
          Navigator.pop(context);
          
          await DialogCom().dialogMessage(
            context, 
            title: Lottie.asset(
              "assets/animation/failed.json",
              repeat: true,
              reverse: true,
              height: 80
            ), 
            content: MyText(text:  _loginModel.decode!['message'], fontWeight: FontWeight.w500, left: 10, right: 10,)
          );

        }
        // Successfully Login
        else {
          
          await StorageServices.storeData(await json.decode(value.body), dotenv.get('REGISTRAION'));

          await Navigator.pushAndRemoveUntil(
            context,
            Transition(child: Home()),
            (route) => false
          );
        }
        
      });
    } catch (e) {
      
      Vibration.hasVibrator().then((value) async {

        if (value == true) {
          await Vibration.vibrate(duration: 90);
        }
      });

      // Close Dialog
      Navigator.pop(context);

      DialogCom().dialogMessage(
        context, 
        title: Lottie.asset(
          "assets/animation/failed.json",
          repeat: true,
          reverse: true,
          height: 80
        ),
        content: MyText(text: "Something wrong $e",
        fontWeight: FontWeight.w500, left: 10, right: 10,)
      );

      if (kDebugMode){
        print("submitLogin failed");
      }

    }
  }

  void changeShow(bool? value){

    setState(() {
      _loginModel.isShow = value;
    });
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // GoogleAuthButton(
              //   onPressed: () async {
              //     await Authentication.signInWithGoogle(context: context);
              //   },
              //   style: const AuthButtonStyle(
              //     buttonType: AuthButtonType.icon,
              //     iconType: AuthIconType.secondary,
              //   ),
              //   themeMode: ThemeMode.light,
              // ),
              
              MyText(
                text: "LOGIN WITH YOUR EMAIL",
                bottom: 30,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              
              MyInputField(
                labelText: "Email",
                controller: _loginModel.email, 
                focusNode: _loginModel.emailNode,
                onSubmit: onSubmit,
                pBottom: 20,
              ),
              
              MyInputField(
                labelText: "Password",
                controller: _loginModel.pwd, 
                focusNode: _loginModel.pwdlNode,
                onSubmit: submitLogin,
                pBottom: 30,
                obcureText: !(_loginModel.isShow!),
                suffixIcon: IconButton(
                  icon: Icon(Icons.remove_red_eye_outlined),
                  onPressed: (){
                    changeShow(!(_loginModel.isShow!));
                  },
                ),
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                  ),
                  onPressed: () async {
                    await submitLogin();
                  }, 
                  child: MyText(
                    width: MediaQuery.of(context).size.width,
                    top: 20,
                    bottom: 20,
                    fontWeight: FontWeight.w600,
                    text: "LOGIN",
                  )
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}