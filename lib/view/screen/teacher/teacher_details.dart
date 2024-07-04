import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../widget/teacher_widget/teacher_details_widget.dart';

class TeacherDetails extends StatelessWidget {
  final String teacherId;

  const TeacherDetails({Key? key, required this.teacherId}) : super(key: key);

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
                      Text('تفاصيل المعلمين',style: TextStyles.font24BlackW600,),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          ListItemCourseOfTeacherDetailsPage(
                            teacherId: teacherId,
                            maxWidth: maxWidth,
                            maxHeight: maxHeight,
                          ),
                          InfoOfTeacherInTeacherDetailsPage(
                            height: maxHeight,
                            width: maxWidth,
                            teacherId: teacherId,
                          )
                        ],
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: ListItemStudentInDetailsCourses(teacherId: teacherId,),
                            ),
                            SizedBox(width: 30,),
                            Expanded(
                              flex: 2,
                              child: ListItemReviewStudentOfTeacherDetailsPage(teacherId: teacherId,maxWidth: maxWidth,),)
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

