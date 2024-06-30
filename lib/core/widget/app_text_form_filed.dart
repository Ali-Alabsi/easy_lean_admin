import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared/color.dart';
import '../shared/theming/text_style.dart';

class AppTextFormFiled extends StatelessWidget {
  const AppTextFormFiled(
      {super.key,
      this.contentPadding,
      required this.hintText,
      this.hintStyle,
      this.enabledBorder,
      this.focusedBorder,
      this.fillColor,
      this.suffixIcon,
        this.prefixIcon,
        this.keyboardType,
        this.obscureText, this.validator, this.controller,  this.noSpaceTextInputFormatter =true});

  final EdgeInsetsGeometry? contentPadding;
  final bool noSpaceTextInputFormatter;
  final String hintText;
  final TextStyle? hintStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final Color? fillColor;
  final Widget? suffixIcon;
  final bool? obscureText;
  final Widget? prefixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      inputFormatters: [noSpaceTextInputFormatter ?NoSpaceTextInputFormatter() : SpaceTextInputFormatter() ],
      keyboardType: keyboardType?? TextInputType.text ,
      obscureText: obscureText??false,
      decoration: InputDecoration(
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          hintText: hintText,
           hintStyle: hintStyle,
          enabledBorder: enabledBorder ??
              OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ProjectColors.greyColor,
                  ),
                  borderRadius: BorderRadius.circular(16)),
          focusedBorder: focusedBorder ??
              OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ProjectColors.mainColor,
                  ),
                  borderRadius: BorderRadius.circular(16)),
          errorBorder:   OutlineInputBorder(
              borderSide: BorderSide(
                color: ProjectColors.redColor,
              ),
              borderRadius: BorderRadius.circular(16)),
          border:  OutlineInputBorder(
              borderSide: BorderSide(
                color: ProjectColors.mainColor,
                width: 1
              ),
              borderRadius: BorderRadius.circular(16)),
          fillColor: fillColor ?? ProjectColors.mainColor.withOpacity(0.2),
          filled: true,
          suffixIcon: suffixIcon,
        prefixIcon: prefixIcon
      ),

    );
  }
}

class NoSpaceTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.contains(' ')) {
      return oldValue;
    }
    return newValue;
  }
}


class SpaceTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

    return newValue;
  }
}