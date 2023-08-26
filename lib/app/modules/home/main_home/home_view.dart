// ignore_for_file: must_be_immutable, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:developer';

import 'package:first/app/core/constants/colors.dart';
import 'package:first/app/modules/home/all_comments/all_comment.view.dart';
import 'package:first/app/modules/home/favorites/favorite_tabbar/favorite_tabbar_view.dart';
import 'package:first/app/modules/home/map/map_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../categories/category_view.dart';
import '../home_detiles/home_detailes_view.dart';
import '../profile/profile_view.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});
  List<Widget> screensList = [
    HomeDetailsView(),
    FavoriteTabBarView(),
    MapScreen(),
    CategoryView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
          child: GetBuilder<HomeController>(
              id: "bottomNavigationBar",
              builder: (_) {
                return GNav(
                    selectedIndex: controller.pagedIndex,
                    backgroundColor: Colors.white,
                    color: Colors.black,
                    activeColor: Colors.white,
                    gap: 6,
                    padding: const EdgeInsets.all(16),
                    // tabBackgroundColor: colorMainLight,
                    tabBackgroundColor: Theme.of(context).primaryColor,
                    curve: Curves.easeOutExpo,
                    tabs: [
                      GButton(
                        icon: Icons.home,
                        // text: 'Home'.tr,
                      ),
                      GButton(
                        icon: Icons.favorite,
                        // text: 'Favorites'.tr,
                      ),
                      GButton(
                        icon: Icons.place,
                        // iconSize: 30,
                        // text: 'Categories'.tr,
                      ),
                      GButton(
                        icon: Icons.category,
                        // text: 'Categories'.tr,
                      ),
                      GButton(
                        icon: Icons.person,
                        // text: 'Profile'.tr,
                      ),
                         GButton(
                        icon: Icons.comment,
                        // text: 'Profile'.tr,
                      ),
                      
                    ],
                    onTabChange: controller.chanageindex);
              }),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          HomeDetailsView(),
          FavoriteTabBarView(),
          MapScreen(),
          CategoryView(),
          ProfileView(),
          AllCommentView()
        ],
      ),
      //GetBuilder<HomeController>(id: "bottomNavigationBar",
      // builder: (context) {
      //   return IndexedStack(
      //     index: controller.selectedIndex,
      //     children: screensList,
      //   );
      // }
      // ),
    );
  }
}
