import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/bloc/UserDataCubit.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/models/UserData.dart';

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 0, top: 6, right: 0, bottom: 6),
                            child: TextFormField(
                              decoration:  InputDecoration(labelText:  S.of(context).current_password),
                              controller: _passwordController,
                              obscureText: true,
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 0, top: 6, right: 0, bottom: 6),
                            child: TextFormField(
                              decoration:  InputDecoration(labelText: S.of(context).new_password),
                              controller: _newPasswordController,
                              obscureText: true,
                            ),
                          ),

                          if (errorMessage != null)
                            Text(errorMessage!,
                                style: TextStyle(color: AppColor.error)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40, right:  40, top: 40),
                    child: Row(
                      children: [
                        Expanded(
                            child:
                            TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text(S.of(context).cancel))),
                        Expanded(child: ElevatedButton(onPressed: onSavePass, child: Text(S.of(context).save),))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  onSavePass()async {

    if(! _formKey.currentState!.validate()) return;

    if(errorMessage!=null){
      setState(() {
        errorMessage = null;
      });
    }

    String? error = await BlocProvider.of<UserDataCubit>(context, listen: false).changePass(currentPass: _passwordController.text, newPass: _newPasswordController.text);

    if(error!=null) {
      setState(() {
        errorMessage=error;
      });
    }

    else{
      Navigator.of(context).pop();
    }


  }
}
