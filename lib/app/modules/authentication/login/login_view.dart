// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_form_field.dart';
import '../../../core/widgets/new_custom_search.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Form(
        key: formGlobalKey,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsetsDirectional.only(top: 1.5.h, start: 5.w, end: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsetsDirectional.only(
                    top: 3.h,
                  ),
                  height: 250,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/register.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 19,
                ),
                CustomFormField(
                  controller: controller.controllerEmail,
                  labelText: "email".tr,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    var pattern =
                        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                    RegExp regex = RegExp(pattern);
                    // Null check
                    if (value!.isEmpty) {
                      return 'please enter your email'.tr;
                    }
                    // Valid email formatting check
                    else if (!regex.hasMatch(value)) {
                      return 'Enter valid email address'.tr;
                    }
                    // success condition
                    // else {
                    //   controller.email = value;
                    // }
                    return null;
                  },
                ),
                SizedBox(
                  height: 3.h,
                ),
                GetBuilder<LoginController>(
                    id: "visiblePassword",
                    builder: (context) {
                      return CustomFormField(
                          controller: controller.controllerPassword,
                          labelText: "password".tr,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            // RegExp regex = RegExp(
                            //     r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                            if (value!.isEmpty) {
                              return 'Please enter password'.tr;
                            } else if (value.length < 8) {
                              return "Password must be atleast 8 characters long"
                                  .tr;
                            } else {
                              return null;
                            }
                          },
                          obscureText: controller.passwordVisible,
                          //This will obscure text dynamically
                          suffixIcon: IconButton(
                              icon: Icon(
                                // Based on passwordVisible state choose the icon
                                controller.passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: controller.passwordVisible
                                    ? colorBlackBorder
                                    : colorMainLight,
                              ),
                              onPressed: controller.visiblePassword));
                    }),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  height: 7.5.h,
                  width: 55.w,
                  child: GetBuilder<LoginController>(
                      id: "ElevatedButton",
                      builder: (_) {
                        return ElevatedButton(
                            onPressed: controller.isLoading
                                ? null
                                : () async {
                                    if (formGlobalKey.currentState!
                                        .validate()) {
                                      await controller.login();

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            controller.errorApiLogin,
                                            style: TextStyle(
                                                color: colorOrangeAccent),
                                          ),
                                        ),
                                      );
                                    }
                                  },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(colorMainLight),
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
                                ? CircularProgressIndicator(
                                    color: colorWhite,
                                    strokeWidth: 2,
                                  )
                                : Text("LogIn".tr));
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
                          style: TextStyle(
                              color: dark,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Do not Have account?".tr),
                      SizedBox(
                        width: 7,
                      ),
                      InkWell(
                          onTap: controller.gotoRegister,
                          child: Text(
                            "Register".tr,
                            style: TextStyle(
                                color: oooooo,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
