import 'package:flutter/material.dart';
import 'package:mdw_crew/tool/app_utils.dart';

class MyText extends StatelessWidget {
  final String? text;
  final String? hexaColor;
  final Color? color2;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;
  final double? pTop;
  final double? pRight;
  final double? pBottom;
  final double? pLeft;
  final double? width;
  final double? height;
  final TextAlign? textAlign;
  final TextOverflow? overflow;

  const MyText({
    Key? key, 
    this.text,
    this.hexaColor,
    this.color2,
    this.fontSize = 15,
    this.fontWeight = FontWeight.normal,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
    this.left = 0,
    this.pLeft = 0,
    this.pRight = 0,
    this.pTop = 0,
    this.pBottom = 0,
    this.width,
    this.height,
    this.textAlign = TextAlign.center,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left!, top!, right!, bottom!),
      padding: EdgeInsets.fromLTRB(pLeft!, pTop!, pRight!, pBottom!),
      child: SizedBox(
        width: width,
        height: height,
        child: Text(
          text!,
          style: TextStyle(
            fontWeight: fontWeight,
            color: hexaColor != null ? AppUtil.convertHexaColor(hexaColor!) : color2,
            fontSize: fontSize!
          ),
          textAlign: textAlign,
          overflow: overflow,
        ),
      ),
    );
    // Consumer<ThemeProvider>(
    //   builder: (context, themePro, widget) {
    //     return 
    //   }
    // );
  }
}