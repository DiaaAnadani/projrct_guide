// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:first/app/core/constants/colors.dart';
import 'package:first/app/core/constants/theme_color.dart';
import 'package:first/app/core/widgets/custom_circular_progress.dart';
import 'package:first/app/modules/home/profile/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/services/local_storage/get_storage_local_db.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // backgroundColor: colorMainLight,
          backgroundColor: Theme.of(context).primaryColor,
          body: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                        child: Padding(
                      padding: EdgeInsets.only(left: 15, top: 1.5.h, right: 20),
                      child: Row(
                        children: [
                          Text(
                            "Profile".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: colorWhite,
                            ),
                          ),
                          Spacer(),
                          InkWell(
                              onTap: () {
                                GetStorageLocalDb().changeTheme();
                              },
                              child: GetStorageLocalDb().isSavedDarkMode()
                                  ? Icon(
                                      CupertinoIcons.moon_zzz,
                                      size: 28,
                                      color: colorWhite,
                                    )
                                  : Icon(
                                      CupertinoIcons.moon_stars_fill,
                                      size: 28,
                                      color: colorWhite,
                                    )),
                        ],
                      ),
                    )),
                    Positioned(
                        child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 19.h),
                      decoration: BoxDecoration(
                          color: Theme.of(context).dividerColor,
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(18),
                              topRight: Radius.circular(18))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 60),
                            child: Column(
                              children: [
                                Text(
                                  controller.user!.fullName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 25,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                ),
                                Text(
                                  controller.user!.email,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueGrey.shade300,
                                  ),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: InkWell(
                                    onTap: () {
                                      controller.goToFaFavoritesView();
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.favorite,
                                          size: 23,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          "favorites".tr,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 16,),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: InkWell(
                                    onTap: controller.goToAllYourCommentView,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.comment_bank,
                                          size: 23,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          "comment".tr,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // SizedBox(height: 16,),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: InkWell(
                                    onTap: controller.goToChangePasswordView,
                                    child: Row(
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.key,
                                          size: 22,
                                          // color: colorBlack,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          "Change Password".tr,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.arrow_back_ios_new,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: InkWell(
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.settings,
                                          size: 24,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          "settings".tr,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                        ),
                                        Spacer(),
                                        GetBuilder<ProfileController>(
                                            builder: (_) {
                                          return DropdownButton(
                                              focusColor: Colors.black,
                                              dropdownColor: Colors.grey[200],
                                              iconSize: 26,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              items: [
                                                DropdownMenuItem(
                                                  value: 'en',
                                                  child: Text(
                                                    "English",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColorDark,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                DropdownMenuItem(
                                                  value: 'ar',
                                                  child: Text(
                                                    "عربي ",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColorDark,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                              value: controller.langChoose,
                                              onChanged: (value) {
                                                controller
                                                    .onChangeLanguage(value!);
                                                Get.updateLocale(Locale(value));
                                              });
                                        }),
                                        // Icon(
                                        //   Icons.arrow_back_ios_new,
                                        //   size: 20,
                                        // ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return showDialogLogout(
                                                context: context);
                                          });
                                    },
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons
                                              .arrowRightFromBracket,
                                          size: 23,
                                          // color: colorBlack,
                                        ),
                                        SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          "logout".tr,
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Theme.of(context)
                                                .primaryColorDark,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),
                    Positioned(
                      top: 70,
                      left: 140,
                      child: Container(
                        margin: EdgeInsets.only(top: 8),
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: backGroundGrey,
                          ),
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: GetBuilder<ProfileController>(
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
                        // child:  Center(
                        //   child: FaIcon(
                        //             FontAwesomeIcons.user,
                        //             size: 30,
                        //             color: colorBlack,
                        //           ),
                        // ),
                      ),
                    ),
                    Positioned(
                        top: 140,
                        right: 22,
                        child: InkWell(
                          onTap: (() {
                            controller.goToEditeProfileView();
                          }),
                          child: Icon(
                            Icons.border_color_outlined,
                            size: 30,
                          ),
                        )),
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget showDialogLogout({required BuildContext context}) {
    return AlertDialog(
      title: Text("Are You Sure?".tr),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(), child: Text("No".tr)),
        GetBuilder<ProfileController>(
            id: "ProfileController",
            builder: (context) {
              return TextButton(
                  onPressed: () {
                    controller.logOut();
                  },
                  child: controller.isLoading
                      ? CircularWidget(color: colorBlack)
                      :  Text("Yes".tr));
            })
      ],
    );
  }
}
