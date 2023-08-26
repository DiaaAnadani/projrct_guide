import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:first/app/core/model/region_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/model/user_model.dart';
import '../../../core/repository/authentication_repository.dart';
import '../../../core/services/local_storage/get_storage_local_db.dart';
import '../../../core/services/storage_service.dart';

class LoginController extends GetxController {
  LoginController({required this.authRepository});
  AuthenticationRepository authRepository;
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();

  String errorApiLogin = "";

  StoragesService storagesService = StoragesService();
  GetStorageLocalDb getStorageLocalDb = GetStorageLocalDb();

  bool passwordVisible = true;
  bool isLoading = false;
  void visiblePassword() {
    passwordVisible = !passwordVisible;
    update(["visiblePassword"]);
  }

  Future<void> login() async {
    try {
      isLoading = true;

      update(["ElevatedButton"]);
      User user = await authRepository.login(
        email: controllerEmail.text,
        password: controllerPassword.text,
      );
      errorApiLogin = "Success login".tr;
      isLoading = false;
      getStorageLocalDb.savePassword(controllerPassword.text);
      storagesService.setUser(user);
      update(["ElevatedButton"]);
      Get.offAllNamed("/HomeView");
    } catch (e) {
      log(e.toString());

      isLoading = false;

      if (authRepository.apiDataRegister["email"] != null) {
        errorApiLogin = "The selected email is invalid".tr;
      } else {
        errorApiLogin = "Data is invalid".tr;
      }

      update(["ElevatedButton"]);
    }
  }

  void gotoRegister() {
    Get.offAndToNamed("/RegisterView");
  }

  void gotoHome() {
    Get.offAndToNamed("/HomeView");
  }
    void goToVerificationView() {
    Get.toNamed("/VerificationView");
  }
}
