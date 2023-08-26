import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:first/app/modules/home/no_id_place_details/place_details_controller.dart';
import 'package:get/get.dart';

class NoIdPlaceDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NoIdPlaceDetailsController(homeRepository: Get.find<HomeRepository>(),));
  }
}
