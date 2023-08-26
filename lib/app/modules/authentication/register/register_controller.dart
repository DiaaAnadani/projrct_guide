import 'dart:async';
import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:first/app/core/model/user_model.dart';
import 'package:first/app/core/repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

import '../../../core/model/region_model.dart';
import '../../../core/services/api_result.dart';
import '../../../core/services/local_storage/get_storage_local_db.dart';
import '../../../core/services/storage_service.dart';

class RegisterController extends GetxController {
  RegisterController(
      {required this.authRepository, required this.getStorageLocalDb});

  AuthenticationRepository authRepository;
  final TextEditingController controllerUserName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerConfirmPassword =
  TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController textEditingSearchController =
  TextEditingController();
  final GetStorageLocalDb getStorageLocalDb;
  StoragesService storagesService = StoragesService();


  late String token;
  String email = "";

  List<Region>? allRegion ;
  List<Region> allStreet = <Region>[];

  List<bool> isCardEnabled = [];
  List<Map<String, dynamic>> name = [
    {"gender": "male".tr, "iconGender": Icons.male},
    {"gender": "female".tr, "iconGender": Icons.female},
  ];

  List nameGender = ["male", "famle"];
  bool validateRegion = false;
  bool validateStreet = false;
  bool validateEmail = false;

  bool isLoading = false;

  String errorApiRegister = "";

  Region? selectedAreaValue;
  Region? selectedStreetValue;

  bool confirmPasswordVisible = true;
  bool passwordVisible = true;
  late String deviceId;

  String typeGender = "";

  @override
  void onInit() {
    super.onInit();
    getDeviceId();
    getAllRegion();
    // checkLocationServicesInDevice();
    // getCurrentLocation();
  }

  void showValidateStreet() {
    validateStreet = true;
    update(['showValidateStreet']);
    log("lllStreet".toString());
  }

  void showValidateRegion() {
    validateRegion = true;
    update(['showValidateRegion']);
    log("lllRegion".toString());
  }

  Future<void> register() async {
    try {
      isLoading = true;
      update(["ElevatedButton"]);
    User user= await authRepository.register(
        email: controllerEmail.text,
        password: controllerPassword.text,
        fullName: controllerUserName.text,
        deviceId: deviceId,
        gender: typeGender,
        userType: "user",
        regionId: selectedAreaValue!.id.toString(),
        streetId: selectedStreetValue!.id.toString(),

      );
      errorApiRegister = "Success Register".tr;
      isLoading = false;
      validateEmail=false;
      getStorageLocalDb.savePassword(controllerPassword.text);
      storagesService.setUser(user);
      update(["ElevatedButton","showValidateEmail"]);
      Get.offAllNamed("/HomeView");


    } catch (e) {
      log("======================"+e.toString());
      isLoading = false;
      validateEmail=true;
      if(authRepository.apiDataRegister !=null)
      {
        errorApiRegister = "The selected email is invalid".tr;

      }


      update(["ElevatedButton","showValidateEmail"]);
    }
  }

  Future<void> getAllRegion() async {
    log("message");
    ApiResult<List<Region>> regionResponse =
    await authRepository.getAllRegion();

    if (regionResponse.data != null) {
      allRegion = regionResponse.data!;
      update(['changeSelectedAreaDropDown']);
      storagesService.setRegion(allRegion);
      log("======================storagesService setRegion ");
      List<Region>? rr=storagesService.getRegions();
      log("======================storagesService getRegion "+rr![0].id.toString());


      // log(allRegion[0].id.toString());
      BotToast.showText(text: "Success Region");

    } else if (regionResponse.failure != null) {
      log(regionResponse.failure!.message ??
          regionResponse.failure!.code.toString());
    } else {
      log('data is Empty');
    }

    // log(allRegion![0].id.toString());
  }

  Future<void> getAllStreetForRegionSelect(Region selectedAreaValue) async {
    // log(" ${selectedAreaValue!.id}");
    ApiResult<List<Region>> regionResponse = await authRepository
        .getAllStreetForRegionSelect(id: selectedAreaValue.id);

    if (regionResponse.data != null) {
      allStreet = regionResponse.data!;
      update(['changeSelectedStreetDropDown']);
      if (allStreet.isEmpty) {
        BotToast.showText(text: "not found street");
      } else {
        BotToast.showText(text: "Success street");
      }

      // log(allStreet[0].id.toString());
    } else if (regionResponse.failure != null) {
      log(regionResponse.failure!.message ??
          regionResponse.failure!.code.toString());
    } else {
      log('data is Empty');
    }

    // log(allRegion![0].id.toString());
  }

  void confirmVisiblePassword() {
    confirmPasswordVisible = !confirmPasswordVisible;
    update(["confirmVisiblePassword"]);
  }

  void changeSelectedAreaDropDown(Region value) {

    selectedAreaValue = value;
    if (selectedAreaValue != null) {
      selectedStreetValue=null;

      getAllStreetForRegionSelect(selectedAreaValue!);
    }
    validateRegion = false;
    update(['changeSelectedAreaDropDown']);
    update(['showValidateRegion']);
  }

  void changeSelectedStreetDropDown(Region value) {
    selectedStreetValue = value;
    validateStreet = false;
    log(selectedStreetValue.toString());
    update(['changeSelectedStreetDropDown']);
    update(['showValidateStreet']);
  }

  void visiblePassword() {
    passwordVisible = !passwordVisible;
    update(["visiblePassword"]);
  }

  void gotoHome() {
    Get.offAndToNamed("/HomeView");
  }

  void onTapChoseGender(int index) {
    isCardEnabled.replaceRange(0, isCardEnabled.length,
        [for (int i = 0; i < isCardEnabled.length; i++) false]);
    {
      isCardEnabled[index] = true;
    }
    typeGender = nameGender[index];
    log(typeGender);
    update(["onTapChoseGender"]);
  }

  void gotoLogIn() {
    Get.offAndToNamed("/LoginView");
  }



  //get id device
  Future<String> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    if (androidDeviceInfo.id != null) {
      deviceId = androidDeviceInfo.id;
      log(name: "getDeviceId", deviceId);
    } else {
      deviceId = 'null';
    }
    return deviceId;
  }
}

// Future<void> checkLocationServicesInDevice() async {
//   Location location = Location();

//   serviceEnabled = await location.serviceEnabled();
//   if (serviceEnabled) {
//     locationData = await location.getLocation();

//     // log("latitude${locationData!.latitude} longitude${locationData!.longitude}");
//     log("gps en");
//     location.onLocationChanged.listen((LocationData currentLocation) {

//       log("latitude${currentLocation.latitude} longitude${currentLocation.longitude}");
// BotToast.showText(
//     text: currentLocation.altitude.toString() +
//         currentLocation.longitude.toString());
//     });
//   } else {
//     serviceEnabled = await location.requestService();
//     if (serviceEnabled) {
//       log("start per");
//     } else {
//       log("start pop ");
//       SystemNavigator.pop();
//     }
//   }
// }
//
// Future<void> checkLocationServicesInDevice() async {
//   Location location = Location();
//   location.changeSettings(distanceFilter: 50, interval: 500);
//   bool serviceEnabled;
//   PermissionStatus permissionGranted;
//   LocationData locationData;
//
//   serviceEnabled = await location.serviceEnabled();
//
//   if (serviceEnabled) {
//     permissionGranted = await location.hasPermission();
//
//     if (permissionGranted == PermissionStatus.granted) {
//       locationData = await location.getLocation();
//       BotToast.showText(
//           text: locationData.altitude.toString() +
//               locationData.longitude.toString());
//
//       log("your location${locationData.latitude} ${locationData.longitude}");
//
//       location.onLocationChanged.listen((LocationData currentLocation) {
//         log("yourlisten location${currentLocation.latitude} ${currentLocation.longitude}");
//       });
//     } else {
//       permissionGranted = await location.requestPermission();
//
//       if (permissionGranted == PermissionStatus.granted) {
//         print('user allowed');
//       } else {
//         SystemNavigator.pop();
//       }
//     }
//   } else {
//     serviceEnabled = await location.requestService();
//
//     if (serviceEnabled) {
//       permissionGranted = await location.hasPermission();
//
//       if (permissionGranted == PermissionStatus.granted) {
//         print('user allowed before');
//       } else {
//         permissionGranted = await location.requestPermission();
//
//         if (permissionGranted == PermissionStatus.granted) {
//           print('user allowed');
//         } else {
//           SystemNavigator.pop();
//         }
//       }
//     } else {
//       SystemNavigator.pop();
//     }
//   }
// }
