import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:first/app/modules/home/profile/profile_controller.dart';
import 'package:get/get.dart';

import 'home_detailes_controller.dart';

class HomeDetailesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeDetaileController(homeRepository:Get.find<HomeRepository>()));
  }
}


