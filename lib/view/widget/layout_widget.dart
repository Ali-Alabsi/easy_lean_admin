import 'package:easy_lean_admin/view/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/layout_controller.dart';
import '../../core/shared/color.dart';
import '../../core/shared/theming/text_style.dart';

class NavigationBarInLayoutPage extends StatelessWidget {
  const NavigationBarInLayoutPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 220,
        height: double.infinity,
        padding: EdgeInsetsDirectional.only(start: 10),
        decoration: BoxDecoration(
          color: ProjectColors.mainColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        ),
        child: GetBuilder<LayoutController>(
          init: LayoutController(),
          builder: (controller) {
            return Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                ItemCategories(
                  onTap: (){
                    controller.changeIndexScreen(0);
                  },
                  name:'القائمة الرئسية',
                  active:controller.indexScreen == 0? true:false,
                  icon: Icons.home,
                ),
                ItemCategories(
                  onTap: (){
                    controller.changeIndexScreen(1);
                  },
                  name: 'الكورسات',
                  active:controller.indexScreen == 1?true: false,
                  icon: Icons.menu_book,
                ),
                ItemCategories(
                  onTap: (){
                    controller.changeIndexScreen(2);
                  },
                  name: 'المعلين',
                  active: controller.indexScreen == 2?true: false,
                  icon: Icons.account_circle,
                ),
                ItemCategories(
                  onTap: (){
                    controller.changeIndexScreen(3);
                  },
                  name: 'المشاريع',
                  active: controller.indexScreen == 3?true: false,
                  icon: Icons.apps,
                ),
                ItemCategories(
                  onTap: (){
                    controller.changeIndexScreen(4);
                  },
                  name: 'الطلاب',
                  active: controller.indexScreen == 4?true: false,
                  icon: Icons.account_box,
                ),
                Container(
                  margin: EdgeInsetsDirectional.only(end: 10),
                  color: ProjectColors.greyColor,
                  height: 5,
                ),
                SizedBox(
                  height: 20,
                ),
                ItemCategories(
                  onTap: (){
                    Navigator.pushAndRemoveUntil(context,
                        MaterialPageRoute(builder: (context) =>Login()),
                        (route) => false);
                  },
                  name: 'تسجيل الخروج',
                  active: false,
                  icon: Icons.exit_to_app,
                ),
              ],
            );
          }
        ));
  }
}


class ItemCategories extends StatelessWidget {
  final String name;
  final bool active;
  final void Function()? onTap;
  final IconData? icon;

  const ItemCategories({
    super.key,
    required this.name,
    required this.active,
    this.onTap,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 8),
        margin: EdgeInsetsDirectional.only(bottom: 30),
        decoration: BoxDecoration(
          color: active ? ProjectColors.whiteColor : ProjectColors.mainColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              icon,
              color:
              active ? ProjectColors.blackColor : ProjectColors.whiteColor,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              name,
              style: active
                  ? TextStyles.font20BlackBold
                  : TextStyles.font20WhiteBold,
            )
          ],
        ),
      ),
    );
  }
}