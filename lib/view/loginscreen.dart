import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/usecase/validation.dart';

import 'package:sbterp/utils/navigation.dart';

import 'package:sbterp/widgets/custom_button.dart';
import 'package:sbterp/widgets/custom_form-fild.dart';
import 'package:sbterp/widgets/main_container.dart';
import 'package:sbterp/widgets/password-form-field.dart';
import 'package:sbterp/widgets/snackbar.dart';
import 'package:sbterp/widgets/text_button.dart';
import 'package:provider/provider.dart';
import '../../business_logic/view_model/account_vm.dart';
import 'package:sbterp/view/landingpage.dart';

import '../business_logic/usecase/validation.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_form-fild.dart';
import '../widgets/main_container.dart';
import '../widgets/password-form-field.dart';
import '../widgets/snackbar.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  var formK = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final _acountVm = Provider.of<AccountVM>(context, listen: false);
return MainContainer(
    widget: Scaffold(
      // appBar: AppBar(elevation: 0),
      body: Stack(children: [
      Container(
      decoration: BoxDecoration(
      image: DecorationImage(
          image: AssetImage("assets/Backkground.jpg"),
      fit: BoxFit.cover,
    ),
),
    ),
      SingleChildScrollView(
        child: Form(
          key: formK,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [ const SizedBox(
            height: 100,
          ),
          Center(
              child: Image(image: AssetImage("assets/logo.png")),


                  ),

          const SizedBox(
            height: 50,
          ),
          CustomFormField(

            controller: userName,
            iconData: Icons.person,
            hint: "اسم المستخدم",
            errorMessage: "×طأ في الادخال",

          ),
          PasswordTextField(
            controller: password,
            validator: Validator.isValidPassword,
            hint: "كلمة المرور",
            errorMessage: "×طأ في الادخال",
          ),
          CustomBtn(
              name: "تسجيل الدخول",
              action: () async {
                if (formK.currentState!.validate()) {

                  var userM = await _acountVm.login(userName.text);
                  if (userM != null && userM.userpass == password.text) {
                    if (!mounted) {
                      return;
                    }
                    _acountVm.keepLogin( userM.username!,userM.cashbox!,userM.storid!);
                    // if (userM.jop== "مندوب مبيعات"){Navigation.puchReplace(const LandingPage(), context);}
                    // if (userM.jop== "عميل"){Navigation.puchReplace(const Revivable(), context);}
                     if (userM.jop== "مدير نظام"){Navigation.puchReplace(const Homescreen(), context);}

                  } else {
                    if (!mounted) {
                      return;
                    }
                    CSnackBar.showSnackBar(context, "اسم المستخدم او كلمة المرور غير مسجل");
                  }
                }
              }),
              ],
          ),

        ),
      ),
      ],)
    )

    );
  }
}
