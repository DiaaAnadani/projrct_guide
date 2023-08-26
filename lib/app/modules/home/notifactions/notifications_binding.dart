import 'package:get/get.dart';

import 'notifications_controller.dart';

class NotificationBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(NotificationController());
  }

}