import 'package:first/app/core/widgets/custom_circular_progress.dart';
import 'package:first/app/modules/home/your_comments/your_comments_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';

class AllYourCommentView extends GetView<AllYourCommentController> {
  const AllYourCommentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Your Comments".tr,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            // backgroundColor: colorMainLight,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<AllYourCommentController>(
                  id: "AllCommentController",
                  builder: (context) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 1, left: 1),
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: ((context, index) {
                            return Card(
                              elevation: 5,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        // color: Colors.red,
                                        padding:
                                            EdgeInsets.only(top: 15, right: 5),
                                        child: CircleAvatar(
                                          radius: 35,
                                          child: ClipOval(
                                              child: Image.network(
                                            controller
                                                .listPlaceComments[index].image,
                                            fit: BoxFit.fill,
                                            height: double.infinity,
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.listPlaceComments[index]
                                                .placeName,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: colorBlack,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Text(
                                            controller.listPlaceComments[index]
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
                                        padding: EdgeInsets.only(left: 6.w),
                                        child: Row(
                                          children: [
                                            Text(
                                              controller
                                                  .listPlaceComments[index].rate
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
                                  Padding(
                                    padding: EdgeInsets.only(left: 5.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                            onTap: () {
                                              controller
                                                  .showRatingDialog(index);
                                            },
                                            child: Text(
                                              "Update".tr,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: colorBlueAccent),
                                            )),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              controller.deleteComment(
                                                  commentId: controller
                                                      .listPlaceComments[index]
                                                      .id
                                                      .toString());
                                            },
                                            child: Text(
                                              "Delete".tr,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w700,
                                                  color: colorBlueAccent),
                                            )),
                                      ],
                                    ),
                                  ),
                                  // const Divider(
                                  //   color: Colors.grey,
                                  // ),
                                ],
                              ),
                            );
                          }),
                          separatorBuilder: ((context, index) {
                            return SizedBox(
                              height: 0.h,
                            );
                          }),
                          // itemCount: controller.listPlaceComments.length
                          itemCount: controller.listPlaceComments.length,
                        ),
                      ),
                    );
                  }),
            ],
          )),
    );
  }
}
