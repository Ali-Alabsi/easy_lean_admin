import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../controller/layout_controller.dart';
import '../widget/layout_widget.dart';

class Layout extends StatelessWidget {
  const Layout({Key? key}) : super(key: key);
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
                  GetBuilder<LayoutController>(
                    init: LayoutController(),
                    builder: (controller) {
                      return controller.screen[controller.indexScreen];
                    }
                  )
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




