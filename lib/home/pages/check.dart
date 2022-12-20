import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mdw_crew/backend/post_api.dart';
import 'package:mdw_crew/components/dialog_c.dart';
import 'package:mdw_crew/components/event_card_c.dart';
import 'package:mdw_crew/components/text_c.dart';
import 'package:mdw_crew/provider/mdw_socket_p.dart';
import 'package:mdw_crew/qr_scanner/qr_scanner.dart';
import 'package:mdw_crew/tool/sound.dart';
import 'package:provider/provider.dart';
import 'package:transition/transition.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class Check extends StatefulWidget {

  final PageController? pageController;
  
  const Check({super.key, this.pageController});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {

  double iconSize = 35;

  bool? _isSuccess = false;

  Future<bool> scanCheck(String eventId, String url) async {

    _isSuccess = false;

    try {

      await PostRequest.checkFunc(eventId, url).then((value) async {
        
        if (value.statusCode == 200 && json.decode(value.body)['status'] == 'Success'){

          _isSuccess = false;
          
          SoundUtil.soundAndVibrate('mixkit-digital-quick-tone-2866.wav');

          await DialogCom().dialogMessage(
            context, 
            title: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                width: 30,
                child: Lottie.asset(
                  "assets/animation/successful.json",
                  repeat: true,
                  reverse: true,
                  height: 100
                ),
              ),
            ), 
            content: const MyText(text: "Your ticket have been successfully validated", fontWeight: FontWeight.w500, left: 10, right: 10,)
          );

        } else {
          
          SoundUtil.soundAndVibrate('mixkit-tech-break-fail-2947.wav');

          await DialogCom().dialogMessage(
            context,
            title: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: SizedBox(
                width: 30,
                child: Lottie.asset(
                  "assets/animation/failed.json",
                  repeat: true,
                  reverse: true,
                  height: 100
                ),
              ),
            ), 
            content: MyText(text: json.decode(value.body)['message'], fontWeight: FontWeight.w500, left: 10, right: 10,)
          );
        }
        
      });

      return _isSuccess!;

    } catch (e) {
      
      SoundUtil.soundAndVibrate('mixkit-tech-break-fail-2947.wav');

      DialogCom().dialogMessage(
        context, 
        title: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 30,
            child: Lottie.asset(
              "assets/animation/failed.json",
              repeat: true,
              reverse: true,
              height: 100
            ),
          ),
        ), 
        content: MyText(text: "Something wrong $e", fontWeight: FontWeight.w500, left: 10, right: 10,)
      );
      
      if (kDebugMode){
        print("submitLogin failed");
      }

      return _isSuccess!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MDWSocketProvider>(
      builder: (context, provider, widget) {
        return Container(
          color: Colors.green.withOpacity(0.15),
          padding: const EdgeInsets.all(20),
          child: Column(
        
            children: [
        
              Align(
                alignment: Alignment.topLeft,
                child: MyText(text: "Check", fontSize: 25, fontWeight: FontWeight.w600, color2: Colors.green,),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
              
                    EventCardCom(
                      func: () async {
    
                        Navigator.push(
                          context, 
                          Transition(child: QrScanner(title: 'The Greatest Artist', func: scanCheck), transitionEffect: TransitionEffect.RIGHT_TO_LEFT)
                        );

                      },
                      title: 'The Greatest Artist',
                      img: 'tga.png',
                    ),
              
                    SizedBox(height: 30,),
              
                    EventCardCom(
                      func: (){
                        
                        Navigator.push(
                          context, 
                          Transition(child: QrScanner(title: 'Van Gogh Alive', func: scanCheck), transitionEffect: TransitionEffect.RIGHT_TO_LEFT)
                        );
                      },
                      title: 'Van Gogh Alive',
                      img: 'vga.png',
                    ),
                  ],
                ),
              )
        
            ],
          ),
        );
      }
    );
  }
}