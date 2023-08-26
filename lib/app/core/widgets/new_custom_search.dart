import 'dart:developer';

import 'package:first/app/core/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    this.onChanged,
     this.controller,
    this.onSubmitted,
    this.backgroundColor,
    this.onTap,
    super.key});



  final TextEditingController? controller;
   final void Function(String)? onChanged;
   final void Function(String)? onSubmitted;
   final void Function()? onTap;
  final Color? backgroundColor;


  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: controller,
      onTap: onTap,
      backgroundColor:backgroundColor ,
      style: TextStyle(color: colorBlack),
      onChanged: onChanged,
      onSubmitted:onSubmitted,
      autocorrect: true,
    );
  }
}