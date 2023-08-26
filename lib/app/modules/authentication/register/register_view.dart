import 'dart:developer';

import 'package:first/app/core/widgets/custom_form_field.dart';
import 'package:first/app/modules/authentication/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_dropdown_search.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            backgroundColor:  Theme.of(context).primaryColor,
            // backgroundColor: colorMainLight,
            expandedHeight: 200.0,
            // floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                // titlePadding:EdgeInsets.only(bottom: 0,left: 230),
                title: Text("Sing Up".tr,
                    style: const TextStyle(
                      color: colorWhite,
                      fontSize: 26,
                    )),
                background: Stack(
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      child: Image.asset(
                        "assets/images/register.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.circular(4),
                        gradient: LinearGradient(
                            colors: [Colors.black, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                    ),
                  ],
                )),
          ),
        ];
      },
      body: SingleChildScrollView(
        child: Form(
            key: formGlobalKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.h,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 5.h,
                    ),
                    CustomFormField(
                      controller: controller.controllerUserName,
                      labelText: "username".tr,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Field is required".tr;
                        } else if (value.length > 30) {
                          return " username should not be longer than 30";
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 3.h,
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
                        else {
                          controller.email = value;
                        }
                        return null;
                      },
                    ),
                    GetBuilder<RegisterController>(
                        id: 'showValidateEmail',
                        builder: (context) {
                          return Visibility(
                            visible: controller.validateEmail,
                            child: Align(
                              alignment: AlignmentDirectional.bottomStart,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 12, top: 10),
                                child: Text(
                                  controller.errorApiRegister,
                                  style: const TextStyle(
                                    color: Color(0xFFD32F2F),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 3.h,
                    ),
                    GetBuilder<RegisterController>(
                        id: "visiblePassword",
                        builder: (_) {
                          return CustomFormField(
                              controller: controller.controllerPassword,
                              labelText: "password".tr,
                              keyboardType: TextInputType.streetAddress,
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
                                         : Theme.of(context).primaryColor,
                                        // : colorMainLight,
                                  ),
                                  onPressed: controller.visiblePassword));
                        }),
                    SizedBox(
                      height: 3.h,
                    ),
                    GetBuilder<RegisterController>(
                        id: "confirmVisiblePassword",
                        builder: (_) {
                          return CustomFormField(
                            controller: controller.controllerConfirmPassword,
                            labelText: "confirm password".tr,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "plz confirm password".tr;
                              } else if (value !=
                                  controller.controllerPassword.text) {
                                return "not match".tr;
                              } else {
                                return null;
                              }
                            },
                            obscureText: controller.confirmPasswordVisible,
                            //This will obscure text dynamically
                            suffixIcon: IconButton(
                                icon: Icon(
                                  // Based on passwordVisible state choose the icon
                                  controller.confirmPasswordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: controller.confirmPasswordVisible
                                      ? colorBlackBorder
                                       : Theme.of(context).primaryColor,
                                      // : colorMainLight,
                                  // color: Theme.of(context).primaryColorDark
                                ),
                                onPressed: controller.confirmVisiblePassword),
                          );
                        }),
                    // SizedBox(
                    //   height: 3.h,
                    // ),
                    // CustomFormField(
                    //   controller: controller.controllerPhone,
                    //   labelText: "phone number".tr,
                    //   keyboardType: TextInputType.phone,
                    //   validator: (value) {
                    //     String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
                    //     RegExp regExp = RegExp(pattern);
                    //     if (value!.isEmpty) {
                    //       return "phone number is required".tr;
                    //     } else if (!regExp.hasMatch(value)) {
                    //       return 'Please enter valid mobile number'.tr;
                    //     } else {
                    //       return null;
                    //     }
                    //   },
                    // ),
                    SizedBox(
                      height: 3.h,
                    ),
                    GetBuilder<RegisterController>(
                        id: 'changeSelectedAreaDropDown',
                        builder: (context) {
                          return SearchDropdown(
                            textEditingSearchController:
                                controller.textEditingSearchController,
                            hint: 'select area'.tr,
                            hintSearch: 'search area'.tr,
                            items: controller.allRegion
                                ?.map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item.name,
                                        style: const TextStyle(
                                            fontSize: 14, color: colorBlack),
                                      ),
                                    ))
                                .toList(),
                            selectedValue: controller.selectedAreaValue,
                            onChanged: (value) {
                              controller.changeSelectedAreaDropDown(value!);
                            },
                          );
                        }),
                    GetBuilder<RegisterController>(
                        id: 'showValidateRegion',
                        builder: (context) {
                          return Visibility(
                            visible: controller.validateRegion,
                            child: Align(
                              alignment: AlignmentDirectional.bottomStart,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 12, top: 10),
                                child: Text(
                                  "select region is required".tr,
                                  style: const TextStyle(
                                    color: Color(0xFFD32F2F),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 3.h,
                    ),
                    GetBuilder<RegisterController>(
                        id: 'changeSelectedStreetDropDown',
                        builder: (context) {
                          return SearchDropdown(
                            textEditingSearchController:
                                controller.textEditingSearchController,
                            hint: 'select street'.tr,
                            hintSearch: 'search street'.tr,
                            items: controller.allStreet
                                ?.map((item) => DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item.name,
                                        style: const TextStyle(
                                            fontSize: 14, color: colorBlack),
                                      ),
                                    ))
                                .toList(),
                            selectedValue: controller.selectedStreetValue,
                            onChanged: (value) {
                              controller.changeSelectedStreetDropDown(value!);
                            },
                          );
                        }),
                    GetBuilder<RegisterController>(
                        id: 'showValidateStreet',
                        builder: (context) {
                          return Visibility(
                            visible: controller.validateStreet,
                            child: Align(
                              alignment: AlignmentDirectional.bottomStart,
                              child: Padding(
                                padding: const EdgeInsetsDirectional.only(
                                    start: 12, top: 10),
                                child: Text(
                                  "select street is required".tr,
                                  style: const TextStyle(
                                    color: Color(0xFFD32F2F),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 0.9.h,
                    ),
                    SizedBox(
                      height: 11.h,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: GetBuilder<RegisterController>(
                            id: "onTapChoseGender",
                            builder: (context) {
                              return GridView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(15),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 3,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 8),
                                  itemCount: 2,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    controller.isCardEnabled.add(false);
                                    return GestureDetector(
                                      onTap: () {
                                        controller.onTapChoseGender(index);
                                      },
                                      child: Card(
                                        color: controller.isCardEnabled[index]
                                            ? colorOrangeAccent
                                            : backGroundGrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              controller.name[index]
                                                  ["iconGender"],
                                              color: controller
                                                      .isCardEnabled[index]
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                            SizedBox(
                                              width: 1.h,
                                            ),
                                            Text(
                                              controller.name[index]["gender"],
                                              style: TextStyle(
                                                  color: controller
                                                          .isCardEnabled[index]
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ),
                    ),
                    // CustomMultiButtons(onTap: ,),
                    SizedBox(
                      height: 2.h,
                    ),
                    SizedBox(
                      height: 7.5.h,
                      width: 55.w,
                      child: GetBuilder<RegisterController>(
                          id: "ElevatedButton",
                          builder: (_) {
                            return ElevatedButton(
                                onPressed: controller.isLoading
                                    ? null
                                    : () async {
                                        if (formGlobalKey
                                                .currentState!
                                                .validate() &&
                                            controller.selectedAreaValue !=
                                                null &&
                                            controller.selectedStreetValue !=
                                                null &&
                                            controller.typeGender.isNotEmpty) {
                                          await controller.register();
                                        }
                                        if (controller.selectedAreaValue ==
                                            null) {
                                          controller.showValidateRegion();
                                        }
                                        if (controller.selectedStreetValue ==
                                            null) {
                                          controller.showValidateStreet();
                                        }
                                        if (controller.typeGender.isEmpty) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "select gender is required"
                                                      .tr),
                                            ),
                                          );
                                        }
                                      },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
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
                                    ? const CircularProgressIndicator(
                                        color: colorWhite,
                                        strokeWidth: 2,
                                      )
                                    : Text("Sing Up".tr));
                          }),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Do you have a already account?".tr),
                        SizedBox(
                          width: 2.w,
                        ),
                        InkWell(
                            onTap: controller.gotoLogIn,
                            child: Text(
                              "LogIn".tr,
                              style: TextStyle(
                                  color: oooooo,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            )),
      ),
    )));
  }
}
