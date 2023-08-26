import 'package:first/app/modules/home/favorites/favorite_service/favorite_service_controller.dart';
import 'package:get/get.dart';

import '../../../../core/repository/home_repository/home_repository.dart';

class FavoriteServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteServiceController(homeRepository: Get.find<HomeRepository>()));
  }
}
