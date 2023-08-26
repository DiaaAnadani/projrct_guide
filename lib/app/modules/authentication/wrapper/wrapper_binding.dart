import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:first/app/core/services/local_storage/get_storage_local_db.dart';
import 'package:first/app/modules/authentication/wrapper/wrapper_controller.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../core/repository/authentication_repository.dart';
import '../../../core/services/storage_service.dart';

class WrapperBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
        Dio(
          BaseOptions(
            sendTimeout: const Duration(milliseconds: 40000),
            connectTimeout: const Duration(milliseconds: 40000),
            receiveTimeout: const Duration(milliseconds: 40000),
          ),
        ),
        permanent: true);
    Get.put(HomeRepository(), permanent: true);
    Get.put(GetStorageLocalDb(), permanent: true);
    Get.put(StoragesService(), permanent: true);
    Get.put(
        AuthenticationRepository(
            dio: Get.find<Dio>(),
            getStorageLocalDb: Get.find<GetStorageLocalDb>()),
        permanent: true);
    Get.put(WrapperController(storagesService: Get.find<StoragesService>()),
        permanent: true);
  }
}
