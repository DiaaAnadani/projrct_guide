import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../core/constants/colors.dart';
import 'notifications_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notifications",
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
      body: ListView.separated(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.notifications_active,
                          size: 30, color: colorYellowAccent),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "dfghjkbhvnf",
                        // style: GoogleFonts.aleo(
                        //   textStyle: const TextStyle(
                        //     fontSize: 20,
                        //     color: colorBlack,
                        //   ),
                        // ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
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
                           const SizedBox(height: 2,),
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
                    padding: const EdgeInsets.only(left: 27,bottom: 10,),
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
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 5,
          );
        },
      ),
    );
  }
}
