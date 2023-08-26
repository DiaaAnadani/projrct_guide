import 'package:get/get.dart';

import '../../../../core/repository/home_repository/home_repository.dart';
import 'favorite_place_controller.dart';

class FavoritePlaceBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(FavoritePlaceController(homeRepository: Get.find<HomeRepository>(),));
  }

}