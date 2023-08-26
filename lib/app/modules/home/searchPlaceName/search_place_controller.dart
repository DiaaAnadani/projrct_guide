import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/model/place_model.dart';
import '../../../core/services/api_result.dart';

class SearchPlaceController extends GetxController {
  SearchPlaceController({required this.homeRepository});

  TextEditingController searchCategoryController = TextEditingController();
  HomeRepository homeRepository;
  List<PlaceModel> listSearchPlace = [];
  SearchPlaceWidgetState searchPlaceWidgetState =
      SearchPlaceWidgetState.initScaffold;

  @override
  void onInit() {
    // searchPlaceByName();
    super.onInit();
  }

  Future<void> searchPlace({required String value})async {


  if(value.isNum ||value.isEmpty ||  value.trim()==''||  isSymbol(value)){

      searchPlaceWidgetState = SearchPlaceWidgetState.initScaffold;
      update(["SearchPlaceController"]);

    }
    else {
    log("============$value===================");
    await searchPlaceByName(word: value.toString());

    update(["SearchPlaceController"]);
    }
  }


  bool isSymbol(String character) {
  // التحقق مما إذا كان الحرف رمز لوحة المفاتيح
  RegExp regex = RegExp(r'[!@#\$&*~]');
  return regex.hasMatch(character);
  }

  Future<void> searchPlaceByName({required String word}) async {
    searchPlaceWidgetState = SearchPlaceWidgetState.loading;
    update(["SearchPlaceController"]);
    ApiResult<List<PlaceModel>> allSavedResponse =
        await homeRepository.searchPlaceByName(word: word);

    if (allSavedResponse.data != null) {
      listSearchPlace = allSavedResponse.data!;
      // log("listSearchPlace${listSearchPlace[0].placeName}");
      searchPlaceWidgetState = SearchPlaceWidgetState.done;
      update(["SearchPlaceController"]);
      BotToast.showText(text: "SearchPlaceController successfully");

      if (listSearchPlace.isEmpty) {
        searchPlaceWidgetState = SearchPlaceWidgetState.empty;
        update(["SearchPlaceController"]);
      }
    } else if (allSavedResponse.failure != null) {
      log(allSavedResponse.failure!.message ??
          allSavedResponse.failure!.code.toString());
      searchPlaceWidgetState = SearchPlaceWidgetState.error;
      update(["SearchPlaceController"]);
    } else {
      log('data is Empty');
    }
  }

  void goToHomeView() {
    Get.back(result: "/HomeView");
  }
}

enum SearchPlaceWidgetState { empty, loading, done, error, initScaffold }
