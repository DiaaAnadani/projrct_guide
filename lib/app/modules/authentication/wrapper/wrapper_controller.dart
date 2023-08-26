import 'package:get/get.dart';


import '../../../core/model/user_model.dart';
import '../../../core/services/storage_service.dart';


class WrapperController extends GetxController {
  WrapperController({required this.storagesService});

  final StoragesService storagesService;

  Future<void> getUserLastState() async {
    await Future.delayed(const Duration(seconds: 3));

    User? user =await storagesService.getUser();
    if (user == null) {
      await Get.offAndToNamed("/RegisterView");
    } else {
      await Get.offAndToNamed("/HomeView");
    }
  }

  @override
  void onInit() {
    getUserLastState();
    super.onInit();
  }
}
