import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:first/app/modules/home/newpassword/new_password_controller.dart';
import 'package:get/get.dart';

class NewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NewPasswordController(homeRepository: Get.find<HomeRepository>()));
    // Get.lazyPut(() => NewPasswordController());
  }
}
