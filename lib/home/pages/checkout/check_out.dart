import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mdw_crew/components/dialog_c.dart';
import 'package:mdw_crew/components/event_card_c.dart';
import 'package:mdw_crew/components/text_c.dart';
import 'package:mdw_crew/home/pages/checkout/count_checkout.dart';
import 'package:mdw_crew/provider/mdw_socket_p.dart';
import 'package:mdw_crew/qr_scanner/qr_scanner.dart';
import 'package:provider/provider.dart';
import 'package:transition/transition.dart';

class CheckOut extends StatefulWidget {

  final PageController? pageController;
  const CheckOut({super.key, this.pageController});

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {

  double iconSize = 35;

  bool? _isSuccess = false;

  Future<bool> checkOutFunc(String hallId) async {

    _isSuccess = false;

    try {

      Provider.of<MDWSocketProvider>(context, listen: false).emitSocket('check-out', {'hallId': hallId});

      // await PostRequest.checkOutFunc(eventId, url).then((value) async {
        
      //   if (value.statusCode == 200 && json.decode(value.body)['status'] == 'Success'){

      //     _isSuccess = false;

          

      //     await DialogCom().dialogMessage(context, title: Icon(Icons.check_circle, color: Colors.green, size: iconSize,), content: MyText(text: json.decode(value.body)['message']));

      //   } else {

      //     await DialogCom().dialogMessage(context, 
      //       title: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Container(
      //             width: iconSize - 5, 
      //             height: iconSize - 5, 
      //             child: Icon(Icons.close, color: Colors.white), 
      //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.red),
      //           ),
      //         ],
      //       ), 
      //       content: MyText(text: json.decode(value.body)['message'])
      //     );
      //   }
        
      // });

      return _isSuccess!;

    } catch (e) {

      DialogCom().dialogMessage(context, title: const MyText(text: "Oops",), content: MyText(text: "Something wrong $e",));
      
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
          color: Colors.redAccent.withOpacity(0.15),
          padding: const EdgeInsets.all(20),
          child: Column(
        
            children: [
        
              Align(
                alignment: Alignment.topLeft,
                child: MyText(text: "Check Out", fontSize: 25, fontWeight: FontWeight.w600, color2: Colors.redAccent,),
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    EventCardCom(
                      func: (){

                        Navigator.push(
                          context,
                          Transition(
                            child: CheckoutCount(
                              title: 'The Greatest Artist', 
                              amt: Provider.of<MDWSocketProvider>(context, listen: false).tga.checkOut.toString(), 
                              func: checkOutFunc,
                              hallId: 'tga'
                            ), 
                            transitionEffect: TransitionEffect.RIGHT_TO_LEFT
                          )
                        );
                      },
                      title: 'The Greatest Artist',
                      qty: provider.tga.checkOut.toString(),
                      img: 'tga.png',
                    ),

                    SizedBox(height: 30,),

                    EventCardCom(
                      func: (){
                        
                        Navigator.push(
                          context,
                          Transition(
                            child: CheckoutCount(
                              title: 'Van Gogh Alive', 
                              amt: Provider.of<MDWSocketProvider>(context, listen: false).vga.checkIn.toString(), 
                              func: checkOutFunc,
                              hallId: 'vga'
                            ),
                            transitionEffect: TransitionEffect.RIGHT_TO_LEFT
                          )
                        );
                      },
                      title: 'Van Gogh Alive',
                      qty: provider.vga.checkOut.toString(),
                      img: 'vga.png',
                    )
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