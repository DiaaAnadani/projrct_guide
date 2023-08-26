import 'package:first/app/modules/home/favorites/favorite_tabbar/favorite_tabbar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/colors.dart';
import '../favorite_place/favorite_place_view.dart';
import '../favorite_service/favorite_service_view.dart';

class FavoriteTabBarView extends GetView<FavoriteTabBarController> {
  const FavoriteTabBarView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(109.0),
          child: AppBar(
            // centerTitle: true,
            title: Text(
              "Favorite".tr,
              style: const TextStyle(
                  color: colorWhite, fontWeight: FontWeight.bold, fontSize: 29),
            ),
            elevation: 0,
            backgroundColor:  Theme.of(context).primaryColor,
            // backgroundColor: colorMainLight,
            bottom: TabBar(
                labelColor: colorWhite,
                unselectedLabelColor: colorWhite,
                labelStyle: const TextStyle(fontSize: 24),
                indicatorColor: colorYellowAccent,
                indicatorWeight: 4,
                tabs: [
                  Tab(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.store,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("Places".tr),
                        ],
                      ),
                    ),
                  ),
                  Tab(
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.photo_library_outlined,
                            size: 25,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text("Services".tr),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ),
        body: const TabBarView(children: [
          FavoritePlaceView(),
          FavoriteServiceView(),
        ]),
      ),
    );
  }
}
