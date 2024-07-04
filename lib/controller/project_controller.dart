import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
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

  Future<void> downloadFile(String url, String fileName) async {
    // Get the download directory
    final directory = await getApplicationDocumentsDirectory();
    print(directory);
    final savePath = '${directory.path}/$fileName';
    // Download the file
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final file = File(savePath);
      await file.writeAsBytes(response.bodyBytes);
      print('File downloaded successfully: $savePath');
    } else {
      print('Failed to download file: ${response.statusCode}');
    }
  }

}


