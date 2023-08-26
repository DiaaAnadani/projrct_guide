import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/model/place_model.dart';
import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:get/get.dart';

import '../../../../core/services/api_result.dart';

class FavoritePlaceController extends GetxController {
  HomeRepository homeRepository;
  FavoritePlaceController({required this.homeRepository});
  bool isLoading = false;
  FavoritePlaceWidgetState favoritePlaceWidgetState =
      FavoritePlaceWidgetState.done;
  List<PlaceModel> listAllSaved = [];
  bool isSavedPLace = false;
  @override
  void onInit() {
    getAllSaved();
    super.onInit();
  }

  void goToPlaceDetailsView({required int index}) {
    Get.toNamed("/NoIdPlacesDetailsView",
        arguments: [listAllSaved![index], false]);
  }

  void changeFavouritePlace(int index) {
    listAllSaved.remove(listAllSaved[index]);
    update(["FavoritePlaceController"]);
  }

  Future<void> getAllSaved() async {
    favoritePlaceWidgetState = FavoritePlaceWidgetState.loading;
    update(["FavoritePlaceController"]);
    ApiResult<List<PlaceModel>> allSavedResponse =
        await homeRepository.getAllSavedPlace();

    if (allSavedResponse.data != null) {
        listAllSaved = allSavedResponse.data!;
      
      if(listAllSaved.isNotEmpty)
      {
          favoritePlaceWidgetState = FavoritePlaceWidgetState.done;
      update(["FavoritePlaceController"]);

      }
      // BotToast.showText(text: "allSaved successfully");
     else {
     
      favoritePlaceWidgetState = FavoritePlaceWidgetState.empty;
      update(["FavoritePlaceController"]);
      BotToast.showText(text: "empty successfully");
    } }else {
      if (allSavedResponse.failure != null) {
      log(allSavedResponse.failure!.message ??
          allSavedResponse.failure!.code.toString());
    
      favoritePlaceWidgetState = FavoritePlaceWidgetState.error;
      update(["FavoritePlaceController"]);
    } else {
      log('data is Empty');
    }
    }
  }

  Future<void> deleteSavedForPlace(
      {required int placeId, required int index}) async {
    try {
      await homeRepository.deleteSavedForPlace(
        placeId: placeId,
      );
      changeFavouritePlace(index);

      BotToast.showText(text: "unSaved successfully");
    } catch (e) {
      log(e.toString());
      BotToast.showText(text: "Something went error");
    }
  }
}

enum FavoritePlaceWidgetState { empty, error, loading, done }
