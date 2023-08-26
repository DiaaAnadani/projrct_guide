// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:cached_network_svg_image/cached_network_svg_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/repository/home_repository/home_repository.dart';
import '../../../core/widgets/custom_button_error.dart';
import '../../../core/widgets/custom_circular_progress.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/new_custom_search.dart';
import 'category_controller.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text("Categories".tr,
                  style: TextStyle(
                      fontSize: 30,
                      color:  Theme.of(context).primaryColor,
                      // color: colorMainLight,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 16,
              ),

              SizedBox(
                  height: 7.h,
                  width: double.infinity,
                  child: CustomSearchTextField(
                    onChanged: controller.onChangedSearchCat,
                  )),
              // CustomTextField(
              //   onChanged:controller.onChangedSearchCat,
              //
              //   cursorColor: colorMain,
              //   colorIcon: colorBlack,
              //   colorHint: colorBlackBorder,
              //   textAlign: TextAlign.start,
              //   hintText: 'Search Category ...'.tr,
              //   controller: controller.searchCategoryController,
              // ),
              GetBuilder<CategoryController>(
                  id: "categoryWidget",
                  builder: (context) {
                    switch (controller.categoryWidgetState) {
                      case CategoryWidgetState.error:
                        return CustomButtonError(
                          text: "Try agine".tr,
                        );
                      case CategoryWidgetState.loading:
                        return const CircularWidget(
                          color: colorBlack,
                        );
                      case CategoryWidgetState.done:
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: GridView.builder(
                                itemCount: controller.listSearchCat!.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        childAspectRatio: 1,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8),
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.white,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              5.0) //                 <--- border radius here
                                          ),
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 1,
                                            color: Colors.grey,
                                            offset: Offset(1, 3))
                                      ],

                                      // fillColor: Colors.red,
                                    ),
                                    child: InkWell(
                                      onTapCancel: () {
                                        log('tap cancel');
                                      },
                                      highlightColor: Colors.yellow,
                                      // splashColor: Colors.red,
                                      focusColor: Colors.green,
                                      hoverColor: Colors.blue,

                                      onTap: () {
                                        controller.goToCategoryItemView(
                                            index: index);
                                      },
                                      // splashColor: colorGreen,

                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            // color:Colors.red,
                                            height: 65,
                                            width: 65,
                                            child: SvgPicture.network(
                                              controller
                                                  .listSearchCat![index].svg,
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
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 6),
                                            child: Text(
                                               maxLines: 2, // Limits the text to two lines
                                             overflow: TextOverflow.ellipsis,
                                              controller
                                                  .listSearchCat![index].name,
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        );

                      case CategoryWidgetState.empty:
                        return Expanded(
                            child: Center(
                                child: Text(
                          "Not Found".tr,
                          style: TextStyle(fontSize: 20),
                        )));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
