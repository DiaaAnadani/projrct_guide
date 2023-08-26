import 'package:get/get.dart';

import 'favorite_tabbar_controller.dart';

class FavoriteTabBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavoriteTabBarController());
  }
}
