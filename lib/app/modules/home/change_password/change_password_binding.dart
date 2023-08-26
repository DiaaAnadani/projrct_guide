import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:get/get.dart';

import 'change_password_controller.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeRepository());
    Get.lazyPut(() =>
        ChangePasswordController(homeRepository: Get.find<HomeRepository>()));
    // Get.put(ChangePasswordController(homeRepository: Get.find<HomeRepository>()));
  }
}
