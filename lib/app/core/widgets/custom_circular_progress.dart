import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class CircularWidget extends StatelessWidget {
  const CircularWidget({Key? key, required this.color ,}) : super(key: key);
 final Color color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 50,
        child: Center(
            child: CircularProgressIndicator(
              color: color,
              strokeWidth: 2,
            )));
  }
}
