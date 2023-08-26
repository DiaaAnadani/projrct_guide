// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../../core/model/place_comment_model.dart';
import '../../../core/model/place_model.dart';
import '../../../core/model/sevices_details_model.dart';
import '../../../core/repository/home_repository/home_repository.dart';
import '../../../core/services/api_result.dart';
// import 'package:rating_dialog/rating_dialog.dart';

class NoIdPlaceDetailsController extends GetxController {
  HomeRepository homeRepository;

  NoIdPlaceDetailsController({required this.homeRepository});
  ServicesWidgetState servicesWidgetState = ServicesWidgetState.done;
  ServicesWidgetState linksWidgetState = ServicesWidgetState.done;

  List<ServiceDetailsModel> listService = [];
  List<bool>? listIsSavedService;
  List<PlaceCommentsModel> listPlaceComments = [];
  bool isLoadingComment = false;

  late int placeId;
  bool isLoading = false;

  bool isSavedPl = false;
  PlaceModel? placeDetails;
  double rating = 0.0;
  String comment = '';
  bool pressed = true;
  @override
  void onInit() {
    if (Get.arguments[1]) {
      placeId = Get.arguments[0];
      getPlaceDetails(placeId: placeId.toString());
      isSavedPlace(placeId: placeId);
      getAllComments(placeId: placeId.toString());
      getServiceDetails(placeId.toString());
    } else {
      isLoading = true;
      placeDetails = Get.arguments[0];
      isSavedPlace(placeId: placeDetails!.id);

      // isSavedPLace=placeDetails!.saved;
      getAllComments(placeId: placeDetails!.id.toString());
      getServiceDetails(placeDetails!.id.toString());
    }

    super.onInit();
  }

  showRatingDialog() {
    Get.dialog(
      RatingDialog(
        starColor: Colors.amber,
        starSize: 30,
        submitButtonTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
        title: Text(
          'Add Comment For Place'.tr,
          style: TextStyle(
            color: colorBlack,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        commentHint: "Comment and Ratting".tr,
        submitButtonText: 'Submit'.tr,
        onCancelled: () => log("cancelled"),
        onSubmitted: (response) {
          rating = response.rating;
          log(rating.toString());
          comment = response.comment;
          log(comment.toString());
          if (response.comment == "") {
            BotToast.showText(text: "content required");
          } else {
            addComment(placeId: placeDetails!.id.toString());
          }
        },
      ),
    );
  }

  void goToAllComment() {
    Get.toNamed("/AllCommentView", arguments: placeDetails!.id.toString());
  }

  Future<void> getServiceDetails(String placeId) async {
    servicesWidgetState = ServicesWidgetState.loading;
    update(["getServiceDetails"]);
    ApiResult<List<ServiceDetailsModel>> serviceDetailsResponse =
        await homeRepository.getServiceDetails(placeId);

    if (serviceDetailsResponse.data != null) {
      listService = serviceDetailsResponse.data!;
      if (listService.isNotEmpty) {
        servicesWidgetState = ServicesWidgetState.done;
        listIsSavedService = List.filled(listService.length, false);

        for (int i = 0; i < listService.length; i++) {
          listIsSavedService![i] = listService[i].saved!;
        }
        update(["getServiceDetails"]);
      } else {
        servicesWidgetState = ServicesWidgetState.empty;
        update(["getServiceDetails"]);
      }

      // BotToast.showText(text: "placeDetails");
    } else if (serviceDetailsResponse.failure != null) {
      log(serviceDetailsResponse.failure!.message ??
          serviceDetailsResponse.failure!.code.toString());
      servicesWidgetState = ServicesWidgetState.error;
      update(["getServiceDetails"]);
    } else {
      log('data is Empty');
    }
  }

  Future<void> addComment({required String placeId}) async {
    try {
      await homeRepository.addComment(
          placeId: placeId, content: comment, rating: rating);
      getAllComments(placeId: placeId);
      BotToast.showText(text: "Success Add Comment");

      // update(["SliverAppBar"]);
    } catch (e) {
      log(e.toString());
      // isLoadingComment=false;
      // update(["SliverAppBar"]);
      // errorApiEmail = homeRepository.apiData["msg"].toString();
      // log("login email****-----*******$errorApiEmail");
    }
  }

  Future<void> getAllComments({required String placeId}) async {
    isLoadingComment = false;
    update(["SliverAppBar"]);
    // categoryWidgetState = CategoryWidgetState.loading;
    ApiResult<List<PlaceCommentsModel>> commentsAllResponse =
        await homeRepository.getAllComments(placeId: placeId);

    if (commentsAllResponse.data != null) {
      listPlaceComments = commentsAllResponse.data!;
      isLoadingComment = true;
      update(["SliverAppBar"]);

      // BotToast.showText(text: "placeDetails");
    } else if (commentsAllResponse.failure != null) {
      log(commentsAllResponse.failure!.message ??
          commentsAllResponse.failure!.code.toString());
      isLoadingComment = false;
      update(["SliverAppBar"]);
      // categoryWidgetState = CategoryWidgetState.error;
      // update(["categoryWidget"]);
    } else {
      log('data is Empty');
    }
  }

  void goToPlaceServicesView({required int index}) {
    Get.toNamed("/PlaceServicesView", arguments: listService[index]);
  }

  Future<void> addSavedForPlace({required int placeId}) async {
    log("addSavedForPlace-----------------");
    try {
      // isLoadingSavedPlace = false;
      // update(["SliverAppBar"]);
      await homeRepository.addSavedForPlace(
        placeId: placeId,
      );
      isSavedPl = true;
      // isLoadingSavedPlace = true;
      update(["SliverAppBar"]);
      BotToast.showText(text: "Saved successfully");
    } catch (e) {
      log(e.toString());
      isSavedPl = false;
      // isLoadingSavedPlace = false;
      update(["SliverAppBar"]);
      BotToast.showText(text: "Something went error");
      // update(["AllCommentController"]);
      // errorApiEmail = homeRepository.apiData["msg"].toString();
      // log("login email****-----*******$errorApiEmail");
    }
  }

  Future<void> deleteSavedForPlace({required int placeId}) async {
    try {
      // isLoadingSavedPlace=false;
      // update(["SliverAppBar"]);
      await homeRepository.deleteSavedForPlace(
        placeId: placeId,
      );
      isSavedPl = false;
      // isLoadingSavedPlace=true;
      update(["SliverAppBar"]);
      BotToast.showText(text: "unSaved successfully");
    } catch (e) {
      log(e.toString());
      isSavedPl = true;
      // isLoadingSavedPlace=false;
      update(["SliverAppBar"]);
      BotToast.showText(text: "Something went error");
      // update(["AllCommentController"]);
      // errorApiEmail = homeRepository.apiData["msg"].toString();
      // log("login email****-----*******$errorApiEmail");
    }
  }

  Future<void> getPlaceDetails({required String placeId}) async {
    linksWidgetState = ServicesWidgetState.loading;
    update(["SliverAppBar"]);
    ApiResult<PlaceModel> placeDetailsResponse =
        await homeRepository.getPlaceDetails(placeId);

    if (placeDetailsResponse.data != null) {
      placeDetails = placeDetailsResponse.data!;
      if (placeDetails!.links== null) {
           linksWidgetState = ServicesWidgetState.empty;
      update(["SliverAppBar"]);
        
      } else {
             linksWidgetState = ServicesWidgetState.done;
      update(["SliverAppBar"]);
        
      }
   

      BotToast.showText(text: "placeDetails successfully");
    } else if (placeDetailsResponse.failure != null) {
      log(placeDetailsResponse.failure!.message ??
          placeDetailsResponse.failure!.code.toString());
      linksWidgetState = ServicesWidgetState.error;
      update(["SliverAppBar"]);
    } else {
      log('data is Empty');
    }
  }

  Future<void> addSavedForService(
      {required int serviceId, required int index}) async {
    log("addSavedForPlace-----------------");
    try {
      await homeRepository.addSavedForService(
        serviceId: serviceId,
      );
      listIsSavedService![index] = true;
      update(["getServiceDetails"]);

      BotToast.showText(text: "Saved successfully");
    } catch (e) {
      log(e.toString());
      // isLoadingSavedPlace = false;
      update(["getServiceDetails"]);
      BotToast.showText(text: "Something went error");
    }
  }

  Future<void> deleteSavedForService(
      {required int serviceId, required int index}) async {
    try {
      await homeRepository.deleteSavedForService(
        serviceId: serviceId,
      );
      listIsSavedService![index] = false;
      update(["getServiceDetails"]);
      BotToast.showText(text: "unSaved successfully");
    } catch (e) {
      log(e.toString());
      update(["getServiceDetails"]);
      BotToast.showText(text: "Something went error");
    }
  }

  Future<void> isSavedPlace({required int placeId}) async {
    try {
      isSavedPl = await homeRepository.isSavedPlace(placeId: placeId);
      log('' + isSavedPl.toString());

      BotToast.showText(text: "Success userIsSaved");

      update(["SliverAppBar"]);
    } catch (e) {
      log(e.toString());
      // isLoadingComment=false;
      // update(["SliverAppBar"]);
      // errorApiEmail = homeRepository.apiData["msg"].toString();
      // log("login email****-----*******$errorApiEmail");
    }
  }
}

enum ServicesWidgetState { error, loading, done, empty }
