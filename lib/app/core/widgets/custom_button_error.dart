import 'package:flutter/material.dart';

import '../constants/colors.dart';

// ignore: must_be_immutable
class CustomButtonError extends StatelessWidget {
  CustomButtonError({super.key ,required this.text ,this.onPressed});
  void Function()? onPressed;
   String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.red,
      height: 40,
      width: 40,
      child: Center(
        child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              textStyle: MaterialStateProperty.all(
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
              ))),
          child:  Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              text,
              style:const TextStyle(fontSize: 18,color: colorWhite),
            ),
          ),
        ),
      ),
    );
    ;
  }
}
