import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/model/category.dart';
import 'package:first/app/core/model/promo_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/model/place_model.dart';
import '../../../core/model/region_model.dart';
import '../../../core/repository/home_repository/home_repository.dart';
import '../../../core/services/api_result.dart';
import '../../../core/services/storage_service.dart';

class HomeDetaileController extends GetxController {
  HomeDetaileController({required this.homeRepository});

  HomeRepository homeRepository;
  TextEditingController searchCategoryController = TextEditingController();
  TextEditingController searchPlace = TextEditingController();

  List<CategoryModel> categoriesList = [];
  List<PlaceModel>? listPlacesRating;
  List<PromoModel> allPromo=[];
  CategoryWidgetState categoryWidgetState = CategoryWidgetState.done;
  PromoWidgetState promoWidgetState = PromoWidgetState.done;
  PromoWidgetState ratingState = PromoWidgetState.done;
  int categoryIndex = 0;
    StoragesService storagesService = StoragesService();

  ScrollController scrollController = ScrollController();
  void changecategoryIndex(categoryIndex) {
    if (this.categoryIndex != categoryIndex) {
      this.categoryIndex = categoryIndex;
      update(["categoryWidget"]);
    }
  }

  @override
  void onInit() async {
    getAllCategories();
    getAllPromo();
    getPlacesRating();
      // scrollController.animateTo(scrollController.position.maxScrollExtent,
      //   duration: Duration(milliseconds: 200), curve: Curves.easeOut);
  
    Future.delayed(const Duration(seconds: 1), () {
      scrollController.animateTo(scrollController.position.maxScrollExtent,
          duration: Duration(seconds: allPromo.length * 8), curve: Curves.linear);
    });

    super.onInit();
  }

  @override
  void dispose() {
    scrollController.keepScrollOffset;
    super.dispose();
  }

  Future<void> getAllCategories() async {
    categoryWidgetState = CategoryWidgetState.loading;
    update(["categoryWidget"]);
    ApiResult<List<CategoryModel>> regionResponse =
        await homeRepository.getAllCategories();

    if (regionResponse.data != null) {
      categoriesList = regionResponse.data!;
      categoryWidgetState = CategoryWidgetState.done;
      update(["categoryWidget"]);

      BotToast.showText(text: "Success categoryWidget");
    } else if (regionResponse.failure != null) {
      log(regionResponse.failure!.message ??
          regionResponse.failure!.code.toString());
      categoryWidgetState = CategoryWidgetState.error;
      update(["categoryWidget"]);
    } else {
      log('data is Empty');
    }
  }

  Future<void> getAllPromo() async {
    promoWidgetState = PromoWidgetState.loading;
    update(["staggeredGridViewMethod"]);
    ApiResult<List<PromoModel>> promoResponse =
        await homeRepository.getAllPromo();

    if (promoResponse.data != null) {
      allPromo = promoResponse.data!;
      promoWidgetState = PromoWidgetState.done;
      update(["staggeredGridViewMethod"]);
      // log(allPromo![0].url);
      // log(allPromo![0].placeId);

      BotToast.showText(text: "Success allPromo");
    } else if (promoResponse.failure != null) {
      log(promoResponse.failure!.message ??
          promoResponse.failure!.code.toString());
      promoWidgetState = PromoWidgetState.error;
      update(["staggeredGridViewMethod"]);
    } else {
      log('data is Empty');
    }
  }

  void goToNotificationView() {
    Get.toNamed("/NotificationView");
  }

  void goToCategoryItemView() {
    Get.toNamed("/CategoryItemView");
  }

  void goToPlaceDetailsViewFromPromo({required int index}) {
    Get.toNamed("/NoIdPlacesDetailsView",
        arguments: [allPromo![index].placeId, true]);
  }

  void goToPlaceDetailsFromNearest({required int index }) {
    Get.toNamed("/NoIdPlacesDetailsView", arguments: [listPlacesRating![index], false]);
  }

  void goToCategoryView() {
    Get.toNamed("/CategoryView");
  }

  void goToSearchPlaceView() {
    Get.toNamed(
      "/SearchPlaceView",
    );
  }

  Future<void> getPlacesRating() async {

    ratingState = PromoWidgetState.loading;
    update(["listViewPlaceRating"]);
    ApiResult<List<PlaceModel>> placeResponse =
    await homeRepository.getPlacesRating();
    if (placeResponse.data != null) {
      listPlacesRating = placeResponse.data!;

        // log(listPlacesRating![0].placeName);
        ratingState = PromoWidgetState.done;
        update(["listViewPlaceRating"]);

        BotToast.showText(text: "place successfully");

    } else if (placeResponse.failure != null) {
      log(placeResponse.failure!.message ??
          placeResponse.failure!.code.toString());
      ratingState = PromoWidgetState.error;
      update(["listViewPlaceRating"]);
    } else {
      log('data is Empty');
    }
  }


}

enum CategoryWidgetState { error, loading, done }

enum PromoWidgetState { error, loading, done }

