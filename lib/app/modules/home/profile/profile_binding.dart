import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:first/app/modules/home/profile/profile_controller.dart';
import 'package:get/get.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // Get.put(ProfileController(homeRepository: Get.find<HomeRepository>()));
    Get.lazyPut(
        () => ProfileController(homeRepository: Get.find<HomeRepository>()));
  }
}
