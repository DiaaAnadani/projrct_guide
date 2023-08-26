// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../constants/colors.dart';

class PinPutOtp extends StatefulWidget {
  const PinPutOtp({Key? key}) : super(key: key);

  @override
  State<PinPutOtp> createState() => _PinPutOtpState();
}

class _PinPutOtpState extends State<PinPutOtp> {
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

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
    /// Optionally you can use form to validate the Pinput
    return Form(
      key: formKey,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Directionality(
                // Specify direction if desired
                textDirection: TextDirection.ltr,

                child: Pinput(
                  controller: pinController,
                  focusNode: focusNode,
                  // androidSmsAutofillMethod:
                  // AndroidSmsAutofillMethod.smsUserConsentApi,
                  // listenForMultipleSmsOnAndroid: true,
                  defaultPinTheme: defaultPinTheme,
                  validator: (value) {
                    return value == '2222' ? null : 'Pin is incorrect';
                  },
                  // onClipboardFound: (value) {
                  //   debugPrint('onClipboardFound: $value');
                  //   pinController.setText(value);
                  // },
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
              // ElevatedButton(

              //     onPressed: () {
              //       formKey.currentState!.validate();
              //     },
              //     child: Text("data"))
              SizedBox(
                height: 6.h,
                width: 29.w,
                child: ElevatedButton(
                    onPressed: () {
                      formKey.currentState!.validate();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(colorMainLight),
                        textStyle: MaterialStateProperty.all(TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.w400)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ))),
                    child: Text("Verification")),
              ),
              SizedBox(
                height: 4.h,
              ),
              InkWell(
                child: Text(
                  "You haven't received the message yet?",
                  style: TextStyle(color: colorMainLight, fontSize: 12.sp),
                ),
                onTap: () {
                  log("message");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
