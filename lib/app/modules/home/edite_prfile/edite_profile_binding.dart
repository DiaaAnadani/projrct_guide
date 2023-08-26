import 'package:first/app/core/repository/authentication_repository.dart';
import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:get/get.dart';

import 'edite_profile_controller.dart';

class EditeProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(EditeProfileController(authRepository: Get.find<AuthenticationRepository>(),
        homeRepository: Get.find<HomeRepository>()));
  }
}
