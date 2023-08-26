import 'package:first/app/modules/home/searchPlaceName/search_place_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_button_error.dart';
import '../../../core/widgets/custom_circular_progress.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/new_custom_search.dart';

class SearchPlaceView extends GetView<SearchPlaceController> {
  const SearchPlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(
          //   height: 16,
          // ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    // width: 70,
                    child:
                    // CustomTextField(
                    //   colorText: Colors.black,
                    //   onChanged: (value) {
                    //         controller.searchPlace(value: value);
                    //   },
                    //   cursorColor: colorMain,
                    //   textAlign: TextAlign.start,
                    //   hintText: 'Search Place ...'.tr,
                    //   controller: controller.searchCategoryController,
                    // ),


                    SizedBox(
                        height: 7.h,width: double.infinity,
                        child: CustomSearchTextField(
                          onChanged: (value) {
                            controller.searchPlace(value: value);
                          },
                        )),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),

                  InkWell(
                      onTap: controller.goToHomeView,
                      child: Text(
                        "Cancel".tr,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: colorBlack),
                      )),
                ],
              ),
            ),
          ),
          GetBuilder<SearchPlaceController>(
              id: "SearchPlaceController",
              builder: (_) {
                switch (controller.searchPlaceWidgetState) {
                  case SearchPlaceWidgetState.empty:
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Text(
                          "not found".tr,
                          style: const TextStyle(color: colorBlackHint),
                        ),
                      ),
                    );
                  case SearchPlaceWidgetState.error:
                    return Center(
                      child: CustomButtonError(
                        text: "Try agine".tr,
                      ),
                    );
                  case SearchPlaceWidgetState.loading:
                    return const Center(
                      child: CircularWidget(
                        color: colorBlack,
                      ),
                    );
                  case SearchPlaceWidgetState.done:
                    return Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 10.h,
                                child: Card(
                                  child: ListTile(
                                    leading: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          controller
                                              .listSearchPlace[index].image,
                                          fit: BoxFit.cover,
                                          width: 60,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      controller
                                          .listSearchPlace[index].placeName,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: colorBlack,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                        separatorBuilder: ((context, index) {
                          return const SizedBox(
                            height: 3,
                          );
                        }),
                        // itemCount: controller.listPlaceComments.length
                        itemCount: controller.listSearchPlace.length,
                      ),
                    );
                  case SearchPlaceWidgetState.initScaffold:
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: const Text(
                         "",
                          style: TextStyle(color: colorBlackHint),
                        ),
                      ),
                    );
                }
              }),
        ],
      )),
    );
  }
}
