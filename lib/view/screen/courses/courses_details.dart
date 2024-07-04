import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../widget/courses_widget/courses_details_widget.dart';

class CoursesDetails extends StatelessWidget {
  final String courseId;

  const CoursesDetails({Key? key, required this.courseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1300 && constraints.maxHeight > 600) {
          return Directionality(
              textDirection: TextDirection.rtl,
              child: LayoutBuilder(builder: (context, constraints) {
                double maxWidth = constraints.maxWidth;
                double maxHeight = constraints.maxHeight;
                return Container(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: maxHeight / 15, vertical: maxHeight / 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BasicInfoForCoursesInCourseDetailsPage(
                            courseId: courseId,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Container(
                                child: InfoOfTeacherInCoursesPage(
                              width: maxWidth,
                              height: maxHeight,
                            )),
                            flex: 2,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            ListItemLessonsOfCourseDetailsPage(
                              maxWidth: maxWidth,
                              courseId: courseId,
                            ),
                            SizedBox(
                              width: 60,
                            ),
                            ListItemReviewStudentPfCoursesDetailsPage(
                              maxWidth: maxWidth,
                              courseId: courseId,
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
    )
    );
  }
}
