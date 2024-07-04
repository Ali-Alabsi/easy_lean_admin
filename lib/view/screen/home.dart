import 'package:easy_lean_admin/controller/layout_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/shared/theming/text_style.dart';
import '../../core/widget/searchAndNameInLayoutPage.dart';
import '../widget/home_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LayoutController controllerPut = Get.put(LayoutController());
    return Container(
      padding: EdgeInsetsDirectional.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SearchAndNameInTopLayoutPage(),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 800,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'الكورسات',
                          style: TextStyles.font18mainColorBold,
                        ),
                        InkWell(
                          onTap: (){
                            controllerPut.changeIndexScreen(1);
                          },
                            child: Text(
                          'عرض الكل',
                          style: TextStyles.font18GreyW400,
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ListCoursesInlayoutPage()
                ],
              ),
              SizedBox(
                width: 20,
              ),
              infoOfUserInHomePage(),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: 1000,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'المشاريع',
                  style: TextStyles.font18mainColorBold,
                ),
                InkWell(
                  onTap: (){
                    controllerPut.changeIndexScreen(3);
                  },
                  child: Text(
                    'عرض الكل',
                    style: TextStyles.font18GreyW400,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ListAppInHomePage()
        ],
      ),
    );
  }
}
