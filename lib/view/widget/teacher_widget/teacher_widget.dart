import 'package:flutter/material.dart';

import '../../../controller/teacher_controller.dart';
import '../../../core/shared/color.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../../core/widget/image_cache_error.dart';

class CardItemDataTeacherInTeacherPage extends StatelessWidget {
  final snapshot;
  final int index;
  final TeacherController controller;

  const CardItemDataTeacherInTeacherPage({
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
                  snapshot.data.docs[index].data()['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.font16BlackBold,
                )),
            Expanded(
                child: Text(
                  snapshot.data.docs[index].data()['work'],
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
                          color: ProjectColors.mainColor,
                          width: 1,
                        )
                    ),
                    child: Text('تفاصيل'),
                    onPressed: () {},
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
                          color: Colors.green,
                          width: 1,
                        )
                    ),
                    child: Text( snapshot.data.docs[index].data()['active']
                        ? 'تقيد'
                        : 'فك التقيد',),
                    onPressed: () {
                      controller.updateActive(context,   snapshot.data.docs[index].id,   snapshot.data.docs[index].data()['active']);
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
                      controller.deleteTeacher(context, snapshot.data.docs[index].id);
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

class DefineTitleInTable extends StatelessWidget {
  const DefineTitleInTable({
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
                  'الوظيفة ',
                  style: TextStyles.font16GreyW400,
                )),
            Expanded(
                child: Text(
                  'تفاصيل ',
                  style: TextStyles.font16GreyW400,
                )),
            Expanded(
                child: Text(
                  'قيد ',
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