import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../core/widget/awesome_dialog.dart';

class ProjectController extends GetxController{
  CollectionReference dataApp  = FirebaseFirestore.instance.collection('app');
  void deleteApp(context , String id) async {
    await dataApp.doc(id).delete().whenComplete(() {
      update();
      snackBarDialog(context, 'تم العملية  الحذف بنجاح');
    }).onError((error, stackTrace) {
      snackBarDialog(context, ' هناك خطاء لم تتم عملية الحذف');
    });
  }
}