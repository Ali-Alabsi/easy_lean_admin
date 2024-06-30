import 'package:easy_lean_admin/controller/course_controller.dart';
import 'package:easy_lean_admin/core/shared/color.dart';
import 'package:easy_lean_admin/core/widget/image_cache_error.dart';
import 'package:easy_lean_admin/core/widget/searchAndNameInLayoutPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../core/shared/theming/text_style.dart';

class Courses extends StatelessWidget {
  const Courses({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          double maxHeight = constraints.maxHeight;
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
            )),
            padding:
                EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                SearchAndNameInTopLayoutPage(),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GetBuilder<CoursesController>(
                      init: CoursesController(),
                      builder: (controller) {
                        return FutureBuilder(
                            future: controller.dataCourses.get(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.docs.length > 0) {
                                    return ListView.separated(
                                        itemBuilder: (context, index) {
                                          return CardItemCoursesInCoursesPage(
                                            maxWidth: maxWidth,
                                            maxHeight: maxHeight,
                                            snapshot: snapshot,
                                            index: index,
                                            controller: controller,
                                          );
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(height: 10);
                                        },
                                        itemCount: snapshot.data!.docs.length);
                                  } else {
                                    return Text('لا يوجد كورسات في   ');
                                  }
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            });
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

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
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Column(
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
