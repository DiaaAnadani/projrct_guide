import 'package:first/app/modules/home/place_services/place_services_controller.dart';
import 'package:get/get.dart';
class PlaceServicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PlaceServicesController());
  }
}
