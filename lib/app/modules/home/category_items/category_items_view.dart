import 'package:first/app/core/constants/colors.dart';
import 'package:first/app/core/constants/enum_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/widgets/custom_card_place.dart';
import '../../../core/widgets/custom_circular_progress.dart';
import '../../../core/widgets/new_custom_search.dart';
import 'category_items_controller.dart';

class CategoryItemView extends GetView<CategoryItemController> {
  const CategoryItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(children: [
        Container(
          color:  Theme.of(context).primaryColor,
          // color: colorMainLight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.category!.name,
                        style:
                            const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 22,
                      ),
                      InkWell(
                        onTap: controller.goToCategoryView,
                        child: const Icon(
                          CupertinoIcons.sort_up,
                          size: 40,
                          // Icons.sort_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                            height: 7.h,
                            width: double.infinity,
                            child: CustomSearchTextField(
                              onChanged: controller.onChangedSearchPlace,
                              backgroundColor: Colors.grey[200],
                            )),

                        // CustomTextField(
                        //   hintText:
                        //       "Search in".tr + "${controller.category!.name}",
                        //   controller: controller.searchCategoryItem,
                        //   colorBorder: Colors.white,
                        //   colorHint: Colors.grey[400],
                        //   colorIcon: Colors.white,
                        //   colorText: Colors.white,
                        //   cursorColor: colorMain,
                        //   textAlign: TextAlign.start,
                        //   onChanged: controller.onChangedSearchPlace,
                        // ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Get.bottomSheet(
                              elevation: 5,
                              backgroundColor: Colors.white,
                              isDismissible: false,
                              shape: const RoundedRectangleBorder(
                                  side: BorderSide(color: colorWhite, width: 1),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  )),
                              GetBuilder<CategoryItemController>(
                                id: "bottomSheet",
                                builder: (_) {
                                  return Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white),
                                      // height: MediaQuery.of(context).size.height,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              // mainAxisAlignment:
                                              //     MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (controller
                                                            .listSelectedSub
                                                            .isNotEmpty ||
                                                        controller
                                                            .listSelectedRegion
                                                            .isNotEmpty) {
                                                      controller
                                                          .getPlacesFromFilter();
                                                      Navigator.pop(context);
                                                    }
                                                  },
                                                  child: FaIcon(
                                                    FontAwesomeIcons
                                                        .checkCircle,
                                                    color: colorOrangeAccent,
                                                    size: 35,
                                                  ),
                                                ),
                                                Container(
                                                  // color: Colors.red,
                                                  height: 11.h,
                                                  width: 80.w,
                                                  child: GridView.builder(
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 15),
                                                      gridDelegate:
                                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              childAspectRatio:
                                                                  3,
                                                              crossAxisSpacing:
                                                                  10,
                                                              mainAxisSpacing:
                                                                  8),
                                                      itemCount: 2,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        // controller
                                                        //     .isCardEnabled
                                                        //     .add(
                                                        //     false);

                                                        return GestureDetector(
                                                          onTap: () {
                                                            controller
                                                                .isCardEnabled
                                                                .replaceRange(
                                                                    0,
                                                                    controller
                                                                        .isCardEnabled
                                                                        .length,
                                                                    [
                                                                  for (int i =
                                                                          0;
                                                                      i <
                                                                          controller
                                                                              .isCardEnabled
                                                                              .length;
                                                                      i++)
                                                                    false
                                                                ]);
                                                            controller
                                                                .stateChange(
                                                                    index);
                                                            // setState(() {});
                                                          },
                                                          child: Card(
                                                            color: controller
                                                                        .isCardEnabled[
                                                                    index]
                                                                ?  Theme.of(context).primaryColor
                                                                // colorMainLight
                                                                : backGroundGrey,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            child: Center(
                                                              child: Text(
                                                                controller
                                                                        .namesFilter[
                                                                    index],
                                                                style: TextStyle(
                                                                    color: controller.isCardEnabled[
                                                                            index]
                                                                        ? Colors
                                                                            .white
                                                                        : Colors
                                                                            .black,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),
                                              ],
                                            ),
                                          ),
                                          controller.isCardEnabled[0] == true
                                              ? Expanded(
                                                  child: Column(
                                                    children: [
                                                      const SizedBox(
                                                        height: 11,
                                                      ),
                                                      GetBuilder<
                                                              CategoryItemController>(
                                                          id: "selectedCategories",
                                                          builder: (context) {
                                                            switch (controller
                                                                .subCatState) {
                                                              case EnumState
                                                                    .error:
                                                                return Center(
                                                                  child: ElevatedButton(
                                                                      onPressed:
                                                                          () {},
                                                                      child: const Text(
                                                                          "Try again")),
                                                                );
                                                                break;

                                                              case EnumState
                                                                    .loading:
                                                                return const Center(
                                                                  child:
                                                                      CircularWidget(
                                                                    color:
                                                                        colorBlack,
                                                                  ),
                                                                );
                                                              case EnumState
                                                                    .done:
                                                                return Expanded(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Wrap(
                                                                      children: [
                                                                        ...controller
                                                                            .listSubCategory!
                                                                            .map(
                                                                          (element) =>
                                                                              GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              controller.selectSubCategory(element.id);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                                                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                                                              decoration: BoxDecoration(boxShadow: const [
                                                                                BoxShadow(blurRadius: 1, color: Colors.grey, offset: Offset(1, 3))
                                                                              ], color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: controller.checkSelectedSubCategory(element.id) ? Colors.blue : Colors.grey)),
                                                                              child: Text(element.name),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              case EnumState
                                                                    .empty:
                                                                return Center(
                                                                  child: Text(
                                                                    "Not found categories"
                                                                        .tr,
                                                                    style: const TextStyle(
                                                                        fontSize:
                                                                            20),
                                                                  ),
                                                                );
                                                                break;
                                                            }
                                                          }),
                                                      const SizedBox(
                                                        height: 11,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Expanded(
                                                  child: GetBuilder<
                                                      CategoryItemController>(
                                                    id: "searchRegionBottomSheet",
                                                    builder: (context) {
                                                      return Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        8),
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                              child: SizedBox(
                                                                  height: 7.h,
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      CustomSearchTextField(
                                                                    onChanged:
                                                                        controller
                                                                            .onChangedSearchRegion,
                                                                  )),
                                                              //     CustomTextField(
                                                              //   colorHint:
                                                              //       colorBlackHint,
                                                              //   colorText:
                                                              //       colorBlackHint,
                                                              //   hintText:
                                                              //       'Search Region ...'
                                                              //           .tr,
                                                              //   controller:
                                                              //       controller
                                                              //           .searchAreaController,
                                                              //   onChanged:
                                                              //       controller
                                                              //           .onChangedSearchRegion,
                                                              //   cursorColor:
                                                              //       colorMain,
                                                              //   textAlign:
                                                              //       TextAlign
                                                              //           .start,
                                                              // ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 11,
                                                          ),
                                                          controller
                                                                  .listRegionSearch!
                                                                  .isNotEmpty
                                                              ? GetBuilder<
                                                                      CategoryItemController>(
                                                                  id:
                                                                      "selectedRegion",
                                                                  builder:
                                                                      (context) {
                                                                    return Expanded(
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Wrap(
                                                                          children: [
                                                                            ...controller.listRegionSearch!.map(
                                                                              (element) => GestureDetector(
                                                                                onTap: () {
                                                                                  controller.selectRegion(element.id);
                                                                                },
                                                                                child: Container(
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                                                                                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                                                                                  decoration: BoxDecoration(boxShadow: const [
                                                                                    BoxShadow(blurRadius: 1, color: Colors.grey, offset: Offset(1, 3))
                                                                                  ], color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: controller.checkSelectedRegion(element.id) ? Colors.blue : Colors.grey)),
                                                                                  child: Text(element.name),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  })
                                                              : Expanded(
                                                                  child: Center(
                                                                    child: Text(
                                                                      "Not Found Areas"
                                                                          .tr,
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              20),
                                                                    ),
                                                                  ),
                                                                )

                                                          // SizedBox(
                                                          //   height:
                                                          //       11,
                                                          // ),
                                                        ],
                                                      );
                                                    },
                                                  ),
                                                ),
                                        ],
                                      ));
                                },
                              ));
                        },
                        child: Icon(
                          Icons.filter_alt,
                          size: 35,
                          color: colorOrangeAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
            child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<CategoryItemController>(
                  id: "ListViewAllPlace",
                  builder: (context) {
                    switch (controller.placeState) {
                      case EnumState.error:
                        return ElevatedButton(
                            onPressed: () {}, child: const Text("Try again"));
                        break;

                      case EnumState.loading:
                        return const Center(
                          child: CircularWidget(
                            color: colorBlack,
                          ),
                        );
                        break;
                      case EnumState.done:
                        return ListView.separated(
                          itemBuilder: (context, index) {
                            return CardPlace(
                              onTap: () {
                                controller.goToPlaceDetailsView(index: index);
                              },
                              placeImage:
                                  controller.listSearchPlaces![index].image,
                              placeName:
                                  controller.listSearchPlaces![index].placeName,
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 9,
                            );
                          },
                          itemCount: controller.listSearchPlaces!.length,
                        );
                      case EnumState.empty:
                        return Center(
                          child: Text(
                            "Not found places".tr,
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                    }
                  }),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     controller.getLocationForMap();
            //   },
            //   // child: const Text("data"),
            // ),
            // GetBuilder<CategoryItemController>(
            //     id: "isVisible",
            //     builder: (context) {
            //       return controller.isVisible
            //           ? Align(
            //               alignment: AlignmentDirectional.bottomCenter,
            //               child: Padding(
            //                 padding: const EdgeInsets.all(20),
            //                 child: ElevatedButton(
            //                   onPressed: () {
            //                     controller.getPlacesFromCat(
            //                         catId: controller.category!.id);
            //                   },
            //                   child: const Text("data"),
            //                 ),
            //               ))
            //           : const SizedBox();
            //     }),
          ],
        ))
      ])),
    );
  }
}
