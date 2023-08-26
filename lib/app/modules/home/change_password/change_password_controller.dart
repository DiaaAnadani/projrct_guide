import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:first/app/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/model/user_model.dart';
import '../../../core/services/local_storage/get_storage_local_db.dart';

class ChangePasswordController extends GetxController {
  ChangePasswordController({required this.homeRepository});

  HomeRepository homeRepository;
  final TextEditingController controllerOldPassword = TextEditingController();
  final TextEditingController controllerNewPassword = TextEditingController();
  final TextEditingController controllerConfirmNewPassword =
      TextEditingController();
  bool oldPasswordVisible = true;
  bool newPasswordVisible = true;
  bool confirmNewPasswordVisible = true;
  bool isLoading = false;
  bool isUpatePassword = false;
  GetStorageLocalDb getStorageLocalDb = GetStorageLocalDb();
  String textMessageOld = "";
  String textMessageNew = "";
  String textMessageConfirm = "";
  bool isVisibleTextMessageOld = false;
  bool isVisibleTextMessageNew = false;
  bool isVisibleTextMessageConfirm = false;

  bool isMatchNewPassword = false;
  bool isMatchConfirmPassword = false;

  void showTextOldPassword(String text) {
    isVisibleTextMessageOld = true;
    textMessageOld = text;
    update(["textMessageOldPassword"]);
  }

  void showTextNewPassword(String text) {
    isVisibleTextMessageNew = true;
    textMessageNew = text;
    update(["textMessageNewPassword"]);
  }

  void showTextConfirmPassword(String text) {
    isVisibleTextMessageConfirm = true;
    textMessageConfirm = text;
    update(["textMessageConfirmPassword"]);
  }

  void hidenTextOldPassword() {
    isVisibleTextMessageOld = false;
    update(["textMessageOldPassword"]);
  }

  void hidenTextConfirmPassword() {
    isVisibleTextMessageConfirm = false;
    update(["textMessageConfirmPassword"]);
  }

  void hidenTextNewPassword() {
    isVisibleTextMessageNew = false;
    update(["textMessageNewPassword"]);
  }

  void visibleOldPassword() {
    oldPasswordVisible = !oldPasswordVisible;
    update(["ChangeOldPasswordController"]);
  }

  void visibleNewPassword() {
    newPasswordVisible = !newPasswordVisible;
    update(["ChangeNewPasswordController"]);
  }

  void visibleConfirmNewPassword() {
    confirmNewPasswordVisible = !confirmNewPasswordVisible;

    update(["ChangeConfirmPasswordController"]);
  }

  @override
  void onInit() {
    super.onInit();
    // // update(["VisibilityisNotmatch"]);
    // upDateText();
  }

  void goToVerificationView() {
    Get.toNamed("/VerificationView");
  }

  Future<void> updatePassword({required String newPassword}) async {
    try {
      isLoading = true;
      update([
        "ElevatedButton",
      ]);
      isUpatePassword =
          await homeRepository.updatePassword(newPassword: newPassword);

      BotToast.showText(text: "Success change password");
      isLoading = false;
      update([
        "ElevatedButton",
      ]);
      getStorageLocalDb.savePassword(newPassword);

      log("=========================newPassword  getStorageLocalDb"+getStorageLocalDb.getPassword().toString());



      // controllerOldPassword.clear();
      // controllerNewPassword.clear();
      // controllerConfirmNewPassword.clear();
      Get.offNamed("/ProfileView");

    } catch (e) {
      isLoading = false;
      update([
        "ElevatedButton",
      ]);

      log(e.toString());
    }
  }
}
