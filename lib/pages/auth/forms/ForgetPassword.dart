import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hmd_chatbot/bloc/AuthCubit.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hmd_chatbot/helpers/UiHelpers.dart';
import 'package:hmd_chatbot/pages/auth/dialogs/CheckEmailDialog.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool formError = false;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.only(
                  left: 40.w, top: 68.h, right: 40.w, bottom: 0),
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      width: 97.w,
                      child: TextButton(

                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/goBackArrow.svg",
                                height: 6.h,
                                // semanticsLabel: 'Acme Logo'
                              ),
                              SizedBox(width: 14.22),
                              Text("Back",
                                  style: Theme.of(context).textTheme.headline2),
                            ],
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(
                                    color: AppColor.btnRoundBorder, width: 2.w),
                              ))),
                          onPressed: (){
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                Center(
                    child: Text(
                  "Reset password",
                  style: Theme.of(context).textTheme.headline1,
                )),
                SizedBox(
                  height: 40.h,
                ),

                TextFormField(
                  decoration: InputDecoration(
                    fillColor: AppColor.forgetPasswordInput,
                    labelText: S.of(context).email,
                  ),
                  controller: _emailController,
                  validator: validateEmail,
                ),
                // SizedBox(
                //   height: formError == true ? 12.h : 32.h,
                // ),
                if (errorMessage != null)
                  Text(errorMessage!, style: TextStyle(color: AppColor.error)),

                Padding(
                  padding: EdgeInsets.only(
                      left: 0, top: 281.h, right: 0, bottom: 24.h),
                  child: Container(
                    decoration: getButtonDecoration(),
                    child: ElevatedButton(
                      onPressed: _onForgotPasswordButtonPressed,
                      child: const Text("Reset Password"),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ));
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

  Future<void> _onForgotPasswordButtonPressed() async {
    if (!_formKey.currentState!.validate()) {
      setState(() {
        formError = true;
      });
      return;
    }

    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }
    String? error = await BlocProvider.of<AuthCubit>(context, listen: false)
        .restorePassword(email: _emailController.text.trim().toLowerCase());
    error = null;
    if (error != null) {
      setState(() {
        errorMessage = error;
      });
    } else {
      await showDialog(
          context: context,
          builder: (c) => CheckEmailDialog(
                message: S.of(context).password_restore,
              ));
    }
  }
}
