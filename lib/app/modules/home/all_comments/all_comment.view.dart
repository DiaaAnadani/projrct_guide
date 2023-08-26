import 'package:first/app/core/widgets/custom_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/widgets/custom_button_error.dart';
import 'all_comment.controller.dart';

class AllCommentView extends GetView<AllCommentController> {
  const AllCommentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "All Comments".tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            // backgroundColor: colorMainLight,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<AllCommentController>(
                  id: "AllCommentController",
                  builder: (context) {
                    switch (controller.commentAllWidgetState) {
                      case CommentAllWidgetState.error:
                        return CustomButtonError(
                          text: "Try agine".tr,
                        );
                      case CommentAllWidgetState.empty:
                        return SizedBox();
                      case CommentAllWidgetState.loading:
                        return const CircularWidget(
                          color: colorBlack,
                        );
                      case CommentAllWidgetState.done:
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10, right: 10),
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemBuilder: ((context, index) {
                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          child: ClipOval(
                                              child: SvgPicture.asset(
                                            "assets/images_svg/person.svg",
                                            color: colorWhite,
                                          )),
                                        ),
                                        SizedBox(
                                          width: 6.w,
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              controller
                                                  .listPlaceComments[index]
                                                  .fullName,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  color: colorBlack,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 1.h,
                                            ),
                                            Text(
                                              controller
                                                  .listPlaceComments[index]
                                                  .content,
                                              style: const TextStyle(
                                                  fontSize: 15,
                                                  color: colorBlack,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 3,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Padding(
                                          padding: EdgeInsets.only(left: 7.w),
                                          child: Row(
                                            children: [
                                              Text(
                                                controller
                                                    .listPlaceComments[index]
                                                    .rate
                                                    .toString(),
                                                style: const TextStyle(
                                                    color: colorBlack,
                                                    fontSize: 16),
                                              ),
                                              SizedBox(
                                                width: 2.w,
                                              ),
                                              const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 20,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      color: Colors.amber,
                                    ),
                                  ],
                                );
                              }),
                              separatorBuilder: ((context, index) {
                                return const SizedBox(
                                  height: 2,
                                );
                              }),
                              // itemCount: controller.listPlaceComments.length
                              itemCount: controller.listPlaceComments.length,
                            ),
                          ),
                        );
                    }
                  }),
            ],
          )),
    );
  }
}
