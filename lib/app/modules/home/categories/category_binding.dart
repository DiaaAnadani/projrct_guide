import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:get/get.dart';

import 'category_controller.dart';

class CategoryBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(CategoryController(homeRepository: Get.find<HomeRepository>()));
    Get.lazyPut(
        () => CategoryController(homeRepository: Get.find<HomeRepository>()));
  }
}
