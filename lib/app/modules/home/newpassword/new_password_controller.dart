import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/local_storage/get_storage_local_db.dart';

class NewPasswordController extends GetxController {
  NewPasswordController({required this.homeRepository});
  HomeRepository homeRepository;
  final TextEditingController controllerNewPassword = TextEditingController();
  final TextEditingController controllerConfirmNewPassword =
      TextEditingController();
        GetStorageLocalDb getStorageLocalDb = GetStorageLocalDb();

  bool newPasswordVisible = true;
  bool confirmNewPasswordVisible = true;
  bool isLoading = false;
  bool isUpatePassword = false;

  void visibleNewPassword() {
    newPasswordVisible = !newPasswordVisible;
    update(["ChangePasswordController"]);
  }

  void visibleConfirmNewPassword() {
    confirmNewPasswordVisible = !confirmNewPasswordVisible;
    update(["ChangePasswordController"]);
  }

 Future<void> updatePassword({required String newPassword}) async {
    update(["ChangeOldPasswordController"]);
    try {
      isLoading = true;
        update([
        "ElevatedButton",
      ]);
      isUpatePassword =
          await homeRepository.updatePassword(newPassword: newPassword);
      BotToast.showText(text: "Success userIsSaved");
        isLoading = false;
      controllerNewPassword.clear();
      controllerConfirmNewPassword.clear();
      getStorageLocalDb.savePassword(newPassword);

      log("=========================newPassword  getStorageLocalDb"+getStorageLocalDb.getPassword().toString());
      // Get.offAndToNamed("/ProfileView");
       Get.back(result: "/ProfileView");
      update([
        "ElevatedButton"]);
    } catch (e) {
   
        isLoading = false;
          update([
        "ElevatedButton",
      ]);

         log(e.toString());

    }
  }
}
