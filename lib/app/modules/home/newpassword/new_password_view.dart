import 'package:first/app/modules/home/newpassword/new_password_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_circular_progress.dart';
import '../../../core/widgets/custom_form_field.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  NewPasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Did you forget your password".tr,
          style: TextStyle(fontWeight: FontWeight.bold, color: oooooo),
        ),
        backgroundColor: colorWhite,
      ),
      body: SafeArea(
        child: Form(
          key: formGlobalKey,
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create new password".tr,
                    style: const TextStyle(
                        color: colorBlack,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        GetBuilder<NewPasswordController>(
                            id: "ChangePasswordController",
                            builder: (_) {
                              return CustomFormField(
                                  controller: controller.controllerNewPassword,
                                  labelText: "New password".tr,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter password'.tr;
                                    } else if (value.length < 8) {
                                      return "Password must be atleast 8 characters long"
                                          .tr;
                                    } else {
                                      return null;
                                    }
                                  },
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
                                          controller.visibleNewPassword));
                            }),
                        SizedBox(
                          height: 3.h,
                        ),
                        GetBuilder<NewPasswordController>(
                            id: "ChangePasswordController",
                            builder: (_) {
                              return CustomFormField(
                                  controller:
                                      controller.controllerConfirmNewPassword,
                                  labelText: 'confirm password'.tr,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "plz confirm password".tr;
                                    } else if (value !=
                                        controller.controllerNewPassword.text) {
                                      return "not match".tr;
                                    } else {
                                      return null;
                                    }
                                  },
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
                                          .visibleConfirmNewPassword));
                            }),
                        SizedBox(
                          height: 4.h,
                        ),
                        Center(
                          child: SizedBox(
                            height: 7.5.h,
                            width: 45.w,
                            child: GetBuilder<NewPasswordController>(
                                id: "ElevatedButton",
                                builder: (_) {
                                  return ElevatedButton(
                                      onPressed: controller.isLoading
                                          ? null
                                          : () async {
                                              if (formGlobalKey.currentState!
                                                  .validate()) {
                                                controller.updatePassword(
                                                    newPassword: controller
                                                        .controllerNewPassword
                                                        .text);
                                              }
                                            },
                                      style: ButtonStyle(
                                          backgroundColor:
                                           MaterialStateProperty.all(Theme.of(context).primaryColor),
                                              // MaterialStateProperty.all(
                                              //     colorMainLight),
                                          textStyle: MaterialStateProperty.all(
                                              const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w400)),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ))),
                                      child: controller.isLoading
                                          ? const CircularWidget(
                                              color: colorWhite)
                                          : Text(
                                              "Submit".tr,
                                              style: const TextStyle(
                                                  color: colorWhite),
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
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
