import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_lean_admin/controller/student_controller.dart';
import 'package:easy_lean_admin/view/screen/student/student_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../controller/teacher_controller.dart';
import '../../../core/shared/color.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../../core/widget/image_cache_error.dart';
import '../../screen/courses/courses_details.dart';

class ListItemStudentInDetailsCourses extends StatelessWidget {
  final String teacherId;
  const ListItemStudentInDetailsCourses({
    super.key, required this.teacherId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherController>(
        init: TeacherController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.dataStudentCourses.where('teacher_id', isEqualTo: teacherId).get(),
              builder: (context ,snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length > 0) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40,),
                          Text('الطلاب الخاصة بهذا المعلم', style: TextStyles.font18mainColorBold,),
                          SizedBox(height: 15),
                          Expanded(
                            child: ListView.separated(
                                itemBuilder: (context , index){
                                  return CardItemStudentInDetailsCourses(snapshot: snapshot,index: index,);
                                }, separatorBuilder: (context , index){
                              return SizedBox(height: 20,);
                            }, itemCount: snapshot.data!.docs.length),
                          )

                        ],
                      );
                    } else {
                      return Text('لا يوجد طلاب   لهذا المعلم  ');
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
          );
        }
    );
  }
}

class CardItemStudentInDetailsCourses extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;
  const CardItemStudentInDetailsCourses({
    super.key,required this.snapshot, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: 15, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        color: ProjectColors.mainColor,
                        borderRadius:
                        BorderRadius.circular(10)),
                    child: ImageNetworkCache(url:  snapshot.data!.docs[index]['student_image'])),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      snapshot.data!.docs[index]['student_name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.font16mainColorBold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      snapshot.data!.docs[index]['student_email'],
                      style: TextStyles.font16GreyW400,
                    ),
                  ],
                ),
                SizedBox(width: 15,),
              ],
            ),
            InkWell(
              onTap: (){
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => StudentDetails(studentId: snapshot.data!.docs[index]['student_id'])));
              },
              child: CircleAvatar(
                  radius: 30,
                  child: Icon(
                    size: 30,
                    Icons.arrow_back_outlined,
                    color: ProjectColors.mainColor,
                    textDirection: TextDirection.ltr,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class ListItemCourseOfTeacherDetailsPage extends StatelessWidget {
  final String teacherId;

  const ListItemCourseOfTeacherDetailsPage({
    super.key,
    required this.maxWidth,
    required this.teacherId,
    required this.maxHeight,
  });

  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GetBuilder<TeacherController>(
            init: TeacherController(),
            builder: (controller) {
              return FutureBuilder(
                  future: controller.dataCourse
                      .where('teacher_id', isEqualTo: teacherId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.docs.length > 0) {
                          return Container(
                            height: maxHeight / 2.4,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          'الكورسات الخاص بالمعلم ',
                                          style: TextStyles.font18mainColorBold,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return CardItemCoursesOPfTeacherDetailsPage(
                                        maxWidth: maxWidth,
                                        index: index,
                                        snapshot: snapshot,
                                        controller: controller,
                                        maxHeight: maxHeight,
                                      );
                                    },
                                    itemCount: snapshot.data!.docs.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return SizedBox(
                                        width: 20,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Text('لا يوجد كورسات   لهذا المعلم  ');
                        }
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  }
              );
            }));
  }
}

class CardItemCoursesOPfTeacherDetailsPage extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;
  final TeacherController controller;

  const CardItemCoursesOPfTeacherDetailsPage({
    super.key,
    required this.maxWidth,
    required this.snapshot,
    required this.index,
    required this.controller,
    required this.maxHeight,
  });

  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: maxWidth / 4.5,
        height: maxHeight / 3,
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
                          url: snapshot.data!.docs[index]['image'],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Text(
                          snapshot.data!.docs[index]['name'],
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
                          color: ProjectColors.greenColor,
                          width: 1,
                        )),
                    child: Text('تفاصيل'),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return CoursesDetails(
                                courseId: snapshot.data!.docs[index].id);
                          }));
                    },
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}

class InfoOfTeacherInTeacherDetailsPage extends StatelessWidget {
  final double width;
  final double height;
  final String teacherId;

  const InfoOfTeacherInTeacherDetailsPage({
    super.key,
    required this.width,
    required this.height,
    required this.teacherId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TeacherController>(
        init: TeacherController(),
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
              });
        });
  }
}


class ListItemReviewStudentOfTeacherDetailsPage extends StatelessWidget {
  final String teacherId;

  const ListItemReviewStudentOfTeacherDetailsPage({
    super.key,
    required this.maxWidth,
    required this.teacherId,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GetBuilder<TeacherController>(builder: (controller) {
      return FutureBuilder(
          future: controller.dataReviewTeacher
              .where('teacher_id', isEqualTo: teacherId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length > 0) {
                  return Column(
                    children: [
                      SizedBox(height: 40,),
                      Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'تعليقات الطلاب',
                            style: TextStyles.font18mainColorBold,
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
                            return CardItemReviewTeacherPfCoursesDetailsPage(
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
                  return Text('لا يوجد تعليقات  على هذا المعلم   ');
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

class CardItemReviewTeacherPfCoursesDetailsPage extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;
  final TeacherController controller;

  const CardItemReviewTeacherPfCoursesDetailsPage({
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
                        minimumSize: Size(maxWidth / 3.4, 40),
                        maximumSize: Size(maxWidth / 3.4, 40),
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