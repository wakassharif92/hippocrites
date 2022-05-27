import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hmd_chatbot/bloc/AuthCubit.dart';
import 'package:hmd_chatbot/bloc/UserDataCubit.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/helpers/UiHelpers.dart';
import 'package:hmd_chatbot/models/UserData.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _dateController;

  String? sex;

  DateTime? birthday;

  String? errorMessage;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    UserData u = BlocProvider.of<UserDataCubit>(context).state;
    _nameController = TextEditingController(text: u.name);
    _emailController = TextEditingController(text: u.email);
    var d = u.birthdayDate;
    birthday = d;
    _dateController = TextEditingController(
        text:
            "${d.year}-${d.month < 10 ? 0 : ""}${d.month}-${d.day < 10 ? 0 : ""}${d.day}");
    sex = u.sex;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserData>(
      builder: (BuildContext context, state) {
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            // physics: NeverScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.only(top: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 20),
                  //   height: 150,
                  //   width: 150,
                  //   decoration: BoxDecoration(
                  //       shape: BoxShape.circle,
                  //       color: AppColor.userProfilePicBg),
                  //   alignment: Alignment.center,
                  //   child: Text(
                  //     state.name.trim().isEmpty
                  //         ? state.email[0]
                  //         : state.name[0],
                  //     style: TextStyle(color: Colors.white, fontSize: 50),
                  //   ),
                  // ),
                  SizedBox(height: 40.h,),
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
                    padding:  EdgeInsets.symmetric(horizontal: 24.w),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Padding(
                          //     padding: const EdgeInsets.only(
                          //         left: 0, top: 6, right: 0, bottom: 6),
                          //     child: Padding(
                          //       padding:
                          //           const EdgeInsets.symmetric(vertical: 10),
                          //       child: Text(
                          //         state.email,
                          //       ),
                          //     )),
                          Container(
                            height: 59.h,
                            child: TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              controller: _nameController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 28.w,top: 24.h,bottom: 21.h),
                                  hintText: S.of(context).name,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide())),
                              validator: (String? e) =>
                                  e == null ? S.of(context).enter_name : null,
                            ),
                          ),
                          Padding(
                            padding:  EdgeInsets.only(
                                left: 0, top: 16.h, right: 0, ),
                            child: Container(
                              height: 59.h,
                              child: TextFormField(
                                enabled: false,

                                controller: _emailController,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 28.w,top: 24.h,bottom: 21.h),
                                    hintText: S.of(context).email,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide())),
                                validator: (String? e) =>
                                e == null ? S.of(context).enter_valid_email : null,
                              ),
                            ),
                          ),
                          // Padding(
                          //     padding:  EdgeInsets.only(
                          //         left: 0, top: 16.h, right: 0, bottom: 6),
                          //     child: Container(
                          //       height: 59.h,
                          //       child: DropdownButtonFormField<String?>(
                          //         decoration:  InputDecoration(
                          //             contentPadding: EdgeInsets.only(left: 28.w,top: 24.h,bottom: 21.h),
                          //             border: OutlineInputBorder(
                          //                 borderSide: BorderSide())),
                          //         value: sex,
                          //         validator: (String? s) =>
                          //             s == null ? S.of(context).enter_sex : null,
                          //         hint: Text(
                          //           S.of(context).sex,
                          //           textAlign: TextAlign.center,
                          //         ),
                          //         items: [
                          //           DropdownMenuItem<String>(
                          //             child: Text(S.of(context).male),
                          //             value: "male",
                          //           ),
                          //           DropdownMenuItem<String>(
                          //             child: Text(S.of(context).female),
                          //             value: "female",
                          //           )
                          //         ],
                          //         onChanged: (value) {
                          //           sex = value;
                          //         },
                          //       ),
                          //     )),
                          Padding(
                            padding:  EdgeInsets.only(
                                left: 0, top: 16.h, right: 0, bottom: 0),
                            child: GestureDetector(
                              onTap: () async {
                                DateTime? d = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                );
                                if (d != null) {
                                  setState(() {
                                    birthday = d;
                                    _dateController.text =
                                        "${d.year}-${d.month < 10 ? 0 : ""}${d.month}-${d.day < 10 ? 0 : ""}${d.day}";
                                  });
                                }
                              },
                              child: Container(
                                height: 59.h,
                                color: Colors.transparent,
                                child: IgnorePointer(
                                  child: TextFormField(
                                    controller: _dateController,
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.only(left: 28.w,top: 24.h,bottom: 21.h),
                                        hintText: S.of(context).birthday_date,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide())),
                                    validator: (String? e) => e == null
                                        ? S.of(context).enter_birthday_date
                                        : null,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (errorMessage != null)
                            Text(errorMessage!,
                                style: const TextStyle(color: AppColor.error)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h,),
                  Padding(
                    padding:  EdgeInsets.only(left: 24.w),
                    child: Row(
                      children: [
                        CupertinoSwitch(
                          activeColor: AppColor.primary,
                          value:sex=="male"?true:false,
                          onChanged: (value){
                            setState(() {
                              sex="male";

                            });

                          },
                        ),
                        SizedBox(width: 10.w,),
                        Text("Male",style: Theme.of(context).textTheme.subtitle2,),  SizedBox(width: 24.w,),
                        CupertinoSwitch(
                          activeColor: AppColor.primary,
                          value:sex=="female"?true:false,
                          onChanged: (value){
                            setState(() {
                              sex="female";

                            });

                          },
                        ),
                        SizedBox(width: 10.w,),
                        Text("Female",style: Theme.of(context).textTheme.subtitle2,),

                      ],
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    width: double.infinity,
                    child:  getPrimaryButton(context,onSaveProfile,"Save")
                    ,)
                 ,
                  SizedBox(height: 16.h,),
                  // Container(
                  //   padding: EdgeInsets.symmetric(horizontal: 24.w),
                  //   width: double.infinity,
                  //   child:  getSecondaryButton(context,(){},"Cancel")
                  //   ,)
                 // ,
                  SizedBox(height: 16.h,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    width: double.infinity,
                    child:  getDimButton(context,BlocProvider.of<AuthCubit>(context).logOut,
                        "Log out")
                    ,)
                 ,SizedBox(height: 70.h,),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 40, right: 40, top: 40),
                  //   child: Row(
                  //     children: [
                  //       // Expanded(
                  //       //     child: TextButton(
                  //       //         onPressed: () {
                  //       //           Navigator.of(context).pop();
                  //       //         },
                  //       //         child: Text(S.of(context).cancel))),
                  //       // Expanded(
                  //       //     child: ElevatedButton(
                  //       //   onPressed: onSaveProfile,
                  //       //   child: Text(S.of(context).save),
                  //       // ))
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

  onSaveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    if (errorMessage != null) {
      setState(() {
        errorMessage = null;
      });
    }

    String? error = await BlocProvider.of<UserDataCubit>(context, listen: false)
        .updateProfile(
      name: _nameController.text,
      sex: sex!,
      birthdayDate: birthday!,
    );

    if (error != null) {
      setState(() {
        errorMessage = error;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: Text("Profile Updated")));
      // Navigator.of(context).pop();
    }
  }
}
