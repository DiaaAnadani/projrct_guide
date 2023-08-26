import 'package:first/app/core/widgets/custom_circular_progress.dart';
import 'package:first/app/modules/home/home_detiles/home_detailes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_button_error.dart';
import '../../../core/widgets/custom_card_place.dart';
import '../../../core/widgets/custom_text_field.dart';

class HomeDetailsView extends GetView<HomeDetaileController> {
  const HomeDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: colorMainLight,
        backgroundColor: Theme.of(context).primaryColor,
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.getAllCategories();
            await controller.getAllPromo();
            await controller.getPlacesRating();
          },
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: 9.w, top: 1.h),
                    child: Text(
                      "Guide".tr,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                            color: colorWhite, letterSpacing: .5, fontSize: 35),
                      ),
                      // style:const TextStyle(
                      //     fontSize: 30,
                      //     color: colorBlack,
                      //     fontWeight: FontWeight.bold)
                    ),
                  ),
                  const Spacer(),
                  // Padding(
                  //   padding: const EdgeInsets.only(top: 2, left: 10, right: 10),
                  //   child: InkWell(
                  //       onTap: () {
                  //         controller.goToNotificationView();
                  //       },
                  //       child: const Icon(Icons.notifications,
                  //           size: 27, color: colorWhite)),
                  // ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 10, top: 2, end: 10),
                child:
                    // SizedBox(
                    //     height: 7.h,
                    //     width:double.infinity,
                    //     child: CustomSearchTextField(
                    //         onTap: controller.goToSearchPlaceView)),
                    CustomTextField(
                  onTap: controller.goToSearchPlaceView,
                  cursorColor: Colors.black12,
                  fillColor: Colors.white,
                  textAlign: TextAlign.start,
                  hintText: 'Search HomeDetailsView ...'.tr,
                  readOnly: true,
                  controller: controller.searchPlace,
                  colorBorder: Colors.black,
                  colorHint: colorBlackHint,
                  colorIcon: colorBlackHint,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 1.5.h),
                  decoration: const BoxDecoration(
                      color: colorWhite,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(10))),
                  child: ListView(
                    children: [
                      //ads
                      Padding(
                        padding:
                            EdgeInsetsDirectional.only(start: 2.w, top: 1.h),
                        child: Text(
                          "Ads".tr,
                          style: const TextStyle(
                              color: dark,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),

                      _staggeredGridViewMethod(),

                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 2.w, top: 1, end: 4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "CategoriesMain".tr,
                              style: const TextStyle(
                                  color: dark,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            InkWell(
                              onTap: controller.goToCategoryView,
                              child: Text(
                                "Show all".tr,
                                style: TextStyle(
                                    color: oooooo,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      _categoryWidget(),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 2.w,
                        ),
                        child: Text(
                          "The places of top rating".tr,
                          style: const TextStyle(
                              color: dark,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      listViewMethod(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listViewMethod(BuildContext context) {
    return GetBuilder<HomeDetaileController>(
        id: "listViewPlaceRating",
        builder: (context) {
          switch (controller.ratingState) {
            case PromoWidgetState.error:
              return CustomButtonError(
                text:"Try again".tr,
              );
            case PromoWidgetState.loading:
              return const CircularWidget(
                color: colorBlack,
              );
            case PromoWidgetState.done:
              return Container(
                padding: const EdgeInsets.all(8.0),
                // color: Colors.red,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CardPlace(
                      onTap: () {
                        controller.goToPlaceDetailsFromNearest(index: index);
                      },
                      placeImage: controller.listPlacesRating![index].image,
                      placeName: controller.listPlacesRating![index].placeName,
                    );
                  },
                  itemCount: controller.listPlacesRating!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      height: 2.h,
                    );
                  },
                ),
              );
          }
        });
  }

  Widget _staggeredGridViewMethod() {
    return GetBuilder<HomeDetaileController>(
        id: "staggeredGridViewMethod",
        builder: (_) {
          switch (controller.promoWidgetState) {
            case PromoWidgetState.error:
              return CustomButtonError(text: "Try again".tr);
            case PromoWidgetState.loading:
              return const CircularWidget(
                color: colorBlack,
              );
            case PromoWidgetState.done:
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 150,
                  child: StaggeredGridView.countBuilder(
                    reverse: true,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 3,
                    scrollDirection: Axis.horizontal,
                    controller: controller.scrollController,
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 1,
                    itemCount: controller.allPromo!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: InkWell(
                          onTap: () {
                            controller.goToPlaceDetailsViewFromPromo(
                                index: index);
                          },
                          child: Image(
                            image:
                                NetworkImage(controller.allPromo![index].url),
                            fit: BoxFit.fill,
                            width: 30,
                            height: 40,
                          ),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        const StaggeredTile.count(2, 1.5),
                  ),
                ),
              );
          }
        });
  }

  Widget _categoryWidget() {
    return GetBuilder<HomeDetaileController>(
        id: "categoryWidget",
        builder: (_) {
          switch (controller.categoryWidgetState) {
            case CategoryWidgetState.error:
              return CustomButtonError(
                text:"Try again".tr,
              );
            case CategoryWidgetState.loading:
              return const CircularWidget(
                color: colorBlack,
              );
            case CategoryWidgetState.done:
              return SizedBox(
                height: 9.h,
                child: ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (() {
                        controller.changecategoryIndex(index);
                      }),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                              //  color: controller.categoryIndex == index
                              //               ? Colors.blue
                              //               : Colors.grey
                            ),

                            height: 45,
                            width: 45,
                            child: SvgPicture.network(
                              controller.categoriesList[index].svg,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              color: Colors.black87,
                            ),
                            // child: CachedNetworkSVGImage(
                            //   url: 'https://upload.wikimedia.org/wikipedia/commons/0/02/SVG_logo.svg',
                            //   // imageUrl:
                            //   //     'https://upload.wikimedia.org/wikipedia/commons/0/02/SVG_logo.svg',
                            //   placeholder:
                            //       const CircularProgressIndicator(
                            //           color: Colors.green),
                            //   errorWidget: const Icon(
                            //       Icons.error,
                            //       color: Colors.red),
                            //   width: 250.0,
                            //   height: 250.0,
                            //   fadeDuration: const Duration(
                            //       milliseconds: 500),
                            // ),
                          ),
                          // Container(
                          //   margin: const EdgeInsets.symmetric(
                          //       horizontal: 1, vertical: 1),
                          //   padding: const EdgeInsets.symmetric(
                          //       vertical: 5, horizontal: 10),
                          //   decoration: BoxDecoration(
                          //       boxShadow: const [
                          //         BoxShadow(
                          //             blurRadius: 1,
                          //             color: Colors.grey,
                          //             offset: Offset(1, 3))
                          //       ],
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(15),
                          //       border: Border.all(
                          //           color: controller.categoryIndex == index
                          //               ? Colors.blue
                          //               : Colors.grey)),
                          //   alignment: Alignment.center,
                          //   child: Text(
                          //     controller.categoriesList[index].name,
                          //     style: const TextStyle(fontSize: 16),
                          //   ),
                          // ),
                        ],
                      ),
                    );
                  },
                  itemCount: controller.categoriesList.length,
                  // itemCount: controller.categories!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 10,
                    );
                  },
                ),
              );
          }
        });
  }
}
