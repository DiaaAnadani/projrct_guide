import 'package:first/app/modules/home/all_comments/all_comment.controller.dart';
import 'package:get/get.dart';

import '../../../core/repository/home_repository/home_repository.dart';

class AllCommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AllCommentController(homeRepository: Get.find<HomeRepository>(),));
  }
}
