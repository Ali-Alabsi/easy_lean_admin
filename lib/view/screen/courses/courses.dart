import 'package:easy_lean_admin/controller/course_controller.dart';
import 'package:easy_lean_admin/core/widget/searchAndNameInLayoutPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../widget/courses_widget/courses_widget.dart';

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
                            }
                            );
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


