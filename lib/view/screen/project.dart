import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../core/widget/searchAndNameInLayoutPage.dart';
import '../widget/project_widget/project_widget.dart';


class Project extends StatelessWidget {
  const Project({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth;
          double maxHeight = constraints.maxHeight;
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
            )),
            padding:
                EdgeInsetsDirectional.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                SearchAndNameInTopLayoutPage(),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListAppInPojectPage(),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}


