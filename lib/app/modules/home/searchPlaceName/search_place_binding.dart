import 'package:first/app/modules/home/searchPlaceName/search_place_controller.dart';
import 'package:get/get.dart';

import '../../../core/repository/home_repository/home_repository.dart';

class SearchPlaceBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SearchPlaceController(homeRepository: Get.find<HomeRepository>()));
  }
}