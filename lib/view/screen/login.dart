

import 'package:easy_lean_admin/controller/login_contoller.dart';
import 'package:easy_lean_admin/core/shared/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/shared/color.dart';
import '../../core/shared/theming/text_style.dart';
import '../../core/widget/app_text_form_filed.dart';
import '../../core/widget/button.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          height: double.infinity,
          // margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: ProjectColors.mainColor
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child:  Container(
                height: 420,
                width: 450,
                decoration: BoxDecoration(
                  color: ProjectColors.whiteColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(
                  child: Container(
                    margin: EdgeInsetsDirectional.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('تسجيل الدخول' ,style: TextStyles.font20mainColorBold,),
                        SizedBox(height: 40,),
                        AppTextFormFiled(hintText: 'اسم المستخدم ', controller: MyController.emailLogin,),
                        SizedBox(height: 20,),
                        AppTextFormFiled(hintText: 'كلمة المرور', controller: MyController.passwordLogin,),
                        SizedBox(height: 20,),
                        GetBuilder<LoginController>(
                          init: LoginController(),
                          builder: (controller) {
                            return MainButton(
                              name: 'تسجيل الدخول',onPressed: (){
                                controller.login(context);

                            },
                              margin: EdgeInsetsDirectional.zero,
                            );
                          }
                        )
                      ],
                    ),
                  ),
                ),
              )
              ),
              SizedBox(width: 10,),
              Expanded(child: SizedBox()),
              SizedBox(width: 10,),
              Expanded(child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/logo.png'),
                    Text('Easy Lean' ,style: TextStyles.font22WhiteBold, )
                  ],
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
