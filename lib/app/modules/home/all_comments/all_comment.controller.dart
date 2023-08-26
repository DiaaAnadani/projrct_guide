import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:first/app/core/services/api_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../../../core/constants/colors.dart';
import '../../../core/model/place_comment_model.dart';
import '../../../core/repository/home_repository/home_repository.dart';

class AllCommentController extends GetxController {
  AllCommentController({required this.homeRepository});
  HomeRepository homeRepository;
  List<PlaceCommentsModel> listPlaceComments = [];
  CommentAllWidgetState commentAllWidgetState = CommentAllWidgetState.done;
  bool isLoading = false;
  double rating = 0.0;
  String comment = '';
  late String placeId;
  @override
  void onInit() {
    placeId = Get.arguments;
    getAllComments(placeId: placeId);
    super.onInit();
  }

  showRatingDialog() {
    Get.dialog(RatingDialog(
      starColor: Colors.amber,
      title: Text(
        'Add Comment For Place',
        style: TextStyle(color: colorblueGrey, fontSize: 14),
      ),
      commentHint: "Comment and Ratting ",
      // message: Text(
      //     'Cancel',style: TextStyle(color: Colors.red),),
      // image: Image.asset(
      //   "assets/images/verify.jpg",
      //   height: 20,
      // ),
      submitButtonText: 'Submit',
      onCancelled: () => log("cancelled"),
      onSubmitted: (response) {
        rating = response.rating;
        log(rating.toString());
        comment = response.comment;
        log(comment.toString());
        // addComment();
      },
    ));
  }

  Future<void> getAllComments({required String placeId}) async {
    commentAllWidgetState = CommentAllWidgetState.loading;
     update(["AllCommentController"]);
    ApiResult<List<PlaceCommentsModel>> commentsAllResponse =
        await homeRepository.getAllComments(placeId: placeId);
    if (commentsAllResponse.data != null) {
      listPlaceComments = commentsAllResponse.data!;
      if (listPlaceComments.isNotEmpty) {
        commentAllWidgetState = CommentAllWidgetState.done;
        update(["AllCommentController"]);
      } else {
        commentAllWidgetState = CommentAllWidgetState.empty;
         update(["AllCommentController"]);
      }

      // BotToast.showText(text: "placeDetails");
    } else if (commentsAllResponse.failure != null) {
      log(commentsAllResponse.failure!.message ??
          commentsAllResponse.failure!.code.toString());
      commentAllWidgetState = CommentAllWidgetState.error;
      update(["AllCommentController"]);
    } else {
      log('data is Empty');
    }
  }
}

enum CommentAllWidgetState { empty, error, loading, done }
