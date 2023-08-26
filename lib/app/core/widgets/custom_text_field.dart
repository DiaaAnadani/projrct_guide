import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {required this.controller,
      required this.hintText,
      this.colorBorder = colorBlackBorder,
      this.colorHint = colorBlackHint,
      this.colorIcon = colorBlackBorder,
      this.colorText = colorBlack,
      this.readOnly = false,
      this.fillColor,
      this.onChanged,
      this.onTap,
      required this.cursorColor,
      this.suffixIcon,
      Key? key,
      required this.textAlign})
      : super(key: key);
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final Color colorBorder;
  final Color? colorHint;
  final Color colorIcon;
  final Color colorText;
  final bool readOnly;
  final String hintText;
  final void Function()? onTap;
  final TextAlign textAlign;
  final Widget? suffixIcon;
  final Color cursorColor;
  final Color? fillColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 65.w,
      height: 40,
      child: TextField(
          // inputFormatters: [FilteringTextInputFormatter.deny(RegExp("[0-9]+"))],
            // inputFormatters: [
            //       FilteringTextInputFormatter.deny(
            //          RegExp(r'\s')),
        // ],
        maxLines: 1,
        // scrollPadding: EdgeInsets.all(12),
        cursorColor: cursorColor,
        textAlign: textAlign,
        onTap: onTap,
        readOnly: readOnly,
        onChanged: onChanged,
        controller: controller,
        style: TextStyle(color: colorText, fontSize: 10.sp),
        decoration: InputDecoration(
            fillColor: fillColor,
            filled: true,
            border: const OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorBlackHint, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),

            // fillColor: Colors.red,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: colorBorder, width: 1),
              borderRadius: BorderRadius.circular(30.0),
            ),
            hintStyle: TextStyle(fontSize: 11.sp, color: colorHint),
            hintText: hintText,
            prefixIcon: Icon(
              Icons.search,
              size: 22,
              color: colorIcon,
            ),
            suffixIcon: suffixIcon),
      ),
    );
  }
}
