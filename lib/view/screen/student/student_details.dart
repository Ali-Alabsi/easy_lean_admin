import 'package:easy_lean_admin/view/screen/teacher/teacher_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../widget/student_widget/student_details_widget.dart';


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
                          ListItemCourseOfStudentDetailsPage(
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



