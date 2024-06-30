import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_controller.dart';
import '../../core/shared/color.dart';
import '../../core/shared/theming/text_style.dart';
import '../../core/widget/app_text_form_filed.dart';
import '../../core/widget/image_cache_error.dart';

class CardItemCoursesInHomePage extends StatelessWidget {
  final snapshot;
  final int index;

  const CardItemCoursesInHomePage({
    super.key,
    required this.snapshot,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(5),
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF956CF7),
              Color(0xFFD276B6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20)),
      height: 150,
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 18,
                child: Icon(
                  Icons.favorite,
                  size: 23,
                ),
              ),
              Container(
                  height: 80,
                  width: 80,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30)
                  ),
                  child: ImageNetworkCache(url: snapshot.data.docs[index].data()['image'],)
              ),
            ],
          ),
          Column(
            children: [
              Text(
                snapshot.data!.docs[index].data()['name'],
                style: TextStyles.font14WhiteW500,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ListAppInHomePage extends StatelessWidget {
  const ListAppInHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.dataApp.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length > 0) {
                      return Container(
                        height: 200,
                        width: 1000,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index){
                              return CardItemAppInHomePage(index: index,snapshot: snapshot,);
                            }, separatorBuilder: (context ,index){
                          return SizedBox(width: 20,);
                        }, itemCount: snapshot.data!.docs.length),
                      );
                    } else {
                      return Text('لا يوجد تطبيقات  ');
                    }
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

class CardItemAppInHomePage extends StatelessWidget {
  final snapshot;
  final int index;
  const CardItemAppInHomePage({
    super.key,required this.snapshot, required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 10),
      width: 300,
      decoration: BoxDecoration(
          color: ProjectColors.greyColor300,
          borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25)
              ),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              child: ImageNetworkCache(url: snapshot.data.docs[index].data()['image'][0],)
          ),
          Text(snapshot.data.docs[index].data()['name'], style: TextStyles.font20BlackBold,),
          Text(
            snapshot.data.docs[index].data()['details'],
            overflow:TextOverflow.ellipsis,
            style: TextStyles.font14GreyW500,
            maxLines: 5,
          )
        ],
      ),
    );
  }
}

class infoOfUserInHomePage extends StatelessWidget {
  const infoOfUserInHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.dataAdmin.doc('8ngYJqerj9rG64MhzsfR').get(),
              builder: (context,snapshot){
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsetsDirectional.only(top: 50),
                              height: 220,
                              width: 250,

                              decoration: BoxDecoration(
                                color: ProjectColors.greyColor300,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: EdgeInsetsDirectional.symmetric(vertical: 10),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            height: 60,
                                          ),
                                          Text(snapshot.data!['name']),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            snapshot.data!['email'],
                                            style: TextStyles.font14GreyW300,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Text(
                                                'number',
                                                style: TextStyles.font14GreyW300,
                                              ),
                                              Text(
                                                snapshot.data!['id'],
                                                style: TextStyles.font18BlackBold,
                                              )
                                            ],
                                          ),
                                          Container(
                                            width: 3,
                                            height: 70,
                                            color: ProjectColors.whiteColor,
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'work',
                                                style: TextStyles.font14GreyW300,
                                              ),
                                              Text(
                                                snapshot.data!['work'],
                                                style: TextStyles.font18BlackBold,
                                              )
                                            ],
                                          ),
                                        ],
                                      )
                                    ]),
                              ),
                            ),
                            Positioned(
                              child: Container(
                                  height: 100,
                                  width: 100,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  decoration: BoxDecoration(
                                      color: ProjectColors.mainColor,
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: ImageNetworkCache(
                                    url: snapshot.data!['image'],
                                  )
                              ),
                              top: 0,
                              left: 70,
                            ),
                          ],
                        );

                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }

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

class ListCoursesInlayoutPage extends StatelessWidget {
  const ListCoursesInlayoutPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return FutureBuilder(
              future: controller.dataCourses.get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length > 0) {
                      return Container(
                        height: 200,
                        width: 800,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return CardItemCoursesInHomePage(
                                snapshot: snapshot,
                                index: index,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(width: 10);
                            },
                            itemCount: snapshot.data!.docs.length),
                      );
                    } else {
                      return Text('لا يوجد كورسات في هذا القسم ');
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
          );
        });
  }
}

