import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hmd_chatbot/bloc/AuthCubit.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/UiHelpers.dart';
import 'package:hmd_chatbot/pages/auth/dialogs/CheckEmailDialog.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  String? sex;
  DateTime? birthday;
  String? errorMessage;
  bool hidePassword = true;
bool isMale = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: ListView(
          padding:
          EdgeInsets.only(left: 40.w, top: 84.h, right: 40.w, bottom: 0),
          children: <Widget>[
            Center(
                child: Text(
                  "Hello there!",
                  style: Theme.of(context).textTheme.headline1,
                )),
            SizedBox(
              height: 4.h,
            ),
            Center(
                child: Text(
                  "we’re almost done. Before using our services you need to create an account.",
                  style: Theme.of(context).textTheme.subtitle1,
                  textAlign: TextAlign.center,
                )),
            SizedBox(
              height: 40.h,
            ),
            TextFormField(
              decoration: InputDecoration(hintText: S.of(context).email),
              keyboardType: TextInputType.emailAddress,
              controller: _emailController,
              validator: validateEmail,
            ),
            SizedBox(
              height: 32.h,
            ),
            Stack(
              children: [
                TextFormField(
                  decoration:  InputDecoration(hintText: S.of(context).password,
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
            SizedBox(
              height: 32.h,
            ),
            GestureDetector(
              onTap: ()async{

                DateTime? d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1950), lastDate: DateTime.now(),);
                if(d!=null) {
                  setState(() {
                    birthday = d;
                    _dateController.text= "${d.year}-${d.month<10?0:""}${d.month}-${d.day<10?0:""}${d.day}";
                  });
                }

              },
              child: Container(
                color: Colors.transparent,
                child: IgnorePointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(hintText: S.of(context).birthday_date),
                    validator: (String? e) => e == null ? S.of(context).enter_birthday_date: e == "" ? S.of(context).enter_birthday_date : null,
                  ),
                ),
              ),
            ),

            if (errorMessage != null)
              Text(errorMessage!, style: TextStyle(color: AppColor.error)),
            SizedBox(
              height: 32.h,
            ),
            // DropdownButtonFormField<String?>(
            //   value: sex,
            //   validator: (String? s)=>s==null ? S.of(context).enter_sex : null,
            //   hint: Text(S.of(context).sex, textAlign: TextAlign.center,),
            //   items: [
            //     DropdownMenuItem<String>(child: Text(S.of(context).male), value: "male",),
            //     DropdownMenuItem<String>(child: Text(S.of(context).female), value: "female",)
            //   ],
            //   onChanged: (value) {
            //     sex=value;
            //   },
            // ),
            Row(
              children: [
                CupertinoSwitch(
                  activeColor: AppColor.primary,
                  value:isMale,
                  onChanged: (value){
                    setState(() {
                      isMale=!isMale;

                    });

                  },
                ),
                SizedBox(width: 10.w,),
                Text("Male",style: Theme.of(context).textTheme.subtitle2,),  SizedBox(width: 24.w,),
                CupertinoSwitch(
                  activeColor: AppColor.primary,
                  value:!isMale,
                  onChanged: (value){
                    setState(() {
                      isMale=!isMale;

                    });

                  },
                ),
                SizedBox(width: 10.w,),
                Text("Female",style: Theme.of(context).textTheme.subtitle2,),

              ],
            ),
            Padding(
              padding:
                   EdgeInsets.only(left: 0, top: 54.h, right: 0, bottom: 0),
              child: Container(
                decoration: getButtonDecoration(),
                child: ElevatedButton(
                  onPressed: _onLoginButtonPressed,
                  child:  Text(S.of(context).sign_up),
                ),
              ),
            ),
            SizedBox(height: 24.h,),
            Container(
              decoration: getButtonDecoration(),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(primary: AppColor.btnSimpleBgColor),
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  S.of(context).login,
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
    if(value==null) {
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


  void _onLoginButtonPressed() async{

    if(! _formKey.currentState!.validate()) return;

    if(errorMessage!=null){
      setState(() {
        errorMessage = null;
      });
    }
    sex = isMale?"male":"female";

    String? error = await BlocProvider.of<AuthCubit>(context, listen: false).signIn(email: _emailController.text.toLowerCase(), password: _passwordController.text, sex: sex!, birthDate: birthday!);
    if(error!=null) {
      setState(() {
        errorMessage=error;
      });
    }
    else{
      await showDialog(context: context, builder: (c)=> CheckEmailDialog(message: S.of(context).thanks_registration,));
      setState(() {
        _emailController.text ="";
        _dateController.text= "";
        _passwordController.text ="";
        sex = null;
        birthday =null;
      });

    }

  }
}
