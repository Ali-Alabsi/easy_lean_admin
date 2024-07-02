import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/project_controller.dart';
import '../../../core/shared/color.dart';
import '../../../core/shared/theming/text_style.dart';
import '../../../core/widget/image_cache_error.dart';

class ListAppInPojectPage extends StatelessWidget {
  const ListAppInPojectPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectController>(
        init: ProjectController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.dataApp.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length > 0) {
                      return GridView.builder(
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1,
                              mainAxisExtent: 290),
                          itemBuilder: (context, index) {
                            return CardItemAppInPojectPage(
                              index: index,
                              snapshot: snapshot,
                              controller: controller,
                            );
                          },
                          itemCount: snapshot.data!.docs.length);
                    } else {
                      return Text('لا يوجد تطبيقات  ');
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              });
        });
  }
}

class CardItemAppInPojectPage extends StatelessWidget {
  final snapshot;
  final int index;
  final ProjectController controller;
  const CardItemAppInPojectPage({
    super.key,
    required this.snapshot,
    required this.index, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 30),
      decoration: BoxDecoration(
          color: ProjectColors.greyColor300,
          borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 50,
                  width: 50,
                  decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25)),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ImageNetworkCache(
                    url: snapshot.data.docs[index].data()['image'][0],
                  )),
              Text(
                snapshot.data.docs[index].data()['name'],
                style: TextStyles.font20mainColorBold,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                snapshot.data.docs[index].data()['details'],
                overflow: TextOverflow.ellipsis,
                style: TextStyles.font14GreyW500,
                maxLines: 5,

              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
          Row(
            children: [
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
                          )),
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
                            color: Colors.red,
                            width: 1,
                          )),
                      child: Text('حذف'),
                      onPressed: () {
                        controller.deleteApp(context, snapshot.data.docs[index].id);
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}