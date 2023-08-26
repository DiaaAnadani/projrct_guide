import 'package:get/get.dart';

import '../../../core/repository/home_repository/home_repository.dart';
import 'your_comments_controller.dart';

class AllYourCommentBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AllYourCommentController(homeRepository: Get.find<HomeRepository>(),));
  }

}