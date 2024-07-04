import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_lean_admin/view/screen/teacher/teacher_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../controller/student_controller.dart';
import '../../../core/shared/color.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../../core/widget/image_cache_error.dart';
import '../courses/courses_details.dart';

class StudentDetails extends StatelessWidget {
  final String studentId;

  const StudentDetails({Key? key, required this.studentId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1300 && constraints.maxHeight > 600) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: LayoutBuilder(builder: (context, constraints) {
                double maxWidth = constraints.maxWidth;
                double maxHeight = constraints.maxHeight;
                return Container(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 15, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('تفاصيل الطلاب',style: TextStyles.font24BlackW600,),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          ListItemCourseOfTeacherDetailsPage(
                            studentId: studentId,
                            maxWidth: maxWidth,
                            maxHeight: maxHeight,
                          ),
                          InfoOfStudentInStudentDetailsPage(
                            height: maxHeight,
                            width: maxWidth,
                            studentId: studentId,
                          )
                        ],
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ListItemTeacherInDetailsStudentPage(studentId: studentId,),
                            ),
                            SizedBox(width: 30,),
                            Expanded(
                              flex: 2,
                              child: ListItemReviewStudentOfStudentDetailsPage(maxWidth: maxWidth,studentId: studentId,),
                      )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }));
        } else {
          return Center(child: Text('حجم الشاشة لا يسمح بعرض التطبيق'));
        }
      },
    ));
  }
}


class ListItemTeacherInDetailsStudentPage extends StatelessWidget {
  final String studentId;
  const ListItemTeacherInDetailsStudentPage({
    super.key, required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
        init: StudentController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.dataStudentCourses.where('student_id', isEqualTo: studentId).get(),
            builder: (context,snapshotTeacher) {
              if (snapshotTeacher.connectionState == ConnectionState.done) {
                if (snapshotTeacher.hasData) {
                 return Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     SizedBox(height: 40,),
                     Text( 'اسماء المعلمين الذي سبق الدراسة معهم', style: TextStyles.font18mainColorBold,),
                     SizedBox(height: 15),
                     Expanded(
                       child: ListView.separated(
                            itemBuilder: (context,i){
                              return FutureBuilder(
                                  future: controller.dataTeacher.doc(snapshotTeacher.data!.docs[i]['teacher_id']).get(),
                                  builder: (context ,snapshot) {
                                    if (snapshot.connectionState == ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        return CardItemTeacherInDetailsStudentPage(snapshot: snapshot,index: i,);
                                      } else {
                                        return Center(child: CircularProgressIndicator());
                                      }
                                    } else {
                                      return Center(child: CircularProgressIndicator());
                                    }
                                  }
                              );
                            }, separatorBuilder: (context , index){
                              return SizedBox(width: 10,);
                        }, itemCount: snapshotTeacher.data!.docs.length),
                     ),
                   ],
                 );
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

class CardItemTeacherInDetailsStudentPage extends StatelessWidget {
  final AsyncSnapshot<DocumentSnapshot<Object?>> snapshot;
  final int index;
  const CardItemTeacherInDetailsStudentPage({
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
                    child: ImageNetworkCache(url:  snapshot.data!['image'])),
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
                      snapshot.data!['name'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.font16mainColorBold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      snapshot.data!['email'],
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
                CupertinoPageRoute(builder: (context) {
                  return TeacherDetails(teacherId: snapshot.data!.id);
                }));
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
  final String studentId;

  const ListItemCourseOfTeacherDetailsPage({
    super.key,
    required this.maxWidth,
    required this.studentId,
    required this.maxHeight,
  });

  final double maxWidth;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GetBuilder<StudentController>(
            init: StudentController(),
            builder: (controller) {
              return FutureBuilder(
                  future: controller.dataStudentCourses
                      .where('student_id', isEqualTo: studentId)
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
                                          '  الكورسات الذي تم درستها ',
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
  final StudentController controller;

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
    return FutureBuilder(
      future: controller.dataCourse.doc(snapshot.data!.docs[index]['courses_id']).get(),
      builder: (context,snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
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
                                  url: snapshot.data!['image'],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  snapshot.data!['name'],
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
                            snapshot.data!['details'],
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
                                        courseId: snapshot.data!.id);
                                  }));
                            },
                          ),
                        ],
                      ),
                    ]),
              ),
            );
          } else {
            return Center(child: SizedBox());
          }
        } else {
          return Center(child: SizedBox());
        }
      }
    );
  }
}

class InfoOfStudentInStudentDetailsPage extends StatelessWidget {
  final double width;
  final double height;
  final String studentId;

  const InfoOfStudentInStudentDetailsPage({
    super.key,
    required this.width,
    required this.height,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StudentController>(
        init: StudentController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.dataStudents.doc(studentId).get(),
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
                                      vertical: 10,
                                    horizontal: 20
                                  ),
                                  child: Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            SizedBox(
                                              height: 60,
                                            ),
                                            Text(snapshot.data!['username']),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              snapshot.data!['email'],
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
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'رقم الهاتف',
                                                    style:
                                                    TextStyles.font14GreyW300,
                                                  ),
                                                  Text(
                                                    snapshot.data!['phone'],
                                                    maxLines: 1,
                                                    style: TextStyles
                                                        .font18BlackBold,
                                                  )
                                                ],
                                              ),
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


class ListItemReviewStudentOfStudentDetailsPage extends StatelessWidget {
  final String studentId;
  const ListItemReviewStudentOfStudentDetailsPage({
    super.key,
    required this.maxWidth,
    required this.studentId,
  });

  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    return Expanded(child: GetBuilder<StudentController>(builder: (controller) {
      return FutureBuilder(
          future: controller.dataReviewTeacher
              .where('student_id', isEqualTo: studentId)
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
                            '   تعليقات الطلاب على المعلمين',
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
                            return CardItemReviewStudentOfStudentDetailsPage(
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

class CardItemReviewStudentOfStudentDetailsPage extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;
  final int index;
  final StudentController controller;

  const CardItemReviewStudentOfStudentDetailsPage({
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
                        minimumSize: Size(maxWidth / 7, 40),
                        maximumSize: Size(maxWidth / 7, 40),
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
                  SizedBox(width: 20,),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(maxWidth / 7, 40),
                        maximumSize: Size(maxWidth / 7, 40),
                        side: BorderSide(
                          color: ProjectColors.greenColor,
                          width: 1,
                        )),
                    child: Text('عرض المعلم'),
                    onPressed: () {
                      Navigator.push(context,
                          CupertinoPageRoute(builder: (context) {
                            return TeacherDetails(teacherId: snapshot.data!.docs[index]['teacher_id']);
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