import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hmd_chatbot/bloc/UserDataCubit.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/helpers/UiHelpers.dart';
import 'package:hmd_chatbot/models/UserData.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class PasswordSettings extends StatefulWidget {
  const PasswordSettings({Key? key}) : super(key: key);

  @override
  _PasswordSettingsState createState() => _PasswordSettingsState();
}

class _PasswordSettingsState extends State<PasswordSettings> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  String? errorMessage;

  final _formKey = GlobalKey<FormState>();
bool hidePassword  = true ;
bool hideCurrentPassword  = true ;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserData>(
      builder: (BuildContext context, state) {
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  Stack(
                    children: [
                      Container(
                        height: 120.h,
                        width: 120.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.h),
                          color: AppColor.themeGrey,
                        ),
                      ),
                      Positioned.fill(
                          child: Align(
                            child: Container(
                              child: SvgPicture.asset("assets/images/person.svg",
                                  height: 69.h
                                // width: 69.sp,
                                // semanticsLabel: 'Acme Logo'
                              ),
                            ),
                          )),
                      Positioned(
                        right: 10.w,
                        top: 10.h,
                        child: SvgPicture.asset("assets/images/edit.svg",
                            height: 24.h
                          // width: 69.sp,
                          // semanticsLabel: 'Acme Logo'
                        ),)
                    ],
                  ),
                  SizedBox(height: 40.h,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(
                                left: 0, top: 0, right: 0, bottom: 0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 59.h,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 28.w,top: 24.h,bottom: 21.h,right: 70.w),
                                        hintText: S.of(context).current_password),
                                    controller: _passwordController,
                                    obscureText: hideCurrentPassword,
                                  ),
                                ),
                                Positioned(
                                  right: 28.w,
                                  child: Container(height: 59.h,

                                    child:  InkWell(
                                      onTap: (){
                                        setState(() {
                                          hideCurrentPassword=!hideCurrentPassword;
                                        });
                                      },
                                      child: !hideCurrentPassword?Container(
                                        // padding: EdgeInsets.only(right: 28.w),
                                        child: SvgPicture.asset(
                                          "assets/images/eye.svg",
                                          height: 20.h,
                                          // semanticsLabel: 'Acme Logo'
                                        ),
                                      ):
                                      Container(
                                        // padding: EdgeInsets.only(right: 28.w),
                                        child: SvgPicture.asset(
                                          "assets/images/closeEye.svg",
                                          height: 20.h,
                                          // semanticsLabel: 'Acme Logo'
                                        ),
                                      ),
                                    ),),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(
                                left: 0, top: 16.h, right: 0, bottom: 0),
                            child: Stack(
                              children: [
                                Container(
                                  height: 59.h,
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 28.w,top: 24.h,bottom: 21.h,right: 70.w),
                                        hintText: S.of(context).new_password,
                                        ),
                                    controller: _newPasswordController,
                                    obscureText: hidePassword,
                                  ),
                                ),
                                Positioned(
                                  right: 28.w,
                                  child: Container(height: 59.h,

                                  child:  InkWell(
                                    onTap: (){
                                      setState(() {
                                        hidePassword=!hidePassword;
                                      });
                                    },
                                    child: !hidePassword?Container(
                                      // padding: EdgeInsets.only(right: 28.w),
                                      child: SvgPicture.asset(
                                        "assets/images/eye.svg",
                                        height: 20.h,
                                        // semanticsLabel: 'Acme Logo'
                                      ),
                                    ):
                                    Container(
                                      // padding: EdgeInsets.only(right: 28.w),
                                      child: SvgPicture.asset(
                                        "assets/images/closeEye.svg",
                                        height: 20.h,
                                        // semanticsLabel: 'Acme Logo'
                                      ),
                                    ),
                                  ),),
                                )
                              ],
                            ),
                          ),
                          if (errorMessage != null)
                            Text(errorMessage!,
                                style: TextStyle(color: AppColor.error)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    width: double.infinity,
                    child:  getPrimaryButton(context,onSavePass,"Save")
                    ,),
                  SizedBox(height: 16.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    width: double.infinity,
                    child:  getDimButton(context,(){},"Cancel")
                    ,),
                  SizedBox(height: 70.h,),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 40, right: 40, top: 40),
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //           child: TextButton(
                  //               onPressed: () {
                  //                 Navigator.of(context).pop();
                  //               },
                  //               child: Text(S.of(context).cancel))),
                  //       Expanded(
                  //           child: ElevatedButton(
                  //         onPressed: onSavePass,
                  //         child: Text(S.of(context).save),
                  //       ))
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  onSavePass() async {
    if (!_formKey.currentState!.validate()) return;

    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }

    String? error = await BlocProvider.of<UserDataCubit>(context, listen: false)
        .changePass(
            currentPass: _passwordController.text,
            newPass: _newPasswordController.text);

    if (error != null) {
      setState(() {
        errorMessage = error;
      });
    } else {
      // Navigator.of(context).pop();
    }
  }
}
