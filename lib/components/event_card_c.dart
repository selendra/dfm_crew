import 'package:flutter/material.dart';
import 'package:mdw_crew/components/text_c.dart';
import 'package:mdw_crew/qr_scanner/qr_scanner.dart';
import 'package:transition/transition.dart';

class EventCardCom extends StatelessWidget {

  final String? img;
  final String? title;
  final String? qty;
  final Function()? func;
  
  const EventCardCom({
    super.key, 
    required this.img,
    required this.title,
    this.qty,
    required this.func
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: func!,
      child: Column(
        children: [

          MyText(text: title, fontSize: 20, bottom: 10, fontWeight: FontWeight.w600,),

          qty != null ? Container(
            child: Row(
              children: [
                
                MyText(text: "Quantity: $qty", bottom: 10, fontSize: 13,),
              ],
            ),
          ) : Container(),

          Container(
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset("assets/mdw/$img", fit: BoxFit.cover, width: MediaQuery.of(context).size.width,),
            ),
          )
        ],
      ),
      // Card(
      //   child: Stack(
      //     children: [

      //       Container(
      //         height: 150,
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.circular(20),
      //           child: Image.asset("assets/mdw/$img", fit: BoxFit.cover, width: MediaQuery.of(context).size.width,),
      //         ),
      //       ),
      //       // Container(
      //       //   height: 200,
      //       //   width: MediaQuery.of(context).size.width,
      //       //   child: MyText(
      //       //     height: double.maxFinite,
      //       //     text: "The Greatest Artist",
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
    );
  }
}