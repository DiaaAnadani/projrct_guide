import 'dart:developer';
import 'dart:ffi';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/modules/home/main_home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/model/region_model.dart';
import '../../../core/model/user_model.dart';
import '../../../core/repository/authentication_repository.dart';
import '../../../core/repository/home_repository/home_repository.dart';
import '../../../core/services/api_result.dart';
import '../../../core/services/error_handler.dart';
import '../../../core/services/storage_service.dart';

class EditeProfileController extends GetxController {
  EditeProfileController(
      {required this.homeRepository, required this.authRepository});

  HomeRepository homeRepository;
  AuthenticationRepository authRepository;
  TextEditingController fullnameteEdCont = TextEditingController();
  late User user;
  StoragesService storagesService = StoragesService();
  final TextEditingController textEditingSearchController =
      TextEditingController();
  bool validateRegion = false;
  bool validateStreet = false;
  TextEditingController passwordteEdCont = TextEditingController();
  List<bool> isCardEnabled = [];
  List<bool> isCardEnabledGrade = [false, false];
  List<Region> allRegion = <Region>[];
  List<Region> allStreet = <Region>[];
  Region? selectedAreaValue;
  Region? selectedStreetValue;
  bool isLoading = false;

  String? nameAreaUser;
  String? nameStreetUser;
  List<String> namesFilter = ["Save".tr, "Cancel".tr];
  @override
  void onInit() async {
    super.onInit();

    // getDeviceId();
    getUserInfo();
    allRegion = storagesService.getRegions()!;
    getNameArea(id: user.regionId);
    await getAllStreetForRegionSelect(id: user.regionId);
    getNameStreet(id: user.streetId);
    update(['changeSelectedAreaDropDown']);

    // getAllRegion();
  }

  void onTapGrade() {
    testAreaAndStreet();
    log("========================${user.streetId}");
    log("========================${user.regionId}");
    log("========================${user.fullName}");
    Get.offAndToNamed("/ProfileView");
    update(["GridViewEditeProfileController"]);
  }

  void gotoProfileView() {
    Get.offAllNamed("/ProfileView");
  }

  void getNameArea({required int id}) {
    for (int i = 0; i < allRegion.length; i++) {
      if (allRegion[i].id == id) {
        nameAreaUser = allRegion[i].name;
        update(["changeSelectedAreaDropDown"]);
      }
    }
  }

  void stateChange(int index) {
    isCardEnabledGrade[index] = true;
    update(["GridViewEditeProfileController"]);
  }

  String? getNameStreet({required int id}) {
    for (int i = 0; i < allStreet.length; i++) {
      if (allStreet[i].id == id) {
        nameStreetUser = allStreet[i].name;
        update(["changeSelectedStreetDropDown"]);
      }
      update(["changeSelectedStreetDropDown"]);
    }
  }

  Future<void> getUserInfo() async {
    try {
      user = storagesService.getUser()!;
      fullnameteEdCont = TextEditingController(text: user.fullName);
    } on ErrorHandler catch (e) {
      BotToast.showText(text: e.text);
    }
  }

  Future<void> updateUser(
      {required String fullName,
      required int regionId,
      required int streetId}) async {
    try {
      isLoading = true;
      update(["ElevatedButton"]);
      await homeRepository.updateUser(
        fullName: fullName,
        regionId: regionId,
        streetId: streetId,
      );
      user.fullName = fullName;
      user.regionId = regionId;
      user.streetId = streetId;
      await storagesService.setUser(user);
      isLoading = false;
      update(["ElevatedButton"]);

      BotToast.showText(text: "Updated Successfully");
    } catch (e) {
      log(e.toString());
      isLoading = false;
      update(["ElevatedButton"]);
    }
  }

  void onTapChoseGender(int index) {
    isCardEnabled.replaceRange(0, isCardEnabled.length,
        [for (int i = 0; i < isCardEnabled.length; i++) false]);
    isCardEnabled[index] = true;
    update(["onTapChoseGender"]);
  }

  void changeSelectedAreaDropDown(Region value) {
    selectedAreaValue = value;
    if (selectedAreaValue != null) {
      selectedStreetValue = null;
      // log(selectedAreaValue!.id.toString());
      getAllStreetForRegionSelect(id: selectedAreaValue!.id);
    }
    validateRegion = false;
    update(['changeSelectedAreaDropDown']);
    update(['changeSelectedStreetDropDown']);
    update(['showValidateRegion']);
  }

  Future<void> getAllRegion() async {
    log("message");
    ApiResult<List<Region>> regionResponse =
        await authRepository.getAllRegion();

    if (regionResponse.data != null) {
      allRegion = regionResponse.data!;
      getNameArea(id: user.regionId);

      getAllStreetForRegionSelect(id: user.regionId);

      getNameStreet(id: user.streetId);

      update(['changeSelectedAreaDropDown']);

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

  void testAreaAndStreet() {
    if (selectedAreaValue == null && selectedStreetValue == null) {
      updateUser(
        fullName: fullnameteEdCont.text,
        regionId: user.regionId,
        streetId: user.streetId,
      );
    } else if (selectedAreaValue != null && selectedStreetValue != null) {
      updateUser(
        fullName: fullnameteEdCont.text,
        regionId: selectedAreaValue!.id,
        streetId: selectedStreetValue!.id,
      );
    } else if (selectedAreaValue == null && selectedStreetValue != null) {
      updateUser(
        fullName: fullnameteEdCont.text,
        regionId: user.regionId,
        streetId: selectedStreetValue!.id,
      );
    } else if (selectedAreaValue != null && selectedStreetValue == null) {
      validateStreet = true;

      update(['showValidateStreet']);
    }
  }

  void changeSelectedStreetDropDown(Region value) {
    selectedStreetValue = value;
    validateStreet = false;
    log(selectedStreetValue.toString());
    update(['changeSelectedStreetDropDown']);
    update(['showValidateStreet']);
  }

  Future<void> getAllStreetForRegionSelect({required int id}) async {
    // log(" ${selectedAreaValue!.id}");
    ApiResult<List<Region>> regionResponse =
        await authRepository.getAllStreetForRegionSelect(id: id);

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
}
