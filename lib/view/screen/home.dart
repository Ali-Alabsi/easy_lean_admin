
import 'package:flutter/material.dart';
import '../../core/shared/theming/text_style.dart';
import '../../core/widget/searchAndNameInLayoutPage.dart';
import '../widget/home_widget.dart';
class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return   Container(
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
                          Text('الكورسات',style: TextStyles.font18mainColorBold,),
                          Text('عرض الكل',style: TextStyles.font18GreyW400,)
                        ],
                      ),
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
            SizedBox(height: 30,),
            Container(
              width: 1000,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('المشاريع',style: TextStyles.font18mainColorBold,),
                  Text('عرض الكل',style: TextStyles.font18GreyW400,)
                ],
              ),
            ),
            SizedBox(height: 20,),
            ListAppInHomePage()

          ],
        ),
      );
  }
}

