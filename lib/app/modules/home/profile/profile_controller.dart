import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:first/app/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/model/user_model.dart';
import '../../../core/services/local_storage/get_storage_local_db.dart';

class ProfileController extends GetxController {
  ProfileController({required this.homeRepository});
  HomeRepository homeRepository;
  GetStorageLocalDb getStorageLocal = GetStorageLocalDb();
  static StoragesService storagesService = StoragesService();
  var langChoose = 'ar';
  late String deviceId;
  User? user = storagesService.getUser();
  bool isLoading = false;

  @override
  void onInit() async {
    super.onInit();
    langChoose = await getStorageLocal.languageSelected;
    Get.updateLocale(Locale(langChoose));
    log("love you daoooooooooooooooooooooooooooooooooooooooo");
    // update(["Imagegender"]);
  }

  void onChangeLanguage(String type) {
    if (langChoose == type) {
      return;
    } else if (type == 'ar') {
      langChoose = 'ar';
      getStorageLocal.saveLanguage(langChoose);
    } else {
      langChoose = 'en';
      getStorageLocal.saveLanguage(langChoose);
    }
    update();
  }

  void goToFaFavoritesView() {
    Get.toNamed("/FavoriteTabBarView");
  }

  void goToAllYourCommentView() {
    Get.toNamed("/AllYourCommentView");
  }

  void goToEditeProfileView() {
    Get.toNamed("/EditeProfileView");
  }

  void goToChangePasswordView() {
    Get.toNamed("/ChangePasswordView");
  }

  Future<void> logOut() async {
    bool isLogOut = false;
    try {
      log("isLogOut");
      isLogOut = await homeRepository.logOut(deviceId: user!.deviceId);
      log('$isLogOut');
      if (isLogOut == true) {
        isLoading = true;
        update(["ProfileController"]);
        BotToast.showText(text: "Success logOut");
        storagesService.deleteUser();
        Get.offAllNamed("/RegisterView");
      } else {
        isLoading = false;
        update(["ProfileController"]);
      }

      // update(["SliverAppBar"]);
    } catch (e) {
      log(e.toString());
      isLoading = true;
      update(["ProfileController"]);
      // errorApiEmail = homeRepository.apiData["msg"].toString();
      // log("login email****-----*******$errorApiEmail");
    }
  }
}
