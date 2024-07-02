import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/student_controller.dart';
import '../../core/widget/searchAndNameInLayoutPage.dart';
import '../widget/student_widget/student_widget.dart';

class Student extends StatelessWidget {
  const Student({Key? key}) : super(key: key);

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
                      DefineTitleOfTableInStudentPage(),
                      Expanded(
                        child: GetBuilder<StudentController>(
                            init: StudentController(),
                            builder: (controller) {
                              return FutureBuilder(
                                  future: controller.dataStudents.get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.docs.length > 0) {
                                          return ListView.separated(
                                              itemBuilder: (context, index) {
                                                return CardItemDataStudentInStudentPage(
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
