import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double paddingSize = 20;

class MyInputField extends StatelessWidget {
  final String? labelText;
  final String? prefixText;
  final String? textColor;
  final int? maxLine;
  final double? pLeft, pTop, pRight, pBottom;
  final bool? obcureText;
  final bool? enableInput;
  final List<TextInputFormatter>? textInputFormatter;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final TextEditingController? controller;
  final Function? onTap;
  final FocusNode? focusNode;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool? autoFocus;
  final Function? validateField;
  final Function? onChanged;
  final Function? onSubmit;
  final String? hintText;

  const MyInputField({
      Key? key,
      this.labelText,
      this.prefixText,
      this.pLeft = paddingSize,
      this.pTop = 5.0,
      this.pRight = paddingSize,
      this.pBottom = 0,
      this.obcureText = false,
      this.enableInput = true,
      this.textInputFormatter,
      this.inputType = TextInputType.text,
      this.inputAction,
      this.maxLine = 1,
      this.onTap,
      @required this.controller,
      this.focusNode,
      this.suffixIcon,
      this.textColor = "#FFFFFF",
      this.autoFocus,
      this.suffix,
      this.validateField,
      this.onChanged,
      @required this.onSubmit,
      this.hintText,
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     

    return Container(
        padding: EdgeInsets.fromLTRB(pLeft!, pTop!, pRight!, pBottom!),
        child: TextFormField(
          key: key,
          enabled: enableInput,
          focusNode: focusNode,
          autofocus: autoFocus ?? false,
          keyboardType: inputType,
          obscureText: obcureText!,
          controller: controller,
          onTap: onTap != null ? (){
            onTap!();
          } : null,
          textInputAction:
            // ignore: prefer_if_null_operators
            inputAction == null ? TextInputAction.next : inputAction,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17
          ),
          validator: (String? value){
            return validateField!(value);
          },
          maxLines: maxLine,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
            labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
            prefixText: prefixText,

            prefixStyle: TextStyle(color: Colors.black, fontSize: 18.0),
            /* Prefix Text */
            filled: true,
            // fillColor: isDarkMode
            //     ? Colors.white.withOpacity(0.06)
            //     : hexaCodeToColor(AppColors.whiteHexaColor),

            // enabledBorder: myTextInputBorder(controller!.text != ""
            //     ? isDarkMode
            //         ? Colors.white.withOpacity(0.06)
            //         : hexaCodeToColor(AppColors.textColor).withOpacity(0.3)
            //     : Colors.white.withOpacity(0.06)),
            // /* Enable Border But Not Show Error */
            // border: errorOutline(),
            // /* Show Error And Red Border */
            // focusedBorder: myTextInputBorder(isDarkMode
            //     ? Colors.white.withOpacity(0.06)
            //     : hexaCodeToColor(AppColors.secondary)),
            // /* Default Focuse Border Color*/
            // focusColor: isDarkMode
            //     ? Colors.white.withOpacity(0.06)
            //     : hexaCodeToColor(AppColors.textColor),
            /* Border Color When Focusing */
            contentPadding: const EdgeInsets.fromLTRB(
                paddingSize, 0, paddingSize, 0), // Default padding = -10.0 px
            suffixIcon: suffixIcon,
            suffixIconConstraints: const BoxConstraints(
              minWidth: 0,
              minHeight: 0,
            ),
            suffix: suffix,
          ),
          inputFormatters: textInputFormatter,
          /* Limit Length Of Text Input */
          onChanged: (String? value){
            if (onChanged != null) onChanged!(value);
          },
          onFieldSubmitted: (value) {
            onSubmit!();
          },
        ));
  }
}

/* User input Outline Border */
OutlineInputBorder myTextInputBorder(Color borderColor) {
  return OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor,
      ),
      borderRadius: BorderRadius.circular(8));
}