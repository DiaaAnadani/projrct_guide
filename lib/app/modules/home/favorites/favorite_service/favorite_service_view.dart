import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:first/app/modules/home/favorites/favorite_service/favorite_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/custom_circular_progress.dart';

class FavoriteServiceView extends GetView<FavoriteServiceController> {
  const FavoriteServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.put(FavoriteServiceController());
    Get.lazyPut(
      () =>
          FavoriteServiceController(homeRepository: Get.find<HomeRepository>()),
    );
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<FavoriteServiceController>(
            id: "iconFavoriteService",
            builder: (context) {
              switch (controller.favoritePlaceWidgetState) {
                case FavoritePlaceWidgetState.error:
                  return ElevatedButton(
                      onPressed: () {}, child: const Text("Try again"));
                case FavoritePlaceWidgetState.loading:
                  return const Center(
                    child: CircularWidget(
                      color: colorBlack,
                    ),
                  );
                case FavoritePlaceWidgetState.empty:
                  return Center(
                    child: Text("No favorite".tr),
                  );
                case FavoritePlaceWidgetState.done:
                 return GridView.builder(
                  itemCount: controller.listService.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: controller.goToPlaceServicesView,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                controller.listService[index].gallery[0].url
                                    .toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                  colors: [Colors.black, Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter),
                            ),
                          ),
                          Positioned(
                            top: 1,
                            left: 4,
                            child: IconButton(
                                onPressed: () {
                                  controller.deleteSavedForService(
                                      serviceId:
                                          controller.listService[index].id,
                                      index: index);
                                },
                                icon: const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                                // controller.isFavoriteService[index]
                                //     ? const Icon(
                                //   Icons.favorite,
                                //   size: 35,
                                //   color: Colors.red,
                                // )
                                //     : const Icon(
                                //   Icons.favorite,
                                //   size: 35,
                                //   color: Colors.grey,
                                // ),
                                ),
                          )
                        ],
                      ),
                    );
                  });
              }
            },
          )),
    );
  }
}
