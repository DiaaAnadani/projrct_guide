import 'package:first/app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/repository/home_repository/home_repository.dart';
import '../../../../core/widgets/custom_circular_progress.dart';
import 'favorite_place_controller.dart';

class FavoritePlaceView extends GetView<FavoritePlaceController> {
  const FavoritePlaceView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(FavoritePlaceController());
    Get.lazyPut(
      () => FavoritePlaceController(homeRepository: Get.find<HomeRepository>()),
    );
    return Scaffold(
      body: GetBuilder<FavoritePlaceController>(
          id: "FavoritePlaceController",
          builder: (context) {
            switch (controller.favoritePlaceWidgetState) {
              case FavoritePlaceWidgetState.error:
                return ElevatedButton(
                    onPressed: () {}, child:  Text("Try again".tr));
              case FavoritePlaceWidgetState.loading:
                return const Center(
                  child: CircularWidget(
                    color: colorBlack,
                  ),
                );
              case FavoritePlaceWidgetState.empty:
                return  Center(
                  child: Center(child: Text("No data".tr ,style: const TextStyle(
                                            color: Colors.amber, fontSize: 20),)),
                );
              case FavoritePlaceWidgetState.done:
                return ListView.separated(
                  padding: const EdgeInsetsDirectional.all(8),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.goToPlaceDetailsView(index: index);
                      },
                      child: Container(
                        width: 400,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25)),
                        child: Stack(
                          children: [
                            Container(
                              width: 400,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.network(
                                  controller.listAllSaved[index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: 400,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                gradient: const LinearGradient(
                                    colors: [Colors.black, Colors.transparent],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter),
                              ),
                            ),
                            Positioned(
                              top: 1,
                              left: 12,
                              child: IconButton(
                                  onPressed: () {
                                    controller.deleteSavedForPlace(
                                        placeId:
                                            controller.listAllSaved[index].id,
                                        index: index);
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    size: 35,
                                    color: Colors.red,
                                  )),
                            ),
                            Container(
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                              height: 250,
                              width: 400,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                     controller
                                            .listAllSaved[index].placeName,
                                        style: const TextStyle(
                                            color: Colors.amber, fontSize: 20),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      // Text(
                                      //   controller
                                      //       .listAllSaved[index].placeName,
                                      //   style: const TextStyle(
                                      //       color: Colors.amber, fontSize: 20),
                                      // ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 8,
                    );
                  },
                  itemCount: controller.listAllSaved.length,
                );
            }
          }),
    );
  }

// body: GetBuilder<FavoritePlaceController>(
// id: "FavoritePlaceController",
//
// builder: (context) {
// return controller.isLoading?ListView.separated(
// padding: const EdgeInsetsDirectional.all(8),
// itemBuilder: (context, index) {
// return InkWell(
// onTap: () {
// controller.goToPlaceDetailsView();
// },
// child: CardPlace(
// onTap: () {
// controller.changeFavouritePlace(index);
// },
// placeImage: controller.listAllSaved[index].image,
// placeName: controller.listAllSaved[index].placeName,
// ),
// );
// },
// separatorBuilder: (BuildContext context, int index) {
// return const SizedBox(
// height: 8,
// );
// },
// itemCount: controller.listAllSaved.length,
// ):const CircularWidget(color: colorBlackBorder);
// }
// ),
}
