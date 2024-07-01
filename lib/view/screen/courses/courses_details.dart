
import 'package:flutter/material.dart';

import '../../widget/layout_widget.dart';

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
                child: Container(
                  width: double.infinity,
                  child: Row(
                    children: [
                      NavigationBarInLayoutPage(),
                      SizedBox(
                        width: 30,
                      ),
                      Text('ali')
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text('حجم الشاشة لا يسمح بعرض التطبيق'));
            }
          },
        )
    );
  }
}
