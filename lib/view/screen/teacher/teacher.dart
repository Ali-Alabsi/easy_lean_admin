import 'package:easy_lean_admin/controller/teacher_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../core/widget/searchAndNameInLayoutPage.dart';
import '../../widget/teacher_widget/teacher_widget.dart';

class Teacher extends StatelessWidget {
  const Teacher({Key? key}) : super(key: key);

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
                  child: Column(
                    children: [
                      DefineTitleInTable(),
                      Expanded(
                        child: GetBuilder<TeacherController>(
                            init: TeacherController(),
                            builder: (controller) {
                              return FutureBuilder(
                                  future: controller.dataTeacher.get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.docs.length > 0) {
                                          return ListView.separated(
                                              itemBuilder: (context, index) {
                                                return CardItemDataTeacherInTeacherPage(
                                                  snapshot: snapshot,
                                                  index: index,
                                                  controller: controller,
                                                );
                                              },
                                              separatorBuilder: (context,
                                                  index) {
                                                return SizedBox(
                                                  height: 10,
                                                );
                                              },
                                              itemCount: snapshot.data!.docs
                                                  .length);
                                        } else {
                                          return Text('لا يوجد معلمين    ');
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
                            }
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


