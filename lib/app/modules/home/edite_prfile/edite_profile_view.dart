import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_circular_progress.dart';
import '../../../core/widgets/custom_dropdown_search.dart';
import '../../../core/widgets/custom_form_field.dart';
import 'edite_profile_controller.dart';

class EditeProfileView extends GetView<EditeProfileController> {
  final GlobalKey<FormState> formGlobalKey = GlobalKey<FormState>();

  EditeProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edite Profile".tr),
        centerTitle: true,
        backgroundColor:  Theme.of(context).primaryColor,
        // backgroundColor: colorMainLight,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: formGlobalKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 3.h,
                ),
                child: GetBuilder<EditeProfileController>(builder: (context) {
                  return Column(
                    children: [
                      // RichText(text: text)
                      // Container(
                      //   height: 5.h,
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(top: 8),
                      //   width: 140,
                      //   height: 140,
                      //   decoration: BoxDecoration(
                      //     border: Border.all(
                      //       width: 2,
                      //       color: backGroundGrey,
                      //     ),
                      //     color: Colors.white,
                      //     shape: BoxShape.circle,
                      //   ),
                      //   child: Image.asset("assets/images/team.png"),
                      // ),
                      Container(
                        margin: EdgeInsets.only(top: 8),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(
                            width: 4,
                            color: backGroundGrey,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: GetBuilder<EditeProfileController>(
                            id: "Imagegender",
                            builder: (context) {
                              return controller.user!.gender == "male"
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child:
                                          Image.asset("assets/images/man.png"),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                          "assets/images/woman.png"),
                                    );
                            }),
                      ),
                      Container(
                        height: 1.h,
                      ),
                      CustomFormField(
                        controller: controller.fullnameteEdCont,
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
                      GetBuilder<EditeProfileController>(
                          id: 'changeSelectedAreaDropDown',
                          builder: (context) {
                            return SearchDropdown(
                              textEditingSearchController:
                                  controller.textEditingSearchController,
                              hint: controller.nameAreaUser ?? "",
                              // hint: 'select area'.tr,
                              hintSearch: 'search area'.tr,
                              items: controller.allRegion!
                                  .map((item) => DropdownMenuItem(
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
                      GetBuilder<EditeProfileController>(
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
                      GetBuilder<EditeProfileController>(
                          id: 'changeSelectedStreetDropDown',
                          builder: (context) {
                            return SearchDropdown(
                              textEditingSearchController:
                                  controller.textEditingSearchController,
                              hint: controller.nameStreetUser ?? "",
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
                      GetBuilder<EditeProfileController>(
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
                        height: 2.h,
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        // color: Colors.red,
                        height: 11.h,
                        width: 80.w,
                        child: GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 3,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 8),
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int index) {
                              return GetBuilder<EditeProfileController>(
                                  id: "GridViewEditeProfileController",
                                  builder: (_) {
                                    return GestureDetector(
                                      onTap: () {
                                        controller.isCardEnabledGrade
                                            .replaceRange(
                                                0,
                                                controller
                                                    .isCardEnabledGrade.length,
                                                [
                                              for (int i = 0;
                                                  i <
                                                      controller
                                                          .isCardEnabledGrade
                                                          .length;
                                                  i++)
                                                false
                                            ]);
                                        controller.stateChange(index);
                                        controller.isCardEnabledGrade[0] == true
                                            ? controller.onTapGrade()
                                            : controller.gotoProfileView();
                                      },
                                      child: Card(
                                        color:
                                            controller.isCardEnabledGrade[index]
                                                ?  Theme.of(context).primaryColor
                                                // colorMainLight
                                                : backGroundGrey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Center(
                                          child: Text(
                                            controller.namesFilter[index],
                                            style: TextStyle(
                                                color: controller
                                                            .isCardEnabledGrade[
                                                        index]
                                                    ? Colors.white
                                                    : Colors.black,
                                                fontSize: 17),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     SizedBox(
                      //       height: 7.h,
                      //       width: 40.w,
                      //       child: GetBuilder<EditeProfileController>(
                      //           id: "ElevatedButton",
                      //           builder: (_) {
                      //             return ElevatedButton(
                      //               onPressed: controller.isLoading
                      //                   ? null
                      //                   : () {
                      //                       controller.testAreaAndStreet();

                      //                       log("========================" +
                      //                           controller.user.streetId
                      //                               .toString());
                      //                       log("========================" +
                      //                           controller.user.regionId
                      //                               .toString());
                      //                       log("========================" +
                      //                           controller.user.fullName
                      //                               .toString());
                      //                     },
                      //               style: ButtonStyle(
                      //                   backgroundColor:
                      //                       MaterialStateProperty.all(
                      //                           colorMain),
                      //                   textStyle: MaterialStateProperty.all(
                      //                       const TextStyle(
                      //                           fontSize: 20,
                      //                           fontWeight: FontWeight.w400)),
                      //                   shape: MaterialStateProperty.all<
                      //                           RoundedRectangleBorder>(
                      //                       RoundedRectangleBorder(
                      //                     borderRadius:
                      //                         BorderRadius.circular(40.0),
                      //                   ))),
                      //               child: controller.isLoading
                      //                   ? const CircularWidget(
                      //                       color: colorWhite)
                      //                   : Text("Save".tr,
                      //                       style: const TextStyle(
                      //                           color: colorWhite)),
                      //             );
                      //           }),
                      //     ),
                      //     SizedBox(
                      //       height: 7.h,
                      //       width: 40.w,
                      //       child: GetBuilder<EditeProfileController>(
                      //           id: "ElevatedButton",
                      //           builder: (_) {
                      //             return ElevatedButton(
                      //                 onPressed: () {},
                      //                 // onPressed: controller.isLoading
                      //                 //     ? null
                      //                 //     : () {
                      //                 //         // ScaffoldMessenger.of(context)
                      //                 //         //     .showSnackBar(
                      //                 //         //   SnackBar(
                      //                 //         //       content: Text(
                      //                 //         //     controller!.error == null
                      //                 //         //         ? "c"
                      //                 //         //         : controller.error,
                      //                 //         //     style: TextStyle(
                      //                 //         //         color: colorOrangeAccent),
                      //                 //         //   )),
                      //                 //         // );
                      //                 //         // if (formGlobalKey
                      //                 //         //         .currentState!
                      //                 //         //         .validate() &&
                      //                 //         //     controller.selectedAreaValue !=
                      //                 //         //         null &&
                      //                 //         //     controller.selectedStreetValue !=
                      //                 //         //         null &&
                      //                 //         //     controller.typeGender.isNotEmpty) {
                      //                 //         //   controller.register();
                      //                 //         // }
                      //                 //         // if (controller.selectedAreaValue ==
                      //                 //         //     null) {
                      //                 //         //   controller.showValidateRegion();
                      //                 //         // }
                      //                 //         // if (controller.selectedStreetValue ==
                      //                 //         //     null) {
                      //                 //         //   controller.showValidateStreet();
                      //                 //         // }
                      //                 //         // if (controller.typeGender.isEmpty) {
                      //                 //         //   ScaffoldMessenger.of(context)
                      //                 //         //       .showSnackBar(
                      //                 //         //      SnackBar(
                      //                 //         //       content: Text(
                      //                 //         //           "select gender is required".tr),
                      //                 //         //     ),
                      //                 //           );
                      //                 //         }
                      //                 //       },
                      //                 style: ButtonStyle(
                      //                     backgroundColor:
                      //                         MaterialStateProperty.all(
                      //                             colorMain),
                      //                     textStyle: MaterialStateProperty.all(
                      //                         const TextStyle(
                      //                             fontSize: 20,
                      //                             fontWeight: FontWeight.w400)),
                      //                     shape: MaterialStateProperty.all<
                      //                             RoundedRectangleBorder>(
                      //                         RoundedRectangleBorder(
                      //                       borderRadius:
                      //                           BorderRadius.circular(40.0),
                      //                     ))),
                      //                 child: Text("Cancel".tr));
                      //           }),
                      //     ),
                      //   ],
                      // ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  );
                }),
              ),
            )),
      ),
    );
  }
}
