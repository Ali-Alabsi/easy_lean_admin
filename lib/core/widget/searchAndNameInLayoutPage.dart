import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../shared/color.dart';
import '../shared/theming/text_style.dart';
import 'app_text_form_filed.dart';

class SearchAndNameInTopLayoutPage extends StatelessWidget {
  const SearchAndNameInTopLayoutPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.dataAdmin.doc('8ngYJqerj9rG64MhzsfR').get(),
              builder: (context,snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Row(
                      children: [
                        Text(
                          ' مرحبا ',
                          style: TextStyles.font16BlackBold,
                        ),
                        Text(
                            snapshot.data!['name'],
                          style: TextStyles.font16mainColorBold,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 40,
                          width: 600,
                          child: AppTextFormFiled(
                            hintText: 'بحث',
                            fillColor: ProjectColors.greyColor,
                          ),
                        )
                      ],
                    );

                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
          );
        }
    );
  }
}