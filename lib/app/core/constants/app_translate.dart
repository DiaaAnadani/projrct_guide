import 'package:first/app/core/constants/ar.dart';
import 'package:first/app/core/constants/en.dart';
import 'package:get/get.dart';

class AppTranslate extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
       'en': en,
       'ar':ar,
      };
}
 