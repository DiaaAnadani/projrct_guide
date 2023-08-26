import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/model/user_comment.dart';
import 'package:first/app/core/services/api_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../../core/constants/colors.dart';
import '../../../core/model/place_comment_model.dart';
import '../../../core/repository/home_repository/home_repository.dart';

class AllYourCommentController extends GetxController {
  AllYourCommentController({required this.homeRepository});

  HomeRepository homeRepository;
  List<UserCommentModel> listPlaceComments = [];
  YourCommentsWidgetState yourCommentsWidgetState =
      YourCommentsWidgetState.done;
  bool isLoading = false;

  @override
  void onInit() {
    getAllUserComment();
    super.onInit();
  }

  showRatingDialog(int index) {
    Get.dialog(RatingDialog(
      starColor: Colors.amber,
      starSize: 30,
      submitButtonTextStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18),
      title: Text(
        'Add Comment For Place'.tr,
        style: const TextStyle(
          color: colorBlack,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
      commentHint: "Comment and Ratting".tr,
      submitButtonText: 'Submit'.tr,
      onCancelled: () => log("cancelled"),
      onSubmitted: (response) {
        if (response.comment == "") {
          BotToast.showText(text: "content required".tr);
        } else {
          updateComment(
              content: response.comment,
              rating: response.rating,
              commentId: listPlaceComments[index].id.toString());
        }
      },
    ));
  }

  Future<void> updateComment(
      {required String content,
      required double rating,
      required String commentId}) async {
    try {
      log("controller updatecomm*******");
      isLoading = false;
      await homeRepository.updateComment(
          commentId: commentId, content: content, rating: rating);
      // BotToast.showText(text: "Success Add Comment");
      isLoading = true;
      getAllUserComment();
      update(["AllCommentController"]);
    } catch (e) {
      log(e.toString());
      isLoading = false;
      update(["AllCommentController"]);
      // errorApiEmail = homeRepository.apiData["msg"].toString();
      // log("login email****-----*******$errorApiEmail");
    }
  }

  Future<void> deleteComment({required String commentId}) async {
    try {
      isLoading = false;
      // update(["AllCommentController"]);
      await homeRepository.deleteComment(
        commentId: commentId,
      );
      isLoading = true;
      getAllUserComment();
      update(["AllCommentController"]);
      BotToast.showText(text: "Success delete Comment");
    } catch (e) {
      log(e.toString());
      isLoading = false;
      update(["AllCommentController"]);
    }
  }

  Future<void> getAllUserComment() async {
    yourCommentsWidgetState = YourCommentsWidgetState.loading;
    update(["AllCommentController"]);
    ApiResult<List<UserCommentModel>> commentsAllResponse =
        await homeRepository.getAllUserComment();
    if (commentsAllResponse.data != null) {
      listPlaceComments = commentsAllResponse.data!;
      if (listPlaceComments.isNotEmpty) {
        yourCommentsWidgetState = YourCommentsWidgetState.done;
        update(["AllCommentController"]);
      } else {
         yourCommentsWidgetState = YourCommentsWidgetState.empty;
              update(["AllCommentController"]);
      }

    } else if (commentsAllResponse.failure != null) {
      log(commentsAllResponse.failure!.message ??
          commentsAllResponse.failure!.code.toString());
       yourCommentsWidgetState = YourCommentsWidgetState.error;
      update(["AllCommentController"]);
    } else {
      log('data is Empty');
    }
  }

  void goToPlaceDetailsView({required int index}) {
    Get.toNamed("/NoIdPlacesFromCatView",
        arguments: [listPlaceComments[index].placeId, true]);
  }
}

enum YourCommentsWidgetState { empty, error, loading, done }
