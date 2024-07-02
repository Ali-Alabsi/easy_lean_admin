import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/course_controller.dart';
import '../../../controller/layout_controller.dart';
import '../../../core/shared/color.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../../core/widget/image_cache_error.dart';
import '../../screen/courses/courses_details.dart';

class CardItemCoursesInCoursesPage extends StatelessWidget {
  final snapshot;
  final int index;
  final CoursesController controller;

  const CardItemCoursesInCoursesPage({
    super.key,
    required this.maxWidth,
    required this.maxHeight,
    required this.snapshot,
    required this.index,
    required this.controller,
  });

  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                width: maxWidth / 10,
                height: maxHeight / 8,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: ImageNetworkCache(
                  url: snapshot.data.docs[index].data()['image'],
                  fit: BoxFit.cover,
                )),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      snapshot.data.docs[index].data()['name'],
                      style: TextStyles.font20mainColorBold,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    width: maxWidth / 4,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: maxWidth / 6,
                        child: Text(
                          snapshot.data.docs[index].data()['details'],
                          style: TextStyles.font18GreyW300,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GetBuilder<LayoutController>(
                          init: LayoutController(),
                          builder: (controllerLayout) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    CupertinoPageRoute(builder: (context) => CoursesDetails(courseId: 'ss',)));
                              },
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context,
                                      CupertinoPageRoute(builder: (context) => CoursesDetails(courseId: snapshot.data.docs[index].id,)));
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          'تفاصيل',
                                          style: TextStyles.font16mainColorBold,
                                        ),
                                        Container(
                                          height: 1,
                                          width: 50,
                                          color: ProjectColors.greyColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: maxWidth / 40,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.updateActive(
                                          context,
                                          snapshot.data.docs[index].id,
                                          snapshot.data.docs[index].data()['active']);
                                    },
                                    child: Container(
                                      width: 70,
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data.docs[index].data()['active']
                                                ? 'تقيد'
                                                : 'فك التقيد',
                                            style: TextStyles.font16greenColorBold,
                                          ),
                                          Container(
                                            height: 1,
                                            width: double.infinity,
                                            color: ProjectColors.greyColor,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: maxWidth / 40,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      controller.deleteCourse(
                                          context, snapshot.data.docs[index].id);
                                    },
                                    child: Column(
                                      children: [
                                        Text(
                                          'حذف',
                                          style: TextStyles.font16redColorBold,
                                        ),
                                        Container(
                                          height: 1,
                                          width: 35,
                                          color: ProjectColors.greyColor,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}