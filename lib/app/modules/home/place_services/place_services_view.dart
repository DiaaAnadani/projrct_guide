import 'dart:developer';

import 'package:first/app/modules/home/place_services/place_services_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/services/multi_media.dart';

class PlaceServicesView extends GetView<PlaceServicesController> {
  const PlaceServicesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<PlaceServicesController>(
          id: "serviceWidget",
          builder: (_) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: Stack(
                    children: [
                      PageView.builder(
                        itemBuilder: (context, index) {
                          return SizedBox(
                            width: double.infinity,
                            height: 50.h,
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 50.h,
                                  child: Image.network(
                                    controller.gallery[index].url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // Container(
                                //   width: double.infinity,
                                //   height: 50.h,
                                //   decoration: const BoxDecoration(
                                //     gradient: LinearGradient(
                                //         colors: [
                                //           Colors.black,
                                //           Colors.transparent
                                //         ],
                                //         begin: Alignment.bottomCenter,
                                //         end: Alignment.topCenter),
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                        itemCount: controller.gallery.length,
                        controller: controller.pageController,
                        onPageChanged: (page) {
                          controller.changeServiceIndex(page);
                          log(page.toString());
                        },
                      ),
                      // Padding(
                      //   padding: EdgeInsetsDirectional.only(top: 3.h, end: 6.w),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.end,
                      //     children: [
                      //       Container(
                      //         decoration: BoxDecoration(
                      //             color: Colors.black26.withOpacity(0.2),
                      //             shape: BoxShape.circle),
                      //         child: IconButton(
                      //             icon: const Icon(
                      //               Icons.arrow_forward_ios_outlined,
                      //               color: Colors.white,
                      //               size: 22,
                      //             ),
                      //             onPressed: () {
                      //               print(
                      //                   "current index:${controller.serviceIndex}");
                      //             }),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible:
                                    controller.serviceIndex > 0 ? true : false,
                                child: InkWell(
                                  child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          colorPink.withOpacity(0.5),
                                      child: const Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                        size: 18,
                                      )),
                                  onTap: () {
                                    if (controller.serviceIndex > 0) {
                                      controller.pageController.animateToPage(
                                          controller.serviceIndex - 1,
                                          duration:
                                              const Duration(milliseconds: 600),
                                          curve: Curves.easeIn);
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Visibility(
                                visible: controller.serviceIndex <
                                        controller.gallery.length - 1
                                    ? true
                                    : false,
                                child: InkWell(
                                  child: CircleAvatar(
                                      backgroundColor:
                                          colorPink.withOpacity(0.5),
                                      radius: 20,
                                      child: const Icon(
                                        Icons.arrow_forward_ios_outlined,
                                        color: Colors.white,
                                        size: 18,
                                      )),
                                  onTap: () {
                                    if (controller.serviceIndex <
                                        (controller.gallery.length - 1)) {
                                      controller.pageController.animateToPage(
                                          controller.serviceIndex + 1,
                                          duration:
                                              const Duration(milliseconds: 600),
                                          curve: Curves.easeIn);
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        top: 2.h, start: 4.w, end: 4.w, bottom: 2.h),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),
                                color: Colors.white70,
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    controller.serviceDetailsModel!.title,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w400,
                                      color:  Theme.of(context).primaryColor,
                                      // color: colorMainLight,
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: SingleChildScrollView(
                                        child: Text(
                                          controller
                                              .serviceDetailsModel!.content,
                                          style: TextStyle(
                                            fontSize: 22,
                                            color: colorBlack,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        SizedBox(
                          height: 6.h,
                          child: ElevatedButton(
                              onPressed: () {
                                MultiMedia().goToWhats(
                                    phone: controller.serviceDetailsModel!.place
                                        .links!.whats);
                              },
                              style: ButtonStyle(
                                backgroundColor:  MaterialStateProperty.all(Theme.of(context).primaryColor),
                                  // backgroundColor:
                                  //     MaterialStateProperty.all(colorMainLight),
                                  textStyle: MaterialStateProperty.all(
                                      const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: colorWhite)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                  ))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FaIcon(
                                    FontAwesomeIcons.whatsapp,
                                    color: Colors.green.shade800,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  const Text(
                                    " التواصل عبر الواتس",
                                  )
                                ],
                              )),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 6.h,
                          child: ElevatedButton(
                              onPressed: controller.goToPlaceDetailsView,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      colorOrangeAccent),
                                  textStyle: MaterialStateProperty.all(
                                      TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: colorWhite)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.0),
                                  ))),
                              child: const Center(
                                child: Text(
                                  "عرض بطاقة المعلومات",
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
