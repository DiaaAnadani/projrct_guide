// ignore_for_file: prefer_const_constructors

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/constants/app_translate.dart';
import 'package:first/app/modules/authentication/login/login_binding.dart';
import 'package:first/app/modules/home/all_comments/all_comment.binding.dart';
import 'package:first/app/modules/home/all_comments/all_comment.view.dart';
import 'package:first/app/modules/home/change_password/change_password_binding.dart';
import 'package:first/app/modules/home/change_password/change_password_view.dart';
import 'package:first/app/modules/home/edite_prfile/edite_profile_binding.dart';
import 'package:first/app/modules/home/favorites/favorite_tabbar/favorite_tabbar_binding.dart';
import 'package:first/app/modules/home/newpassword/new_password_binding.dart';
import 'package:first/app/modules/home/newpassword/new_password_view.dart';
import 'package:first/app/modules/home/notifactions/notifications_binding.dart';
import 'package:first/app/modules/home/notifactions/notifications_view.dart';
import 'package:first/app/modules/home/notification_details/notification_details_binding.dart';
import 'package:first/app/modules/home/notification_details/notification_details_view.dart';
import 'package:first/app/modules/home/profile/profile_view.dart';
import 'package:first/app/modules/authentication/wrapper/wrapper_binding.dart';
import 'package:first/app/modules/authentication/wrapper/wrapper_view.dart';
import 'package:first/app/modules/home/searchPlaceName/search_place_binding.dart';
import 'package:first/app/modules/home/searchPlaceName/search_place_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'app/core/services/local_storage/get_storage_local_db.dart';
import 'app/core/constants/theme_color.dart';
import 'app/core/services/storage_service.dart';
import 'app/modules/authentication/OtpVerification/verification_binding.dart';
import 'app/modules/authentication/OtpVerification/verification_view.dart';
import 'app/modules/authentication/login/login_view.dart';
import 'app/modules/authentication/register/register_binding.dart';
import 'app/modules/authentication/register/register_view.dart';
import 'app/modules/home/categories/category_binding.dart';
import 'app/modules/home/categories/category_view.dart';
import 'app/modules/home/category_items/category_items_binding.dart';
import 'app/modules/home/category_items/category_items_view.dart';
import 'app/modules/home/edite_prfile/edite_profile_view.dart';
import 'app/modules/home/favorites/favorite_place/favorite_place_binding.dart';
import 'app/modules/home/favorites/favorite_place/favorite_place_view.dart';
import 'app/modules/home/favorites/favorite_service/favorite_service_binding.dart';
import 'app/modules/home/favorites/favorite_service/favorite_service_view.dart';
import 'app/modules/home/favorites/favorite_tabbar/favorite_tabbar_view.dart';
import 'app/modules/home/home_detiles/home_detailes_binding.dart';
import 'app/modules/home/home_detiles/home_detailes_view.dart';
import 'app/modules/home/main_home/home_binding.dart';
import 'app/modules/home/main_home/home_view.dart';
import 'app/modules/home/map/map_screen.dart';
import 'app/modules/home/no_id_place_details/place_details_binding.dart';
import 'app/modules/home/no_id_place_details/place_details_view.dart';
import 'app/modules/home/place_services/place_services_binding.dart';
import 'app/modules/home/place_services/place_services_view.dart';
import 'app/modules/home/profile/profile_binding.dart';
import 'app/modules/home/your_comments/your_comments_binding.dart';
import 'app/modules/home/your_comments/your_comments_view.dart';

void main() async {
   await StoragesService.openStorage(); 
  await GetStorage.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: BotToastInit(), //1. call BotToastInit
          navigatorObservers: [BotToastNavigatorObserver()],
          title: 'Sizer',
          theme: ThemeLightandNightMode().lightTheme,

          darkTheme: ThemeLightandNightMode().darkTheme,

          themeMode: GetStorageLocalDb().getThemeMode(),
          translations: AppTranslate(),
          //defailte language for app
          locale: Locale('ar'),
          //language uses in error
          fallbackLocale: Locale('ar'),
          // home: AllYourCommentView(),
          initialRoute: "/WrapperView",
          getPages: [
              GetPage(
                name: "/WrapperView",
                page: () => WrapperView(),
                binding: WrapperBinding()),
            GetPage(
                name: "/RegisterView",
                page: () => RegisterView(),
                binding: RegisterBinding()),
            GetPage(
                name: "/LoginView",
                page: () => LoginView(),
                binding: LoginBinding()),
            GetPage(
                name: "/HomeView",
                page: () => HomeView(),
                binding: HomeBinding()),
            GetPage(
                name: "/HomeDetailsView",
                page: () => HomeDetailsView(),
                binding: HomeDetailesBinding()),
            GetPage(
                name: "/PlaceServicesView",
                page: () => PlaceServicesView(),
                binding: PlaceServicesBinding()),
            GetPage(
                name: "/CategoryView",
                page: () => CategoryView(),
                binding: CategoryBinding()),
            GetPage(
                name: "/CategoryItemView",
                page: () => CategoryItemView(),
                binding: CategoryItemBinding()),
            GetPage(
                name: "/ProfileView",
                page: () => ProfileView(),
                binding: ProfileBinding()),
            GetPage(
                name: "/FavoriteTabBarView",
                page: () => FavoriteTabBarView(),
                binding: FavoriteTabBarBinding()),
            GetPage(
                name: "/FavoritePlaceView",
                page: () => FavoritePlaceView(),
                binding: FavoritePlaceBinding()),
            GetPage(
                name: "/FavoriteServiceView",
                page: () => FavoriteServiceView(),
                binding: FavoriteServiceBinding()),
            GetPage(
                name: "/AllYourCommentView",
                page: () => AllYourCommentView(),
                binding: AllYourCommentBinding()),
            GetPage(
                name: "/EditeProfileView",
                page: () => EditeProfileView(),
                binding: EditeProfileBinding()),
            GetPage(
                name: "/NotificationView",
                page: () => NotificationView(),
                binding: NotificationBinding()),
            GetPage(
                name: "/NotificationDetailsView",
                page: () => NotificationDetailsView(),
                binding: NotificationDetailsBinding()),
            GetPage(
                name: "/AllCommentView",
                page: (() => AllCommentView()),
                binding: AllCommentBinding()),
            GetPage(
                name: "/WrapperView",
                page: (() => WrapperView()),
                binding: WrapperBinding()),
            GetPage(
                name: "/NoIdPlacesDetailsView",
                page: (() => NoIdPlacesDetailsView()),
                binding: NoIdPlaceDetailsBinding()),
            GetPage(
                name: "/SearchPlaceView",
                page: (() => SearchPlaceView()),
                binding: SearchPlaceBinding()), 
                GetPage(
                name: "/ChangePasswordView",
                page: (() => ChangePasswordView()),
                binding: ChangePasswordBinding()),
                 GetPage(
                name: "/VerificationView",
                page: (() => VerificationView()),
                binding: VerificationBinding()),
                 GetPage(
                name: "/NewPasswordView",
                page: (() => NewPasswordView()),
                binding: NewPasswordBinding()),
          ],
        );
      },
    );
  }
}
