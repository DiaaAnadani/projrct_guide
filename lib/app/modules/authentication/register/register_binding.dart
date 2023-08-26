import 'package:dio/dio.dart';
import 'package:first/app/core/repository/authentication_repository.dart';
import 'package:first/app/core/services/local_storage/get_storage_local_db.dart';
import 'package:first/app/modules/authentication/register/register_controller.dart';
import 'package:get/get.dart';

import '../../../core/repository/home_repository/home_repository.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
        Dio(
          BaseOptions(
            sendTimeout: const Duration(milliseconds: 800000),
            connectTimeout: const Duration(milliseconds: 800000),
            receiveTimeout: const Duration(milliseconds: 800000),
          ),
        ),
        permanent: true);
    Get.put(HomeRepository(),permanent: true);
    Get.put(GetStorageLocalDb());
    Get.put(
        AuthenticationRepository(
            dio: Get.find<Dio>(),
            getStorageLocalDb: Get.find<GetStorageLocalDb>()),
        permanent: true);
    Get.put(GetStorageLocalDb(), permanent: true);
    Get.put(
        RegisterController(
          authRepository: Get.find<AuthenticationRepository>(),
          getStorageLocalDb: Get.find<GetStorageLocalDb>(),
        ),
        permanent: true);
    // Get.lazyPut(() => RegisterController());
  }
}
