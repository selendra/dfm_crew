import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mdw_crew/components/dialog_c.dart';
import 'package:mdw_crew/components/text_c.dart';
import 'package:mdw_crew/home/pages/check.dart';
import 'package:mdw_crew/home/pages/checkout/check_out.dart';
import 'package:mdw_crew/home/pages/admission.dart';
import 'package:mdw_crew/provider/mdw_socket_p.dart';
import 'package:mdw_crew/registration/login.dart';
import 'package:mdw_crew/service/storage.dart';
import 'package:mdw_crew/tool/app_utils.dart';
import 'package:provider/provider.dart';
import 'package:transition/transition.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final PageController controller = PageController();

  final double iconSize = 25;
  
  int? active = 0; 

  @override
  void initState() {
    
    controller.addListener(() {
      setState(() {
        
        active = controller.page!.toInt();
      });
    });
    super.initState();
  }

  Color? color = Colors.green.withOpacity(0.3);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: AppUtil.convertHexaColor("#F2F2F2"),
      body: SafeArea(
        child: PageView(
          controller: controller,
          onPageChanged: (value) {
            setState(() {
              active = controller.page!.toInt();

              if (controller.page!.toInt() == 0){
                color = Colors.green.withOpacity(0.3);
              } else if ((controller.page!.toInt() == 1)){
                color = Colors.blue.withOpacity(0.3);
              } else if (controller.page!.toInt() == 0){
                color = Colors.red.withOpacity(0.3);
              }
            });
          },
          children: const [
            Check(),
            Admission(),
            CheckOut(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
                            controller.animateToPage(0, duration: Duration(milliseconds: 300), curve: Curves.easeOutExpo);
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
                          
                            controller.animateToPage(1, duration: Duration(milliseconds: 300), curve: Curves.easeOutExpo);
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
                              
                            controller.animateToPage(2, duration: Duration(milliseconds: 300), curve: Curves.easeOutExpo);
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
                          context, 
                          title: MyText(text: "Sign Out"), 
                          content: MyText(text: "Are you sure wanna sign out?",),
                          action2: Container(
                            margin: EdgeInsets.only(left: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(Colors.red),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                              ),
                              onPressed: () async {
                                DialogCom().dialogLoading(context, content: "Loggin Out");
                                await StorageServices.clearStorage();
                                                
                                // Dispose Web Socket
                                Provider.of<MDWSocketProvider>(context, listen: false).dispose();
                                                
                                Navigator.pushAndRemoveUntil(
                                  context, 
                                  Transition(child: LoginPage(), transitionEffect: TransitionEffect.LEFT_TO_RIGHT), 
                                  (route) => false
                                );
                              },
                              child: const MyText(text: "Yes", left: 10, right: 10, color2: Colors.white,),
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
      ),
    );
  }
}