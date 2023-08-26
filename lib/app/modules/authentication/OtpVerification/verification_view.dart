// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_otp_pinput.dart';
import 'verification_controller.dart';

class VerificationView extends GetView<VerificationController> {
  VerificationView({super.key});

  final formKey = GlobalKey<FormState>();

  Color focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
  Color fillColor = Color.fromRGBO(243, 246, 249, 0);
  Color borderColor = Color.fromRGBO(23, 171, 144, 0.4);

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: TextStyle(
      fontSize: 22,
      color: Color.fromRGBO(30, 60, 87, 1),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(19),
      border: Border.all(color: Color.fromRGBO(23, 171, 144, 0.4)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey,
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20),
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/otp.png",
                    height: 30.h,
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Text(
                      " قمنا بإرسال رسالة نصية تحتوي على رمز التفعيل إلى العنوان البريد الخاص بك" +
                          "********@gmail.com"),
                  SizedBox(
                    height: 3.h,
                  ),
                  Directionality(
                    // Specify direction if desired
                    textDirection: TextDirection.ltr,

                    child: Pinput(
                      length: 6,
                      controller: controller.pinController,
                      focusNode: controller.focusNode,
                      // androidSmsAutofillMethod:
                      // AndroidSmsAutofillMethod.smsUserConsentApi,
                      // listenForMultipleSmsOnAndroid: true,
                      defaultPinTheme: defaultPinTheme,
                      validator: (value) {
                        return value == controller.code.toString()
                            ? null
                            : 'Pin is incorrect';
                        //   return value
                      },
                      onClipboardFound: (value) {
                        debugPrint('onClipboardFound: $value');
                        controller.pinController.setText(value);
                      },
                      hapticFeedbackType: HapticFeedbackType.lightImpact,
                      onCompleted: (pin) {
                        debugPrint('onCompleted: $pin');
                      },
                      onChanged: (value) {
                        debugPrint('onChanged: $value');
                      },
                      cursor: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 9),
                            width: 22,
                            height: 1,
                            color: focusedBorderColor,
                          ),
                        ],
                      ),
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      submittedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          color: fillColor,
                          borderRadius: BorderRadius.circular(19),
                          border: Border.all(color: focusedBorderColor),
                        ),
                      ),
                      errorPinTheme: defaultPinTheme.copyBorderWith(
                        border: Border.all(color: Colors.redAccent),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                    // color: Colors.red,
                    height: 17.h,
                    width: 300,
                    child: GetBuilder<VerificationController>(
                        id: "ListView",
                        builder: (context) {
                          return ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              // shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 7.5.h,
                                  width: 80.w,
                                  child: GetBuilder<VerificationController>(
                                      id: "ElevatedButton",
                                      builder: (context) {
                                        return ElevatedButton(
                                            onPressed: () {
                                              controller.isCardEnabled
                                                  .replaceRange(
                                                      0,
                                                      controller
                                                          .isCardEnabled.length,
                                                      [
                                                    for (int i = 0;
                                                        i <
                                                            controller
                                                                .isCardEnabled
                                                                .length;
                                                        i++)
                                                      false
                                                  ]);
                                              controller.stateChange(index);
                                              controller.isCardEnabled[0] ==
                                                      true
                                                  ? controller
                                                      .gotoNewPasswordView()
                                                  : controller
                                                      .gotoProfileView();
                                            },
                                            style: ButtonStyle(
                                                backgroundColor: controller
                                                        .isCardEnabled[index]
                                                    ? MaterialStateProperty.all(
                                                        colorMainLight)
                                                    : MaterialStateProperty.all(
                                                        backGroundGrey),
                                                // MaterialStateProperty.all(colorMain),
                                                textStyle:
                                                    MaterialStateProperty.all(
                                                        TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                ))),
                                            child: Text(
                                              controller.nameButtons[index],
                                              style: TextStyle(
                                                  color: controller
                                                          .isCardEnabled[index]
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ));
                                      }),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return SizedBox(
                                  height: 1.5.h,
                                );
                              },
                              itemCount: controller.nameButtons.length);
                        }),
                  ),
                  //  SizedBox(
                  //     height: 1.5.h,
                  //   ),
                  // SizedBox(
                  //   height: 7.5.h,
                  //   width: 80.w,
                  //   child: ElevatedButton(
                  //       onPressed: controller.gotoNewPasswordView,
                  //       style: ButtonStyle(
                  //           backgroundColor:
                  //               MaterialStateProperty.all(colorMain),
                  //           textStyle: MaterialStateProperty.all(TextStyle(
                  //               fontSize: 12.sp, fontWeight: FontWeight.w400)),
                  //           shape: MaterialStateProperty.all<
                  //               RoundedRectangleBorder>(RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(30.0),
                  //           ))),
                  //       child: Text("Cancel".tr)),
                  // ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "?You haven't received the message yet".tr,
                        style: TextStyle(color: colorBlack, fontSize: 12.sp),
                      ),
                      SizedBox(
                        width: 1.h,
                      ),
                      InkWell(
                        child: Text(
                          "Send again".tr,
                          style: TextStyle(color: oooooo, fontSize: 13.sp),
                        ),
                        onTap: () {
                          log("Send again");
                          controller.getCodeAuthPassword();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
