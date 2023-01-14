import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:mdw_crew/components/dialog_c.dart';
import 'package:mdw_crew/components/text_c.dart';
import 'package:mdw_crew/provider/mdw_socket_p.dart';
import 'package:mdw_crew/registration/login.dart';
import 'package:mdw_crew/service/storage.dart';
import 'package:provider/provider.dart';
import 'package:transition/transition.dart';

Widget bottomAppBar({
  required BuildContext? context,
  required PageController? controller,
  required int? active
}){

  final double iconSize = 25;

  return BottomAppBar(
    child: Container(
      height: 70,
      child: Row(
        children: [
    
          Expanded(
            child: Container(
              height: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                    
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        controller!.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeOutExpo);
                      }, 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      
                          Image.asset('assets/icons/check.png', width: iconSize,),
                      
                          MyText(
                            width: double.maxFinite,
                            top: 5,
                            text: "Check",
                            fontSize: 10,
                            bottom: 5,
                          ),
                        ],
                      )
                      
                    ),
                  ),
                    
                  active == 0 ? Container(
                    height: 5,
                    width: double.maxFinite,
                    color: Colors.blue,
                  ) : Container()
                ],
              ),
            ),
          ),

          Expanded(
            child: Container(
              height: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  Expanded(
                    child: InkWell(
                      onTap: (){
                      
                        controller!.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeOutExpo);
                      }, 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      
                          Image.asset('assets/icons/admission.png', width: iconSize),
                      
                          MyText(
                            width: double.maxFinite,
                            top: 5,
                            text: "Admission",
                            fontSize: 10,
                            bottom: 5,
                          ),
                        ],
                      )
                      
                    ),
                  ),
                    
                  active == 1 ? Container(
                    height: 5,
                    width: double.maxFinite,
                    color: Colors.blue,
                  ) : Container()
                ],
              ),
            ),
          ),
    
          Expanded(
            child: Container(
              height: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    
                  Expanded(
                    child: InkWell(
                      onTap: (){
                          
                        controller!.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.easeOutExpo);
                      }, 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Image.asset('assets/icons/check-out.png', width: iconSize),
                          
                          MyText(
                            width: double.maxFinite,
                            top: 5,
                            text: "Check Out",
                            fontSize: 10,
                            bottom: 5,
                          ),
                        ],
                      )
                      
                    ),
                  ),
                    
                  active == 2 ? Container(
                    height: 5,
                    width: double.maxFinite,
                    color: Colors.blue,
                    margin: EdgeInsets.only(bottom: 5),
                  ) : Container()
                ],
              ),
            ),
          ),
    
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  
                InkWell(
                  onTap: (){

                    DialogCom().dialogMessage(
                      context!, 
                      title: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 30,
                          child: Lottie.asset(
                            "assets/animation/exit.json",
                            repeat: true,
                            reverse: true,
                            height: 100
                          ),
                        ),
                      ), 
                      edgeInsetsGeometry: const EdgeInsets.all(20),
                      content: AnimatedTextKit(
                        repeatForever: true,
                        pause: const Duration(seconds: 1),
                        animatedTexts: [

                          TypewriterAnimatedText(
                            "Are you sure wanna log out?",
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                              fontSize: 14
                            )
                          ),

                        ],
                      ),
                      // MyText(text: "Are you sure wanna sign out?",),
                      action2: Container(
                        // margin: EdgeInsets.only(left: 10),
                        child: TextButton(
                          // style: ButtonStyle(
                          //   backgroundColor: MaterialStateProperty.all(Colors.red),
                          //   shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                          // ),
                          onPressed: () async {

                            DialogCom().dialogLoading(context, content: "Signing Out");
                            await StorageServices.clearStorage();
                                            
                            // Dispose Web Socket
                            Provider.of<MDWSocketProvider>(context, listen: false).dispose();
                                            
                            Navigator.pushAndRemoveUntil(
                              context, 
                              Transition(child: LoginPage(), transitionEffect: TransitionEffect.LEFT_TO_RIGHT), 
                              (route) => false
                            );
                          },
                          child: const MyText(text: "Yes", left: 10, right: 10, color2: Colors.red, fontSize: 12, fontWeight: FontWeight.bold,),
                        ),
                      ),
                    );
                  }, 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  
                      Image.asset('assets/icons/logout.png', width: iconSize),
                  
                      MyText(
                        width: double.maxFinite,
                        top: 5,
                        text: "Log out",
                        fontSize: 10,
                        bottom: 5,
                      ),
                    ],
                  )
                  
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget bottomAppBarNoCheck({
  required BuildContext? context,
  required PageController? controller,
  required int? active
}){

  final double iconSize = 25;

  return BottomAppBar(
    child: Container(
      height: 70,
      child: Row(
        children: [

          Expanded(
            child: Container(
              height: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  
                  Expanded(
                    child: InkWell(
                      onTap: (){
                      
                        controller!.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeOutExpo);
                      }, 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      
                          Image.asset('assets/icons/admission.png', width: iconSize),
                      
                          MyText(
                            width: double.maxFinite,
                            top: 5,
                            text: "Admission",
                            fontSize: 10,
                            bottom: 5,
                          ),
                        ],
                      )
                      
                    ),
                  ),
                    
                  active == 0 ? Container(
                    height: 5,
                    width: double.maxFinite,
                    color: Colors.blue,
                  ) : Container()
                ],
              ),
            ),
          ),
    
          Expanded(
            child: Container(
              height: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                    
                  Expanded(
                    child: InkWell(
                      onTap: (){
                          
                        controller!.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeOutExpo);
                      }, 
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          
                          Image.asset('assets/icons/check-out.png', width: iconSize),
                          
                          MyText(
                            width: double.maxFinite,
                            top: 5,
                            text: "Check Out",
                            fontSize: 10,
                            bottom: 5,
                          ),
                        ],
                      )
                      
                    ),
                  ),
                    
                  active == 1 ? Container(
                    height: 5,
                    width: double.maxFinite,
                    color: Colors.blue,
                    margin: EdgeInsets.only(bottom: 5),
                  ) : Container()
                ],
              ),
            ),
          ),
    
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                  
                InkWell(
                  onTap: (){

                    DialogCom().dialogMessage(
                      context!, 
                      title: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: SizedBox(
                          width: 30,
                          child: Lottie.asset(
                            "assets/animation/exit.json",
                            repeat: true,
                            reverse: true,
                            height: 100
                          ),
                        ),
                      ), 
                      edgeInsetsGeometry: const EdgeInsets.all(20),
                      content: AnimatedTextKit(
                        repeatForever: true,
                        pause: const Duration(seconds: 1),
                        animatedTexts: [

                          TypewriterAnimatedText(
                            "Are you sure wanna log out?",
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                              fontSize: 14
                            )
                          ),

                        ],
                      ),
                      // MyText(text: "Are you sure wanna sign out?",),
                      action2: Container(
                        // margin: EdgeInsets.only(left: 10),
                        child: TextButton(
                          // style: ButtonStyle(
                          //   backgroundColor: MaterialStateProperty.all(Colors.red),
                          //   shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
                          // ),
                          onPressed: () async {

                            DialogCom().dialogLoading(context, content: "Signing Out");
                            await StorageServices.clearStorage();
                                            
                            // Dispose Web Socket
                            Provider.of<MDWSocketProvider>(context, listen: false).dispose();
                                            
                            Navigator.pushAndRemoveUntil(
                              context, 
                              Transition(child: LoginPage(), transitionEffect: TransitionEffect.LEFT_TO_RIGHT), 
                              (route) => false
                            );
                          },
                          child: const MyText(text: "Yes", left: 10, right: 10, color2: Colors.red, fontSize: 12, fontWeight: FontWeight.bold,),
                        ),
                      ),
                    );
                  }, 
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  
                      Image.asset('assets/icons/logout.png', width: iconSize),
                  
                      MyText(
                        width: double.maxFinite,
                        top: 5,
                        text: "Log out",
                        fontSize: 10,
                        bottom: 5,
                      ),
                    ],
                  )
                  
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}