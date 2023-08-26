// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import 'notification_details_controller.dart';

class NotificationDetailsView extends GetView<NotificationDetailsController> {
  const NotificationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "notification".tr,
          // "${getLang(context, "notification")}",
          // style: GoogleFonts.alata(
          //   textStyle: const TextStyle(
          //     fontSize: 27,
          //     color: colorWhite,
          //     fontStyle: FontStyle.italic,
          //   ),
          // ),
        ),
        backgroundColor: colorMain,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.notifications_active,
                    size: 30, color: colorYellowAccent),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "login".tr,
                  // style: GoogleFonts.acme(
                  //   textStyle: const TextStyle(
                  //       fontSize: 20,
                  //       color: colorMain,
                  //       fontWeight: FontWeight.bold),
                  // ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, right: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.date_range,
                              size: 20, color: colorBlackHint),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "32/6/233",
                            // style: GoogleFonts.aleo(
                            //   textStyle: const TextStyle(
                            //     fontSize: 14,
                            //     color: colorBlackHint,
                            //   ),
                            // ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 24),
                        child: Text(
                          "5:22",
                          // style: GoogleFonts.aleo(
                          //   textStyle: const TextStyle(
                          //     fontSize: 12,
                          //     color: colorBlackHint,
                          //   ),
                          // ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 27,
                bottom: 10,
              ),
              child: Container(
                height: 70,
                width: 200,
                // color: colorPink,
                child: Text(
                  "new Flutter Awesome Notification +"
                  " GetX + Flutter Launcher Icons",
                  maxLines: 2,
                  // style: GoogleFonts.aleo(
                  //   textStyle: const TextStyle(
                  //     fontSize: 18,
                  //     color: colorBlack,
                  //   ),
                  // ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black12,
                        // borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: colorBlack,
                          size: 20,
                        ),
                      ),
                    )),
                SizedBox(
                  width: 5,
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "username".tr,
                      style: TextStyle(fontSize: 20),
                    ))
              ],
            ),
            GetBuilder<NotificationDetailsController>(
                id: "changeSelectLang",
                builder: (context) {
                  return DropdownButton(
                      items: [
                        DropdownMenuItem(
                          value: 'en',
                          child: Text(
                            "en",
                            style: TextStyle(color: colorBlack),
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'ar',
                          child: Text(
                            "ar ",
                            style: TextStyle(color: colorBlack),
                          ),
                        ),
                      ],
                      value: controller.appLocal,
                      onChanged: (value) {
                        controller.onChangeLanguage(value!);
                        Get.updateLocale(Locale(value));
                      });
                }),
          ],
        ),
      ),
    );
  }
}
