
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/course_controller.dart';
import '../../../core/shared/color.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../../core/widget/image_cache_error.dart';
import '../../screen/courses/video_course.dart';

class ListItemReviewStudentPfCoursesDetailsPage extends StatelessWidget {
  final String courseId;

  const ListItemReviewStudentPfCoursesDetailsPage({
    super.key,
    required this.maxWidth,
    required this.courseId,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GetBuilder<CoursesController>(builder: (controller) {
      return FutureBuilder(
          future: controller.dataReview
              .where('course_id', isEqualTo: courseId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length > 0) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'تعليقات الطلاب',
                            style: TextStyles.font20BlackBold,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              mainAxisExtent: 220),
                          itemBuilder: (context, index) {
                            return CardItemReviewStudentPfCoursesDetailsPage(
                              maxWidth: maxWidth,
                              index: index,
                              snapshot: snapshot,
                              controller: controller,
                            );
                          },
                          itemCount: snapshot.data!.docs.length,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Text('لا يوجد تعليقات  على هذا الكورس   ');
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          });
    }));
  }
}

class CardItemReviewStudentPfCoursesDetailsPage extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;
  final CoursesController controller;

  const CardItemReviewStudentPfCoursesDetailsPage({
    super.key,
    required this.maxWidth,
    required this.snapshot,
    required this.index,
    required this.controller,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),

        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 45,
                        width: 45,
                        decoration: BoxDecoration(
                          color: ProjectColors.mainColor,
                          borderRadius: BorderRadius.circular(23),
                        ),
                        child: ImageNetworkCache(
                          url: snapshot.data!.docs[index]['student_image'],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          snapshot.data!.docs[index]['student_name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.font16mainColorBold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data!.docs[index]['details'],
                    maxLines: 4,
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(maxWidth / 5, 40),
                        maximumSize: Size(maxWidth / 5, 40),
                        side: BorderSide(
                          color: Colors.red,
                          width: 1,
                        )),
                    child: Text('حذف'),
                    onPressed: () {
                      controller.deleteReview(
                          context, snapshot.data!.docs[index].id);
                    },
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}

class ListItemLessonsOfCourseDetailsPage extends StatelessWidget {
  final String courseId;

  const ListItemLessonsOfCourseDetailsPage({
    super.key,
    required this.maxWidth,
    required this.courseId,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<CoursesController>(
          id: 'lessons',
          init: CoursesController(),
          builder: (controller) {
            return FutureBuilder(
                future: controller.dataCourses
                    .doc(courseId)
                    .collection('video')
                    .orderBy('video_id')
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.length > 0) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'الدروس',
                                  style: TextStyles.font20BlackBold,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Expanded(
                              child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return CardItemLessonsOfCourseDetailsPage(
                                      maxWidth: maxWidth,
                                      snapshot: snapshot,
                                      index: index,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: 20,
                                    );
                                  },
                                  itemCount: snapshot.data!.docs.length),
                            ),
                          ],
                        );
                      } else {
                        return Text('لا يوجد كورسات في   ');
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                });
          }),
    );
  }
}

class CardItemLessonsOfCourseDetailsPage extends StatelessWidget {
  final snapshot;
  final int index;

  const CardItemLessonsOfCourseDetailsPage({
    super.key,
    required this.maxWidth,
    required this.snapshot,
    required this.index,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(
                snapshot.data!.docs[index]['video_id'],
                style: TextStyles.font18WhiteW500,
              ),
              backgroundColor: ProjectColors.mainColor,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  snapshot.data!.docs[index]['name'],
                  style: TextStyles.font16BlackBold,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 7,
                  width: maxWidth / 3,
                  decoration: BoxDecoration(
                      color: ProjectColors.mainColor,
                      borderRadius: BorderRadius.circular(4)),
                )
              ],
            ),
            SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoShow(
                          videoUrl: snapshot.data!.docs[index]['video_url'],
                          title: snapshot.data!.docs[index]['name'],
                        )));
              },
              child: Icon(
                Icons.play_circle,
                size: 40,
                color: ProjectColors.mainColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BasicInfoForCoursesInCourseDetailsPage extends StatelessWidget {
  final String courseId;

  const BasicInfoForCoursesInCourseDetailsPage({
    super.key,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: GetBuilder<CoursesController>(
          init: CoursesController(),
          builder: (controller) {
            return FutureBuilder(
                future: controller.dataCourses.doc(courseId).get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  snapshot.data!['name'],
                                  style: TextStyles.font20mainColorBold,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              snapshot.data!['details'],
                              maxLines: 3,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'السعر',
                                      style: TextStyles.font16mainColorBold,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      '${snapshot.data!['price']}\$',
                                      style: TextStyles.font14BlackBold,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'التقيم',
                                      style: TextStyles.font16mainColorBold,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      '${snapshot.data!['evaluation']}\$',
                                      style: TextStyles.font14BlackBold,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'عدد الساعات',
                                      style: TextStyles.font16mainColorBold,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      '500\$',
                                      style: TextStyles.font14BlackBold,
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'المرجع',
                                      style: TextStyles.font16mainColorBold,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                });
          }),
    );
  }
}

class InfoOfTeacherInCoursesPage extends StatelessWidget {
  final String teacherId;
  final double width;
  final double height;

  const InfoOfTeacherInCoursesPage({
    super.key,
    required this.width,
    required this.height, required this.teacherId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CoursesController>(
        init: CoursesController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.dataTeacher.doc(teacherId).get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsetsDirectional.only(top: 50),
                                height: height / 3,
                                width: width / 4.5,
                                decoration: BoxDecoration(
                                  color: ProjectColors.greyColor300,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Container(
                                  padding: EdgeInsetsDirectional.symmetric(
                                      vertical: 10),
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 60,
                                            ),
                                            Text(snapshot.data!['name']),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "المعلم / ${snapshot.data!['email']}",
                                              style: TextStyles.font14GreyW300,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  'عدد الكورسات',
                                                  style:
                                                  TextStyles.font14GreyW300,
                                                ),
                                                Text(
                                                  '1',
                                                  style: TextStyles
                                                      .font18BlackBold,
                                                )
                                              ],
                                            ),
                                            Container(
                                              width: 3,
                                              height: 70,
                                              color: ProjectColors.whiteColor,
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  'work',
                                                  style:
                                                  TextStyles.font14GreyW300,
                                                ),
                                                Text(
                                                  snapshot.data!['work'],
                                                  style: TextStyles
                                                      .font18BlackBold,
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      ]),
                                ),
                              ),
                              Positioned(
                                child: Container(
                                    height: 100,
                                    width: 100,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: BoxDecoration(
                                        color: ProjectColors.mainColor,
                                        borderRadius:
                                        BorderRadius.circular(50)),
                                    child: ImageNetworkCache(
                                      url: snapshot.data!['image'],
                                    )),
                                top: 0,
                                left: width / 13,
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }

              }
              );
        });
  }
}