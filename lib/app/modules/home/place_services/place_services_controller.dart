import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../core/model/sevices_details_model.dart';

class PlaceServicesController extends GetxController {
  final PageController pageController = PageController();
  ServiceDetailsModel? serviceDetailsModel;
  List<Gallery> gallery=[];
  @override
  void onInit() {
    serviceDetailsModel=Get.arguments;
    gallery=serviceDetailsModel!.gallery ;
    log("arguments${serviceDetailsModel!.title}");
    log("arguments${serviceDetailsModel!.content}");


    super.onInit();
  }
  int serviceIndex = 0;


  void changeServiceIndex(int serviceIndex) {
    if (this.serviceIndex != serviceIndex) {
      this.serviceIndex = serviceIndex;
      update(["serviceWidget"]);
    }
    log(serviceIndex.toString());
  }


  void goToPlaceDetailsView() {
    Get.back(result: "/PlaceDetailsView");
  }


  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    pageController.jumpToPage(serviceIndex);
  }
}
