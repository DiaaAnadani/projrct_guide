import 'package:first/app/modules/authentication/login/login_controller.dart';
import 'package:get/get.dart';

import '../../../core/repository/authentication_repository.dart';
import '../../../core/repository/home_repository/home_repository.dart';
import '../OtpVerification/verification_controller.dart';

class LoginBinding extends Bindings {

  @override
  void dependencies() {
    Get.put(VerificationController(homeRepository: Get.find<HomeRepository>()));
    Get.put(LoginController(authRepository: Get.find<AuthenticationRepository>(),));

  }
}
