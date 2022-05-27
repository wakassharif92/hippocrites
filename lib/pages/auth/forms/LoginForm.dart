import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmd_chatbot/bloc/AuthCubit.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/pages/auth/dialogs/CheckEmailDialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmd_chatbot/pages/auth/forms/ForgetPassword.dart';
import 'package:hmd_chatbot/pages/auth/forms/RegistrationForm.dart';
import 'package:hmd_chatbot/services/api/APIFactory.dart';
import 'package:hmd_chatbot/services/storage/StorageFactory.dart';

import '../../../helpers/UiHelpers.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

enum ConfirmAction { cancel, accept }

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? errorMessage;
  bool formError = false;

  final _formKey = GlobalKey<FormState>();
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Form(
        key: _formKey,
        child: ListView(
          padding:
              EdgeInsets.only(left: 40.w, top: 84.h, right: 40.w, bottom: 0),
          children: <Widget>[
            Center(
                child: Text(
              "Welcome Back",
              style: Theme.of(context).textTheme.headline1,
            )),
            SizedBox(
              height: 4.h,
            ),
            Center(
                child: Text(
              "Login into your account",
              style: Theme.of(context).textTheme.subtitle1,
            )),
            SizedBox(
              height: 40.h,
            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: S.of(context).email,
              ),
              controller: _emailController,
              validator: validateEmail,
            ),
            SizedBox(
              height: formError == true ? 12.h : 32.h,
            ),
            Stack(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      hintText: S.of(context).password,
                      ),

                  controller: _passwordController,
                  obscureText: hidePassword,
                ),
                Positioned(
                right: 28.w,
                  top: 24.h,
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        hidePassword=!hidePassword;
                      });
                    },
                    child: !hidePassword?Container(

                      child: SvgPicture.asset(
                        "assets/images/eye.svg",
                        height: 20.h,
                        // semanticsLabel: 'Acme Logo'
                      ),
                    ):
                    Container(

                      child: SvgPicture.asset(
                        "assets/images/closeEye.svg",
                        height: 20.h,
                        // semanticsLabel: 'Acme Logo'
                      ),
                    ),
                  ),
                )
              ],
            ),
            if (errorMessage != null)
              Text(errorMessage!, style: TextStyle(color: AppColor.error)),
            SizedBox(
              height: 32-5.h,
            ),
            InkWell(onTap:_onForgotPasswordButtonPressed,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Text(
                "Forgotten password?",
                textAlign: TextAlign.right,
                style: TextStyle(  color: AppColor.primary,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),),

            Padding(
              padding:
                  EdgeInsets.only(left: 0, top: 196.h, right: 0, bottom: 24.h),
              child: Container(
                decoration: getButtonDecoration(),
                child: ElevatedButton(
                  onPressed: _onLoginButtonPressed,
                  child: Text(S.of(context).login),
                ),
              ),
            ),

            Container(
              decoration: getButtonDecoration(),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppColor.btnSimpleBgColor),
                onPressed: (){
                  signupButtonPress(context);
                },
                child: Text(
                  S.of(context).sign_up,
                  style: const TextStyle(color: AppColor.btnSimpleText),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String? validateEmail(String? value) {
    if (value == null) {
      return S.of(context).enter_valid_email;
    }
    const String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    var regex = RegExp(pattern);

    if (!regex.hasMatch(value)) {
      return S.of(context).enter_valid_email;
    } else {
      return null;
    }
  }

  void _onLoginButtonPressed() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }

    String? error = await BlocProvider.of<AuthCubit>(context, listen: false)
        .logIn(
            email: _emailController.text.toLowerCase(),
            password: _passwordController.text);
    if (error != null) {
      setState(() {
        errorMessage = error;
      });
    }
  }
   signupButtonPress(BuildContext context){
    Navigator.of(context).push( MaterialPageRoute(builder: (context) =>   BlocProvider(
      create: (BuildContext context) => AuthCubit(
          storageFactory: StorageFactory(),
          apiFactory: APIFactory()),
      child:  RegistrationForm(),
    )));
    // Navigator.push(
    //   context,
    //   ),
    // );

  }
  Future<void> _onForgotPasswordButtonPressed() async {
    Navigator.of(context).push( MaterialPageRoute(builder: (context) =>  BlocProvider(
      create: (BuildContext context) => AuthCubit(
          storageFactory: StorageFactory(),
          apiFactory: APIFactory()),
      child: const ForgetPassword(),
    )));
    // if (!_formKey.currentState!.validate()) {
    //   setState(() {
    //     formError = true;
    //   });
    //   return;
    // }
    //
    // if (errorMessage != null) {
    //   setState(() {
    //     errorMessage = null;
    //   });
    // }
    // String? error = await BlocProvider.of<AuthCubit>(context, listen: false)
    //     .restorePassword(email: _emailController.text.trim().toLowerCase());
    // error = null;
    // if (error != null) {
    //   setState(() {
    //     errorMessage = error;
    //   });
    // } else {
    //   await showDialog(
    //       context: context,
    //       builder: (c) => CheckEmailDialog(
    //             message: S.of(context).password_restore,
    //           ));
    // }
  }
}
