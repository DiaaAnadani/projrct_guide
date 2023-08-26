import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GetStorageLocalDb {
  static var getStorage = GetStorage();

  final darkThemeKey = "isDarkTheme";
  final languageKey = 'language';
   static String  tokenKey = "token";
    static String  passWordKey = "passWordKey";

  void saveThemeData(bool isDarkMode) {
    getStorage.write(darkThemeKey, isDarkMode);
  }

  bool isSavedDarkMode() {
    return getStorage.read(darkThemeKey) ?? false;
  }

  ThemeMode getThemeMode() {
    return isSavedDarkMode() ? ThemeMode.dark : ThemeMode.light;
  }

  void changeTheme() {
    Get.changeThemeMode(isSavedDarkMode() ? ThemeMode.light : ThemeMode.dark);
    saveThemeData(!isSavedDarkMode());
  }

  void saveLanguage(String language) async {
    await getStorage.write(languageKey, language);
  }

  Future<String> get languageSelected async {
    return await getStorage.read(languageKey) ?? 'ar';
  }

   Future<void> saveToken(String token) async {
    await getStorage.write(tokenKey, token);
  }

 static Future<String> getToken() async {
     return await getStorage.read(tokenKey) ?? 'null';
  }

  Future<void> savePassword(String password) async {
    await getStorage.write(passWordKey, password);
  }

   Future<String> getPassword() async {
    return await getStorage.read(passWordKey) ?? 'null';
  }

}
