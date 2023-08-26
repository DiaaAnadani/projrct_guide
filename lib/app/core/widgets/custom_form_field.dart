// ignore_for_file: prefer_const_constructors

import 'package:first/app/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {required this.labelText,
      Key? key,
      this.prefixIcon,
      this.validator,
      this.suffixIcon,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.onTap,
      this.controller,
      this.onChanged,
      this.prefixText})
      : super(key: key);
  final String labelText;
  void Function()? onTap;
  final String? prefixText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: colorWhite,
      height: 7.h,
      child: TextFormField(
        onTap: onTap,
        onChanged: onChanged,
        obscureText: obscureText,
        cursorColor: colorMainLight,
        keyboardType: keyboardType,
        controller: controller,
        maxLines: 1,
        validator: validator,
        style: TextStyle(
          color: Colors.black,
          fontSize: 11.sp,
        ),
        decoration: InputDecoration(
          fillColor: backGroundGrey,
          filled: true,
          prefixText: prefixText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,

          border: OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(
            color: colorBlackHint,
            fontSize: 11.sp,
          ),
          prefixStyle: TextStyle(
            color: colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorBlackBorder, width: 1),
            borderRadius: BorderRadius.circular(14.0),
          ),

          // fillColor: Colors.red,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorBlackBorder, width: 1),
            borderRadius: BorderRadius.circular(14.0),
          ),
        ),
      ),
    );
  }
}
