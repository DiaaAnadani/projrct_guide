import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/services/api_result.dart';

class VerificationController extends GetxController {
  VerificationController({required this.homeRepository});
  HomeRepository homeRepository;
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  List<bool> isCardEnabled = [false, false];
  List<String> nameButtons = ["Verification".tr, "Cancel".tr];
  final formKey = GlobalKey<FormState>();
  int? code;
  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    getCodeAuthPassword();
  }

  void gotoNewPasswordView() {
    if (formKey.currentState!.validate()) {
      Get.offAndToNamed("/NewPasswordView");
      update(["ElevatedButton"]);
     
    }
  }

  void gotoProfileView() {
    Get.offAndToNamed("/ProfileView");
  }

  void stateChange(int index) {
    isCardEnabled[index] = true;
    update(["ListView"]);
  }

  Future<void> getCodeAuthPassword() async {
    // isLoading = false;
    ApiResult<int> commentsAllResponse =
        await homeRepository.getCodeAuthPassword();
    if (commentsAllResponse.data != null) {
      code = commentsAllResponse.data!;
      log(code.toString());
         BotToast.showText(text:code.toString(),duration: Duration(seconds: 30));
      // isLoading = true;
      // update(["AllCommentController"]);
    } else if (commentsAllResponse.failure != null) {
      log(commentsAllResponse.failure!.message ??
          commentsAllResponse.failure!.code.toString());
      // isLoading = false;
      // update(["AllCommentController"]);
    } else {
      log('data is Empty');
    }
  }
}
