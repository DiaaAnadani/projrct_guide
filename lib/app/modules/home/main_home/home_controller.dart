import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../categories/category_binding.dart';
import '../favorites/favorite_tabbar/favorite_tabbar_binding.dart';
import '../profile/profile_binding.dart';

class HomeController extends GetxController {
  PageController pageController = PageController();
  // int categoryIndex = 0;
  // void changecategoryIndex(categoryIndex) {
  //   if (this.categoryIndex != categoryIndex) {
  //     this.categoryIndex = categoryIndex;
  //     update(["categoryWidget"]);
  //   }
  // }

  int pagedIndex = 0;
  void chanageindex(int pagedIndex) {
   this. pagedIndex = pagedIndex;
      pageController.jumpToPage(pagedIndex,);
    // pageController.animateToPage(pagedIndex,
    //     duration: Duration(microseconds: 300), curve: Curves.bounceIn);
    update(["bottomNavigationBar"]);
    if (pagedIndex == 0) {
    } else if (pagedIndex == 1) {
      FavoriteTabBarBinding().dependencies();
    } else if (pagedIndex == 3) {
      CategoryBinding().dependencies();
    } else if (pagedIndex == 4) {
        ProfileBinding().dependencies();
    }
  }
}


  // void chanagepageitemindex(int pageitemindex) {
  //   this.pageitemindex = pageitemindex;
  //   pageController.jumpToPage(pageitemindex,);
  //   update(["MainHomeView"]);
  //   if (pageitemindex == 0) {
  //   } else if (pageitemindex == 1) {
  //       CartBindings().dependencies();
    
  //   } else if (pageitemindex == 2) {
  //     ProfileBinding().dependencies();
  //   }
  // }
