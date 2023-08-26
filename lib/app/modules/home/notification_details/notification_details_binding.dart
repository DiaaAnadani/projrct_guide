import 'package:get/get.dart';

import 'notification_details_controller.dart';


class NotificationDetailsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(NotificationDetailsController());
  }

}