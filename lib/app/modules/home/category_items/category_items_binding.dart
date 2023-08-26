import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:get/get.dart';

import '../../../core/repository/authentication_repository.dart';
import 'category_items_controller.dart';

class CategoryItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoryItemController(
        homeRepository: Get.find<HomeRepository>(),
        authRepository: Get.find<AuthenticationRepository>()));

  }
}
