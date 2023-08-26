import 'package:dio/dio.dart';
import 'package:first/app/core/repository/authentication_repository.dart';
import 'package:first/app/core/services/local_storage/get_storage_local_db.dart';
import 'package:first/app/modules/home/categories/category_binding.dart';
import 'package:first/app/modules/home/favorites/favorite_tabbar/favorite_tabbar_binding.dart';
import 'package:first/app/modules/home/home_detiles/home_detailes_binding.dart';
import 'package:first/app/modules/home/main_home/home_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/repository/home_repository/home_repository.dart';
import '../../../core/services/storage_service.dart';
import '../profile/profile_binding.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    // Get.put(HomeRepository(),permanent: true);
    // Get.put(Dio());
    // Get.put(GetStorageLocalDb());
    //  Get.put(StoragesService());
    // Get.put(AuthenticationRepository(
    //   dio: Get.find<Dio>(),
    //   getStorageLocalDb: Get.find<GetStorageLocalDb>(),
    // ),permanent: true);
    HomeDetailesBinding().dependencies();
    // CategoryBinding().dependencies();
    // ProfileBinding().dependencies();
    // FavoriteTabBarBinding().dependencies();
  }
}
