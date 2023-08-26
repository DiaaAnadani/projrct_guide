// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, must_be_immutable

import 'dart:ui';

import 'package:first/app/core/services/multi_media.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:text_scroll/text_scroll.dart';

import 'package:first/app/core/constants/colors.dart';

import '../../../core/widgets/custom_button_error.dart';
import '../../../core/widgets/custom_circular_progress.dart';
import 'place_details_controller.dart';

class NoIdPlacesDetailsView extends GetView<NoIdPlaceDetailsController> {
  const NoIdPlacesDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: FaIcon(
            FontAwesomeIcons.location,
            size: 30,
            color: colorBlack,
          ),
          onPressed: (() {
            MultiMedia().openMapWithDirection(
                latitude: controller.placeDetails!.latitud,
                longitude: controller.placeDetails!.longitude);
          })),
      body: SafeArea(
        child: GetBuilder<NoIdPlaceDetailsController>(
            id: "SliverAppBar",
            builder: (_) {
              return NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  //Top section
                  return <Widget>[
                    SliverAppBar(
                      //icon back in right
                      actions: [
                        Container(
                          margin: EdgeInsets.all(5),
                          child: CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.black12,
                            child: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        )
                      ],
                      leading: Container(
                        margin: EdgeInsets.all(5),
                        child: InkWell(
                          onTap: () {
                            if (controller.isSavedPl) {
                              controller.deleteSavedForPlace(
                                  placeId: controller.placeDetails!.id);
                            } else {
                              controller.addSavedForPlace(
                                  placeId: controller.placeDetails!.id);
                            }
                          },
                          child: CircleAvatar(
                              radius: 35,
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.favorite,
                                color: controller.isSavedPl
                                    ? Colors.amber
                                    : Colors.grey,
                                size: 35,
                              )),
                        ),
                      ),
                      elevation: 0.0,
                      backgroundColor: Theme.of(context).primaryColor,
                      // backgroundColor: colorMainLight,
                      expandedHeight: 250.0,
                      pinned: true,
                      //Collapsing toolbar  with stack for image and bar
                      flexibleSpace: controller.isLoading
                          ? FlexibleSpaceBar(
                              centerTitle: true,
                              title: Text(controller.placeDetails!.placeName,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 24,
                                  )),
                              background: Stack(
                                children: [
                                  //image
                                  SizedBox(
                                    height: 250,
                                    width: double.infinity,
                                    child: Image.network(
                                      controller.placeDetails!.image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  //bg image
                                  Container(
                                    height: 250,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      // borderRadius: BorderRadius.circular(4),
                                      gradient: const LinearGradient(
                                          colors: [
                                            Colors.black,
                                            Colors.transparent
                                          ],
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : CircularWidget(color: colorBlack),
                    ),
                  ];
                },
                body: SingleChildScrollView(
                  child: Column(children: [
                    textScrollAndRating(),
                    //container
                    Container(
                      // height: 170,
                      width: double.infinity,
                      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        border: Border.all(color: Colors.grey, width: 0.0),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(30, 15)),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        margin: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 10),
                        child: controller.isLoading
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        'الموقع :'.tr,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      SizedBox(
                                        width: 65.w,
                                        height: 20,
                                        child: Text(
                                          controller.placeDetails!.details,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  //  if( controller.placeDetails!.phone !=null)
                                  Row(
                                    children: [
                                      Text(
                                        'الهاتف :'.tr,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      // Icon(Icons.phone,size: 25,color: colorBlack,),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          MultiMedia().goToTel(
                                              phone: controller
                                                  .placeDetails!.phone);
                                        },
                                        child: Text(
                                          controller.placeDetails!.phone.tr,
                                          style: TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //  if( controller.placeDetails!.phone !=null)
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'ساعات العمل :'.tr,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Text(
                                        controller.placeDetails!.workTime.tr,
                                        style: TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            : CircularWidget(color: colorBlack),
                      ),
                    ),
                    controller.linksWidgetState == ServicesWidgetState.error?
                                 CustomButtonError(
                                  text: "Try again".tr,)
                              : controller.linksWidgetState == ServicesWidgetState.empty?
                                SizedBox():    controller.linksWidgetState == ServicesWidgetState.loading?
                            
                                 const CircularWidget(
                                  color: colorBlack,
                                ):
                     Container(
                      // height: 30,
                      width: 65.w,
                      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        border: Border.all(color: Colors.grey, width: 0.0),
                        borderRadius:
                            BorderRadius.all(Radius.elliptical(20, 10)),
                      ),
                      child:IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //  if( controller.placeDetails!.links!.facebook !=null)
                                  IconButton(
                                    onPressed: () {
                                      MultiMedia().goToFaceBook(
                                        url: controller
                                            .placeDetails!.links!.facebook,
                                      );
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.facebook,
                                      color: Colors.blue.shade800,
                                      size: 35,
                                    ),
                                  ),
                                  //  if( controller.placeDetails!.links!.facebook !=null)
                                  VerticalDivider(
                                    indent: 10,
                                    endIndent: 10,
                                    color: colorBlack,
                                    thickness: 2,
                                  ),
                                  //  if( controller.placeDetails!.links!.instagram !=null)
                                  IconButton(
                                    onPressed: () {
                                      MultiMedia().goToInstagram(
                                        url: controller
                                            .placeDetails!.links!.instagram,
                                      );
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.instagram,
                                      color: Colors.pink.shade500,
                                      size: 35,
                                    ),
                                  ),
                                  //  if( controller.placeDetails!.links!.instagram !=null)
                                  VerticalDivider(
                                    indent: 10,
                                    endIndent: 10,
                                    color: colorBlack,
                                    thickness: 2,
                                  ),

                                //  if( controller.placeDetails!.links!.whats !=null)
                                  IconButton(
                                    onPressed: () {
                                      MultiMedia().goToWhats(
                                          phone: controller
                                              .placeDetails!.links!.whats);
                                    },
                                    icon: FaIcon(
                                      FontAwesomeIcons.whatsapp,
                                      color: Colors.green.shade800,
                                      size: 35,
                                    ),
                                  ),
                                ],
                              ),
                            )
                       
                    ) ,

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GetBuilder<NoIdPlaceDetailsController>(
                          id: "getServiceDetails",
                          builder: (context) {
                            switch (controller.servicesWidgetState) {
                              case ServicesWidgetState.error:
                                return CustomButtonError(
                                  text: "Try again".tr,
                                );
                              case ServicesWidgetState.empty:
                              return  SizedBox();
                              case ServicesWidgetState.loading:
                                return const CircularWidget(
                                  color: colorBlack,
                                );
                              case ServicesWidgetState.done:
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8, bottom: 8),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Services".tr,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          InkWell(
                                            onTap: (() {}),
                                            child: Icon(
                                              Icons.arrow_back_ios_outlined,
                                              color: Colors.black,
                                              size: 22,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Divider(
                                      height: 10,
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      height: 20.h,
                                      width: double.infinity,
                                      child: Container(
                                        height: 200,
                                        width: double.infinity,
                                        // color: colorBlackHint,
                                        child: ListView.separated(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: ((context, index) {
                                                  return Stack(
                                                    children: [
                                                      InkWell(
                                                          onTap: () {
                                                            controller
                                                                .goToPlaceServicesView(
                                                                    index:
                                                                        index);
                                                          },
                                                          child: Image.network(
                                                              controller
                                                                  .listService[
                                                                      index]
                                                                  .gallery[0]
                                                                  .url)),
                                                      Positioned(
                                                        child: IconButton(
                                                          onPressed: () {
                                                            if (controller
                                                                    .listIsSavedService![
                                                                index]) {
                                                              controller.deleteSavedForService(
                                                                  serviceId: controller
                                                                      .listService[
                                                                          index]!
                                                                      .id,
                                                                  index: index);
                                                            } else {
                                                              controller.addSavedForService(
                                                                  serviceId: controller
                                                                      .listService[
                                                                          index]!
                                                                      .id,
                                                                  index: index);
                                                            }
                                                          },
                                                          icon: CircleAvatar(
                                                              radius: 35,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child: Icon(
                                                                Icons.favorite,
                                                                color: controller
                                                                            .listIsSavedService![
                                                                        index]
                                                                    ? Colors
                                                                        .amber
                                                                    : Colors
                                                                        .grey,
                                                                size: 35,
                                                              )),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                }),
                                                separatorBuilder:
                                                    ((context, index) {
                                                  return SizedBox(
                                                    width: 1.w,
                                                  );
                                                }),
                                                itemCount: controller
                                                    .listService.length)
                                        
                                      ),
                                    ),
                                  ],
                                );
                            }
                          }),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: 6, start: 6, end: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Comments and Ratings".tr,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Divider(
                            height: 10,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            // color: Colors.grey,
                            child: SizedBox(
                              height: 250,
                              child: Column(
                                children: [
                                  controller.isLoadingComment
                                      ? ListView.separated(
                                          shrinkWrap: true,
                                          itemBuilder: ((context, index) {
                                            return Card(
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  radius: 35,
                                                  child: ClipOval(
                                                      child: SvgPicture.asset(
                                                    "assets/images_svg/person.svg",
                                                    color: colorWhite,
                                                  )),
                                                ),
                                                title: Text(
                                                  controller
                                                      .listPlaceComments[index]
                                                      .fullName,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: colorBlack,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                subtitle: Text(
                                                  controller
                                                      .listPlaceComments[index]
                                                      .content,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: colorBlack,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                trailing: SizedBox(
                                                  width: 14.w,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        controller
                                                            .listPlaceComments[
                                                                index]
                                                            .rate
                                                            .toString(),
                                                        style: TextStyle(
                                                            color: colorBlack,
                                                            fontSize: 14),
                                                      ),
                                                      SizedBox(
                                                        width: 2.w,
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 20,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                          separatorBuilder: ((context, index) {
                                            return SizedBox(
                                              height: 2,
                                            );
                                          }),
                                          // itemCount: controller.listPlaceComments.length
                                          itemCount:
                                              controller.listPlaceComments ==
                                                      null
                                                  ? 0
                                                  : (controller
                                                              .listPlaceComments
                                                              .length >
                                                          2
                                                      ? 2
                                                      : controller
                                                          .listPlaceComments
                                                          .length),
                                        )
                                      : CircularWidget(color: colorBlueAccent),
                                  Button(
                                    titel: 'Show more'.tr,
                                    color: colorOrangeAccent,
                                    onPressed: () {
                                      controller.goToAllComment();
                                    },
                                  ),
                                  SizedBox(
                                    height: 0.4.h,
                                  ),
                                  Button(
                                    titel: "Add Comment and Rating".tr,
                                    color: colorBlueAccent,
                                    onPressed: () {
                                      controller.showRatingDialog();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              );
            }),
      ),
    );
  }

  Widget textScrollAndRating() {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 2.h, top: 1.3.h, start: 3.w),
      child: controller.isLoading
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      controller.placeDetails!.rate.toString(),
                      style: TextStyle(fontSize: 12),
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 25,
                    ),
                  ],
                ),
                SizedBox(
                  width: 4.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: colorBlackHint,
                      )),
                  padding: EdgeInsets.symmetric(horizontal: 2.w),
                  alignment: Alignment.topRight,
                  width: 73.w,
                  height: 6.h,
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: TextScroll(
                            "هدايا و أكسسوارات",
                            // velocity: Velocity(pixelsPerSecond: Offset(50, 0)),
                            pauseBetween: Duration(milliseconds: 2000),
                            delayBefore: Duration(milliseconds: 2000),
                            mode: TextScrollMode.bouncing,
                            textDirection: TextDirection.rtl,
                          ),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          "#  ",
                          style: TextStyle(fontSize: 16, color: colorBlack),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : CircularWidget(color: colorBlack),
    );
  }
}

class Button extends StatelessWidget {
  String titel;
  Color color;
  void Function() onPressed;

  Button({
    Key? key,
    required this.titel,
    required this.color,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            titel,
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w400, color: colorWhite),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // <-- Radius
            ),
          ),
        ),
      ),
    );
  }
}
