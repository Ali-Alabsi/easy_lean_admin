
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/student_controller.dart';
import '../../core/shared/color.dart';
import '../../core/shared/theming/text_style.dart';
import '../../core/widget/image_cache_error.dart';
import '../../core/widget/searchAndNameInLayoutPage.dart';

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
class DefineTitleOfTableInStudentPage extends StatelessWidget {
  const DefineTitleOfTableInStudentPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Text(
                  'الصورة ',
                  style: TextStyles.font16GreyW400,
                )),
            Expanded(
                child: Text(
                  'الاسم ',
                  style: TextStyles.font16GreyW400,
                )),
            Expanded(
                child: Text(
                  'البريد الالكتروني ',
                  style: TextStyles.font16GreyW400,
                )),
            Expanded(
                child: Text(
                  'رقم الهاتف ',
                  style: TextStyles.font16GreyW400,
                )),
            Expanded(
                child: Text(
                  'تفاصيل ',
                  style: TextStyles.font16GreyW400,
                )),
            Expanded(
                child: Text(
                  'حذف ',
                  style: TextStyles.font16GreyW400,
                )),
          ],
        ),
      ),
    );
  }
}

class CardItemDataStudentInStudentPage extends StatelessWidget {
  final snapshot;
  final int index;
  final StudentController controller;

  const CardItemDataStudentInStudentPage({
    super.key, required this.snapshot, required this.index, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: 10, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      clipBehavior:
                      Clip.antiAliasWithSaveLayer,
                      child: ImageNetworkCache(
                        url: snapshot.data.docs[index].data()['image'],
                        fit: BoxFit.fill,
                      ),
                      decoration: BoxDecoration(
                        color: ProjectColors.mainColor,
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                    ),
                  ],
                )),
            Expanded(
                child: Text(
                  snapshot.data.docs[index].data()['username'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font16BlackBold,
                )),
            Expanded(
                child: Text(
                  snapshot.data.docs[index].data()['email'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font16BlackBold,
                )),
            Expanded(
                child: Text(
                  snapshot.data.docs[index].data()['phone'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font16BlackBold,
                )),
            Expanded(
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(140, 40),
                        maximumSize: Size(140, 40),
                        side: BorderSide(
                          color: Colors.green,
                          width: 1,
                        )
                    ),
                    child: Text( 'تفاصيل'),
                    onPressed: () {

                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(140, 40),
                        maximumSize: Size(140, 40),
                        side: BorderSide(
                          color: Colors.red,
                          width: 1,
                        )
                    ),
                    child: Text('حذف'),
                    onPressed: () {
                      controller.deleteStudent(context, snapshot.data.docs[index].id);
                    },

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}