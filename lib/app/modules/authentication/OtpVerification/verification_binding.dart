import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:first/app/modules/authentication/OtpVerification/verification_controller.dart';
import 'package:get/get.dart';

class VerificationBinding extends Bindings{
  @override
  void dependencies() {
     Get.put(HomeRepository());
    Get.put(VerificationController(homeRepository: Get.find<HomeRepository>()));

  }

}