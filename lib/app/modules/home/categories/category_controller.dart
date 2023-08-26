import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/model/category.dart';
import '../../../core/services/api_result.dart';

class CategoryController extends GetxController {
  HomeRepository homeRepository;

  CategoryController({required this.homeRepository});

  TextEditingController searchCategoryController = TextEditingController();
  CategoryWidgetState categoryWidgetState = CategoryWidgetState.done;
  List<CategoryModel>? listCat;

  List<CategoryModel>? listSearchCat = [];

  @override
  void onInit() {
    super.onInit();
    getAllCategories();
  }

  Future<void> getAllCategories() async {
    categoryWidgetState = CategoryWidgetState.loading;
    update(["categoryWidget"]);
    ApiResult<List<CategoryModel>> regionResponse =
        await homeRepository.getAllCategories();

    if (regionResponse.data != null) {
      listCat = regionResponse.data!;

      if (listCat!.isNotEmpty) {
        listSearchCat = listCat;

        categoryWidgetState = CategoryWidgetState.done;
        update(["categoryWidget"]);
        BotToast.showText(text: "Success categoryWidget");
      } else {
        categoryWidgetState = CategoryWidgetState.empty;
        update(["categoryWidget"]);
      }
    } else if (regionResponse.failure != null) {
      log(regionResponse.failure!.message ??
          regionResponse.failure!.code.toString());
      categoryWidgetState = CategoryWidgetState.error;
      update(["categoryWidget"]);
    } else {
      log('data is Empty');
    }
  }

  void goToCategoryItemView({required int index}) {
    Get.toNamed("/CategoryItemView", arguments: [listSearchCat![index]]);
  }

  void onChangedSearchCat(String query) {
    if (listCat != null) {
      final suggestions = listCat!.where((product) {
        final title = product.name.toLowerCase();

        final input = query.toLowerCase();

        return title.contains(input);
      }).toList();
      listSearchCat = suggestions;

      if (listSearchCat!.isEmpty) {
        categoryWidgetState = CategoryWidgetState.empty;
      }
      if(listSearchCat!.isNotEmpty){
        categoryWidgetState = CategoryWidgetState.done;

      }
      update(["categoryWidget"]);
    }
  }
}

enum CategoryWidgetState { error, loading, done, empty }
