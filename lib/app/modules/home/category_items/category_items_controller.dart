import 'dart:developer';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/constants/enum_state.dart';
import 'package:first/app/core/repository/home_repository/home_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

import '../../../core/model/category.dart';
import '../../../core/model/place_model.dart';
import '../../../core/model/region_model.dart';
import '../../../core/model/sub_category_model.dart';
import '../../../core/repository/authentication_repository.dart';
import '../../../core/services/api_result.dart';
import '../../../core/services/location_service.dart';
import '../../../core/services/storage_service.dart';

class CategoryItemController extends GetxController {
  CategoryItemController(
      {required this.homeRepository, required this.authRepository});

  HomeRepository homeRepository;
  AuthenticationRepository authRepository;

  TextEditingController searchCategoryItem = TextEditingController();

  TextEditingController searchAreaController = TextEditingController();

  LocationData? locationData;
  double latOriginal = 0;
  double longOriginal = 0;
  List<PlaceModel>? places;

  List<PlaceModel> listSearchPlaces = [];

  List<SubCategoryModel>? listSubCategory = [];

  bool isLoading = false;
  bool isVisible = false;

  List<Region> allRegion = <Region>[];
  List<Region>? listRegionSearch ;

  List<PlaceModel>? listPlacesFromFilter;

  List<bool> isCardEnabled = [false, false];
  List<String> namesFilter = ["Categories".tr, "Areas".tr];

  EnumState placeState = EnumState.done;

  EnumState subCatState = EnumState.done;

  EnumState regionState = EnumState.done;

  List<int> listSelectedRegion = [];
  List<int> listSelectedSub = [];

  CategoryModel? category;
  StoragesService storagesService = StoragesService();


  @override
  void onInit() {


    category = Get.arguments[0];

    allRegion=storagesService.getRegions()!;
    listRegionSearch = allRegion;
    update(['searchRegionBottomSheet']);

    // getAllRegimon();

    getSubCategoryFromCat(id: category!.id);

    isCardEnabled[0] = true;
    update(["bottomSheet"]);

    // getPlacesFromFilter();
    getPlacesFromCat(catId: category!.id);

    super.onInit();
  }

  // bool checkSelectedCategory(int index) {
  //   return selectedCategories.contains(searchAreaList[index]);
  // }

  // void selectCategory(int index) {
  //   bool isSelcted = checkSelectedCategory(index);
  //   if (isSelcted) {
  //     selectedCategories.remove(searchAreaList[index]);
  //   } else {
  //     selectedCategories.add(searchAreaList[index]);
  //   }
  //
  //   update(["selctedCategories"]);
  // }
  bool checkSelectedSubCategory(int element) {
    return listSelectedSub.contains(element);
  }

  bool checkSelectedRegion(int element) {
    return listSelectedRegion.contains(element);
  }

  void selectSubCategory(int element) {
    bool isSelected = checkSelectedSubCategory(element);
    if (isSelected) {
      listSelectedSub.remove(element);
    } else {
      listSelectedSub.add(element);
    }

    update(["selectedCategories"]);
  }

  void selectRegion(int element) {
    bool isSelectedRegion = checkSelectedRegion(element);
    if (isSelectedRegion) {
      listSelectedRegion.remove(element);
    } else {
      listSelectedRegion.add(element);
    }

    update(["selectedRegion"]);
  }

  void stateChange(int index) {
    isCardEnabled[index] = true;
    update(["bottomSheet"]);
  }

  void goToPlaceDetailsView({required int index}) {
    Get.toNamed("/NoIdPlacesDetailsView",
        arguments: [listSearchPlaces![index], false]);
  }

  void goToCategoryView() {
    Get.toNamed("/CategoryView");
  }

  Future<void> getAllRegion() async {
    regionState = EnumState.loading;
    update(['searchRegionBottomSheet']);
    print("message+getAllRegion");
    ApiResult<List<Region>> regionResponse =
        await authRepository.getAllRegion();

    if (regionResponse.data != null) {
      allRegion = regionResponse.data!;

      if (allRegion.isNotEmpty) {
        regionState = EnumState.done;
        listRegionSearch = allRegion;
        update(['searchRegionBottomSheet']);
      } else {
        regionState = EnumState.empty;
        update(['searchRegionBottomSheet']);
      }

      // log("==========" + allRegion[0].id.toString());
      BotToast.showText(text: "Success Region");
    } else if (regionResponse.failure != null) {
      print(regionResponse.failure!.message ??
          regionResponse.failure!.code.toString());

      regionState = EnumState.error;
      update(['searchRegionBottomSheet']);
    } else {
      print('data is Empty');
    }

    // log(allRegion![0].id.toString());
  }

  void onChangedSearchRegion(String query) {
    if (allRegion != null) {
      final suggestions = allRegion.where((product) {
        final title = product.name.toLowerCase();

        final input = query.toLowerCase();

        return title.contains(input);
      }).toList();
      listRegionSearch = suggestions;

      update(["searchRegionBottomSheet"]);
    }
  }

  void onChangedSearchPlace(String query) {
    if (places != null) {
      final suggestions = places!.where((product) {
        final title = product.placeName.toLowerCase();

        final input = query.toLowerCase();

        return title.contains(input);
      }).toList();
      listSearchPlaces = suggestions;

      if (listSearchPlaces!.isEmpty) {
        placeState = EnumState.empty;
      }
      if (listSearchPlaces!.isNotEmpty) {
        placeState = EnumState.done;
      }

      update(["ListViewAllPlace"]);
    }
  }

  Future<void> getPlacesFromCat({required int catId}) async {
    // log("......getPlacesFromCatController............");
    isVisible = false;
    placeState = EnumState.loading;
    update(["ListViewAllPlace", "isVisible"]);

    ApiResult<List<PlaceModel>> placeResponse =
        await homeRepository.getPlacesFromCat(catId: catId);

    if (placeResponse.data != null) {
      places = placeResponse.data!;

      if (places!.isNotEmpty) {
        // log("..................");

        listSearchPlaces = places!;
        placeState = EnumState.done;

        update(["ListViewAllPlace"]);
        // log(places![0].placeName);
        BotToast.showText(text: "place successfully");
      } else {
        placeState = EnumState.empty;
        update(["ListViewAllPlace"]);
      }
    } else if (placeResponse.failure != null) {
      print(placeResponse.failure!.message ??
          placeResponse.failure!.code.toString());
      placeState = EnumState.error;
      update(["ListViewAllPlace"]);
    } else {
      print('data is Empty');
    }
  }

  Future<void> getSubCategoryFromCat({required int id}) async {
    // log("......getSubCategoryFromCat............");
    subCatState = EnumState.loading;
    update(["selectedCategories"]);

    ApiResult<List<SubCategoryModel>> subCatResponse =
        await homeRepository.getSubCategoryFromCat(id: id);

    if (subCatResponse.data != null) {
      listSubCategory = subCatResponse.data!;

      // log("..................");
      if (listSubCategory!.isNotEmpty) {
        subCatState = EnumState.done;
        update(["selectedCategories"]);
      } else {
        subCatState = EnumState.empty;
        update(["selectedCategories"]);
      }

      // log('===============================' + listSubCategory![0].name);

      BotToast.showText(text: "place successfully");
    } else if (subCatResponse.failure != null) {
      print(subCatResponse.failure!.message ??
          subCatResponse.failure!.code.toString());
      subCatState = EnumState.error;
      update(["selectedCategories"]);
    } else {
      print('data is Empty');
    }
  }

  Future<void> getPlacesFromFilter() async {
    // log("......getPlacesFromCatController............");
    // placeState = EnumState.loading;
    isVisible = false;

    placeState = EnumState.loading;

    update(["ListViewAllPlace", "isVisible"]);

    ApiResult<List<PlaceModel>> placeResponse =
        await homeRepository.getPlacesFromFilter(listSubCat: listSelectedSub, listRegion: listSelectedRegion);

    if (placeResponse.data != null) {
      listPlacesFromFilter = placeResponse.data!;

      listSearchPlaces = listPlacesFromFilter!;

      if (listPlacesFromFilter!.isNotEmpty) {
        isVisible = true;

        placeState = EnumState.done;
        update(["ListViewAllPlace", "isVisible"]);
      } else {
        isVisible = true;
        placeState = EnumState.empty;
        update(["ListViewAllPlace", "isVisible"]);
      }

      // log("=====================================listPlacesFromFilter" +
      //     listPlacesFromFilter![0].placeName);

      BotToast.showText(text: "place successfully");
    } else if (placeResponse.failure != null) {
      print(placeResponse.failure!.message ??
          placeResponse.failure!.code.toString());
      isVisible = true;

      placeState = EnumState.error;
      update(["ListViewAllPlace", "isVisible"]);
    } else {
      print('data is Empty');
    }
  }

  getLocationForMap() async {
    placeState = EnumState.loading;
    isVisible = false;
    update(["ListViewAllPlace","isVisible"]);


    locationData = await LocationService().getLocation();
    if (locationData != null) {

      latOriginal = locationData!.latitude!;
      longOriginal = locationData!.longitude!;
      listSearchPlaces = sortLocations(
        userLatitude: latOriginal,
        userLongitude: longOriginal,
        listPlace: listSearchPlaces,
      );
      update(["ListViewAllPlace"]);
    }

    print(
        "=============================+your location${locationData?.latitude} ${locationData?.longitude}");
  }

  List<PlaceModel> sortLocations(

      {required double userLatitude,
      required double userLongitude,
      required List<PlaceModel> listPlace}) {

    //
    // placeState = EnumState.loading;
    // isVisible = false;
    // update(["ListViewAllPlace","isVisible"]);

    // دالة الترتيب
    listPlace.sort((a, b) {
      double distanceToA = calculateDistance(
          userLatitude, userLongitude, a.latitud, a.longitude);
      double distanceToB = calculateDistance(
          userLatitude, userLongitude, b.latitud, b.longitude);
      return distanceToA.compareTo(distanceToB);
    });
    placeState = EnumState.done;
    isVisible=true;
    update(["ListViewAllPlace","isVisible"]);





    return listPlace;
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadius = 6371; // نصف قطر الأرض بالكيلومترات

    double dLat = degreesToRadians(lat2 - lat1);
    double dLon = degreesToRadians(lon2 - lon1);

    double a = pow(sin(dLat / 2), 2) +
        cos(degreesToRadians(lat1)) *
            cos(degreesToRadians(lat2)) *
            pow(sin(dLon / 2), 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = earthRadius * c;

    return distance;
  }

  double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }
}
