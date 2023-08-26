import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/widgets/custom_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_form_field.dart';
import 'change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  ChangePasswordView({super.key});

  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Changing your password".tr,
            style: TextStyle(fontWeight: FontWeight.bold, color: oooooo),
          ),
          backgroundColor: colorWhite,
        ),
        body: SafeArea(
          child: Form(
            key: formGlobalKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsetsDirectional.only(
                    top: 1.5.h, start: 5.w, end: 5.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 3.h,
                    ),
                    GetBuilder<ChangePasswordController>(
                        id: "ChangeOldPasswordController",
                        builder: (_) {
                          return Column(
                            children: [
                              CustomFormField(
                                  onTap: () {
                                    controller.hidenTextOldPassword();
                                  },
                                  controller: controller.controllerOldPassword,
                                  labelText: "password".tr,
                                  keyboardType: TextInputType.text,
                                  obscureText: controller.oldPasswordVisible,
                                  //This will obscure text dynamically
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        controller.oldPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: controller.oldPasswordVisible
                                            ? colorBlackBorder
                                             : Theme.of(context).primaryColor,
                                            // : colorMainLight,
                                      ),
                                      onPressed:
                                          controller.visibleOldPassword)),
                              GetBuilder<ChangePasswordController>(
                                  id: "textMessageOldPassword",
                                  builder: (context) {
                                    return controller.isVisibleTextMessageOld
                                        ? Text(
                                            controller.textMessageOld,
                                            style: const TextStyle(
                                                color: Colors.red),
                                          )
                                        : const SizedBox();
                                  }),
                            ],
                          );
                        }),
                    SizedBox(
                      height: 3.h,
                    ),
                    GetBuilder<ChangePasswordController>(
                        id: "ChangeNewPasswordController",
                        builder: (_) {
                          return Column(
                            children: [
                              CustomFormField(
                                  onTap: () {
                                    controller.hidenTextNewPassword();
                                  },
                                  controller: controller.controllerNewPassword,
                                  labelText: "New password".tr,
                                  keyboardType: TextInputType.text,
                                  obscureText: controller.newPasswordVisible,
                                  //This will obscure text dynamically
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        controller.newPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: controller.newPasswordVisible
                                            ? colorBlackBorder
                                             : Theme.of(context).primaryColor,
                                            // : colorMainLight,
                                      ),
                                      onPressed:
                                          controller.visibleNewPassword)),
                              GetBuilder<ChangePasswordController>(
                                  id: "textMessageNewPassword",
                                  builder: (context) {
                                    return controller.isVisibleTextMessageNew
                                        ? Text(
                                            controller.textMessageNew,
                                            style: const TextStyle(
                                                color: Colors.red),
                                          )
                                        : const SizedBox();
                                  }),
                            ],
                          );
                        }),
                    SizedBox(
                      height: 3.h,
                    ),
                    GetBuilder<ChangePasswordController>(
                        id: "ChangeConfirmPasswordController",
                        builder: (_) {
                          return Column(
                            children: [
                              CustomFormField(
                                  onTap: () {
                                    controller.hidenTextConfirmPassword();
                                  },
                                  controller:
                                      controller.controllerConfirmNewPassword,
                                  labelText: 'confirm password'.tr,
                                  keyboardType: TextInputType.text,
                                  obscureText:
                                      controller.confirmNewPasswordVisible,
                                  //This will obscure text dynamically
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        controller.confirmNewPasswordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color:
                                            controller.confirmNewPasswordVisible
                                                ? colorBlackBorder
                                                 : Theme.of(context).primaryColor,
                                                // : colorMainLight,
                                      ),
                                      onPressed: controller
                                          .visibleConfirmNewPassword)),
                              GetBuilder<ChangePasswordController>(
                                  id: "textMessageConfirmPassword",
                                  builder: (context) {
                                    return controller
                                            .isVisibleTextMessageConfirm
                                        ? Text(
                                            controller.textMessageConfirm,
                                            style: const TextStyle(
                                                color: Colors.red),
                                          )
                                        : const SizedBox();
                                  }),
                            ],
                          );
                        }),
                    SizedBox(
                      height: 4.h,
                    ),
                    SizedBox(
                      height: 7.5.h,
                      width: 45.w,
                      child: GetBuilder<ChangePasswordController>(
                          id: "ElevatedButton",
                          builder: (_) {
                            return ElevatedButton(
                                onPressed: controller.isLoading
                                    ? null
                                    : () async {
                                        FocusScope.of(context).unfocus();

                                        controller.isMatchNewPassword = false;
                                        controller.isMatchConfirmPassword =
                                            false;

                                        if (controller.controllerOldPassword
                                            .text.isEmpty) {
                                          controller.showTextOldPassword(
                                              "ادخل كلمة المرور القديمة");
                                          controller.hidenTextNewPassword();
                                          controller.hidenTextConfirmPassword();
                                        } else if (controller
                                                .controllerOldPassword.text !=
                                            await controller.getStorageLocalDb
                                                .getPassword()) {
                                          controller.showTextOldPassword(
                                              "not match".tr);
                                          controller.hidenTextNewPassword();
                                          controller.hidenTextConfirmPassword();
                                        } else {
                                          controller.isMatchNewPassword = true;
                                        }

                                        if (controller.isMatchNewPassword) {
                                          controller.isMatchConfirmPassword =
                                              false;

                                          if (controller.controllerNewPassword
                                              .text.isEmpty) {
                                            controller.hidenTextOldPassword();
                                            controller
                                                .hidenTextConfirmPassword();
                                            controller.showTextNewPassword(
                                                "ادخل كلمة المرور الجديدة");
                                          } else if (controller
                                                  .controllerNewPassword
                                                  .text
                                                  .length <
                                              8) {
                                            controller.hidenTextOldPassword();

                                            controller
                                                .hidenTextConfirmPassword();

                                            controller.showTextNewPassword(
                                                "Password must be atleast 8 characters long"
                                                    .tr);
                                          } else {
                                            controller.isMatchConfirmPassword =
                                                true;
                                          }
                                        }

                                        if (controller.isMatchConfirmPassword) {
                                          if (controller
                                              .controllerConfirmNewPassword
                                              .text!
                                              .isEmpty) {
                                            controller.hidenTextOldPassword();
                                            controller.hidenTextNewPassword();

                                            controller.showTextConfirmPassword(
                                                "plz confirm password".tr);
                                          } else if (controller
                                                  .controllerConfirmNewPassword
                                                  .text !=
                                              controller
                                                  .controllerNewPassword.text) {
                                            controller.hidenTextOldPassword();
                                            controller.hidenTextNewPassword();
                                            controller.showTextConfirmPassword(
                                                "not match".tr);
                                          } else {
                                            controller
                                                .hidenTextConfirmPassword();
                                            controller.updatePassword(
                                                newPassword: controller
                                                    .controllerNewPassword
                                                    .text);
                                          }
                                        }
                                      },
                                style: ButtonStyle(
                                  backgroundColor:  MaterialStateProperty.all(Theme.of(context).primaryColor),
                                    // backgroundColor: MaterialStateProperty.all(
                                    //     colorMainLight),
                                    textStyle: MaterialStateProperty.all(
                                        const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w400)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ))),
                                child: controller.isLoading
                                    ? const CircularWidget(color: colorWhite)
                                    : Text(
                                        "Update".tr,
                                        style:
                                            const TextStyle(color: colorWhite),
                                      )

                                // child: controller.isLoading
                                //     ? CircularProgressIndicator(
                                //         color: colorWhite,
                                //         strokeWidth: 2,
                                //       )
                                //     : Text("LogIn".tr)
                                );
                          }),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: controller.goToVerificationView,
                            child: Text(
                              "Did you forget your password".tr,
                              style: const TextStyle(color: dark),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
