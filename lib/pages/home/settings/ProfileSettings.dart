import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hmd_chatbot/bloc/UserDataCubit.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/models/UserData.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  late TextEditingController _nameController ;

  late  TextEditingController _dateController ;

  String? sex;

  DateTime? birthday;

  String? errorMessage;

  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {

    UserData u = BlocProvider.of<UserDataCubit>(context).state;
    _nameController =TextEditingController(text: u.name);
    var d =u.birthdayDate;
    birthday = d;
    _dateController  =TextEditingController(text: "${d.year}-${d.month < 10 ? 0 : ""}${d.month}-${d.day < 10 ? 0 : ""}${d.day}");
    sex = u.sex;


  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserData>(
      builder: (BuildContext context, state) {
        return Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 40),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColor.userProfilePicBg),
                    alignment: Alignment.center,
                    child: Text(
                      state.name.trim().isEmpty?
                      state.email[0]:
                      state.name[0],
                      style: TextStyle(color: Colors.white, fontSize: 50),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, top: 6, right: 0, bottom: 6),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                state.email,
                              ),
                            )
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, top: 6, right: 0, bottom: 6),
                            child: TextFormField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                  labelText:  S.of(context).name,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide())),
                              validator: (String? e) => e == null
                                  ?  S.of(context).enter_name
                                  : null,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 0, top: 6, right: 0, bottom: 6),
                              child: DropdownButtonFormField<String?>(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide())),
                                value: sex,
                                validator: (String? s) =>
                                    s == null ?  S.of(context).enter_sex : null,
                                hint:  Text(
                                  S.of(context).sex,
                                  textAlign: TextAlign.center,
                                ),
                                items:  [
                                  DropdownMenuItem<String>(
                                    child: Text( S.of(context).male),
                                    value: "male",
                                  ),
                                  DropdownMenuItem<String>(
                                    child: Text( S.of(context).female),
                                    value: "female",
                                  )
                                ],
                                onChanged: (value) {
                                  sex = value;
                                },
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, top: 6, right: 0, bottom: 6),
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
                                color: Colors.transparent,
                                child: IgnorePointer(
                                  child: TextFormField(
                                    controller: _dateController,
                                    decoration: InputDecoration(
                                        labelText:  S.of(context).birthday_date,
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide())),
                                    validator: (String? e) => e == null
                                        ?  S.of(context).enter_birthday_date
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
                  Padding(
                    padding: const EdgeInsets.only(left: 40, right:  40, top: 40),
                    child: Row(
                      children: [
                        Expanded(
                            child:
                                TextButton(onPressed: () {Navigator.of(context).pop();}, child: Text( S.of(context).cancel))),
                        Expanded(child: ElevatedButton(onPressed: onSaveProfile, child: Text( S.of(context).save),))
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


  onSaveProfile()async {

    if(! _formKey.currentState!.validate()) return;

    if(errorMessage!=null){
      setState(() {
        errorMessage = null;
      });
    }

    String? error = await BlocProvider.of<UserDataCubit>(context, listen: false).updateProfile(name: _nameController.text, sex: sex!, birthdayDate: birthday!,);

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
