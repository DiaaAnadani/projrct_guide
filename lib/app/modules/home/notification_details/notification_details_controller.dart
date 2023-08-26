import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/services/local_storage/get_storage_local_db.dart';

class NotificationDetailsController extends GetxController {
  GetStorageLocalDb getStorageLocal = GetStorageLocalDb();
  String selectLanguage = 'ar';
  var appLocal = 'ar';

  void changeSelectLang(String value) {
    selectLanguage = value;
    update(["changeSelectLang"]);
  }

  @override
  void onInit() async {
    super.onInit();
    appLocal = await getStorageLocal.languageSelected;
    Get.updateLocale(Locale(appLocal));
    update();
  }

  void onChangeLanguage(String type) {
    if (appLocal == type) {
      return;
    } else if (type == 'ar') {
      appLocal = 'ar';
      getStorageLocal.saveLanguage(appLocal);
    } else {
      appLocal = 'en';
      getStorageLocal.saveLanguage(appLocal);
    }
    update();
  }
}
