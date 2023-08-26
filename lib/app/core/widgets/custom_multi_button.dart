// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class CustomMultiButtons extends StatelessWidget {
  CustomMultiButtons({Key? key}) : super(key: key);
  List<bool> isCardEnabled = [];
  List<Map<String, dynamic>> name = [
    {"gender": "male", "iconGender": Icons.male},
    {"gender": "female", "iconGender": Icons.female},
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 11.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 8),
            itemCount: 2,
            itemBuilder: (BuildContext context, int index) {
              isCardEnabled.add(false);
              return GestureDetector(
                onTap: () {
                  isCardEnabled.replaceRange(0, isCardEnabled.length,
                      [for (int i = 0; i < isCardEnabled.length; i++) false]);
                  isCardEnabled[index] = true;
                  // setState(() {});
                },
                child: Card(
                  color: isCardEnabled[index] ? colorMainLight : backGroundGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        name[index]["iconGender"],
                        color:
                            isCardEnabled[index] ? Colors.white : Colors.black,
                      ),
                      SizedBox(
                        width: 1.h,
                      ),
                      Text(
                        name[index]["gender"],
                        style: TextStyle(
                            color: isCardEnabled[index]
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
