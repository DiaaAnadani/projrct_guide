import 'package:first/app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeLightandNightMode {
  ///Themes

  final lightTheme = ThemeData.light().copyWith(
    primaryColor: colorMainLight,

    // primaryColorLight: colorMain,
    // // indicatorColor: colorWhite,
    primaryColorDark: colorBlack,
    // secondaryHeaderColor: colorBlueAccent,
    // appBarTheme: const AppBarTheme(),
    // textTheme: const TextTheme(bodyMedium: TextStyle(color: colorBlack)),
    // iconTheme:const IconThemeData(color: colorBlack) ,

    dividerColor: colorWhite,
  );

  final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Color.fromARGB(255, 1, 21, 37),
    primaryColorDark: colorWhite,
    // appBarTheme: const AppBarTheme(),
    //   textTheme: const TextTheme(bodyMedium: TextStyle(color: colorWhite)),
    //    iconTheme:IconThemeData(color: colorWhite ,size: 30) ,
    // dividerColor:  Color.fromARGB(255, 16, 41, 61),
  );
//لتخزين خيار المستخدم ع الجهاز
}
