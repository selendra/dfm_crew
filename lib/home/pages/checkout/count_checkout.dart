

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:mdw_crew/components/text_c.dart';
import 'package:mdw_crew/provider/mdw_socket_p.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class CheckoutCount extends StatelessWidget {

  final String? title;
  final String? amt;
  final String? hallId;
  final Function? func;

  const CheckoutCount({
    super.key,
    required this.title,
    required this.amt,
    required this.hallId,
    required this.func
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red.withOpacity(0.5),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            Consumer<MDWSocketProvider>(
              builder: (context, provider, w) {

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    AnimatedTextKit(
                      repeatForever: true,
                      pause: const Duration(seconds: 1),
                      animatedTexts: [
          
                        WavyAnimatedText(
                          title!,
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
          
                      ],
                    ),
                    
                    MyText(
                      top: 30,
                      text: hallId == "tga" ? provider.tga.checkOut.toString() : provider.vga.checkOut.toString(),
                      fontSize: 50,
                      bottom: 30,
                      color2: Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                );
              }
            ),

            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),)
                ),
                onPressed: () async {
                  await Vibration.hasVibrator().then((value) async {

                    if (value == true) {
                      await Vibration.vibrate(duration: 90);
                    }

                    func!(hallId!);

                  });
                },
                child: MyText(
                  width: MediaQuery.of(context).size.width,
                  top: 30,
                  bottom: 30,
                  fontWeight: FontWeight.w600,
                  text: "Tap To CheckOut",
                )
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}