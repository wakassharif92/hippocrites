import 'package:flutter/material.dart';
import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../helpers/UiHelpers.dart';

class OptionsDialog extends StatefulWidget {
  const OptionsDialog({Key? key, required this.options, required this.selected})
      : super(key: key);
  final List<String> options;
  final List<String> selected;

  @override
  _OptionsDialogState createState() => _OptionsDialogState();
}

class _OptionsDialogState extends State<OptionsDialog> {
  addOption(String o) {
    if (widget.selected.contains(o)) return;
    setState(() {
      widget.selected.add(o);
    });
  }

  removeOption(String o) {
    if (!widget.selected.contains(o)) return;
    setState(() {
      widget.selected.remove(o);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      maxChildSize: 1,
      initialChildSize: 1,
      minChildSize: 0.5,
      builder: (BuildContext context, ScrollController scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: EdgeInsets.only(top: 92.h, left: 22.5.w, right: 22.5.w),
            child: Column(
              children: [
                Text(
                  "Choose an option",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  children: widget.options
                      .map((e) => GestureDetector(
                            onTap: () {
                              if (!widget.selected.contains(e)) {
                                addOption(e);
                              } else {
                                removeOption(e);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: widget.selected.contains(e)
                                    ? AppColor.selectOption
                                    : Colors.white,
                                border:  Border.all(color:AppColor.selectOption),
                                borderRadius: BorderRadius.circular(4.h),
                                // boxShadow: <BoxShadow>[
                                //   BoxShadow(
                                //     color: AppColor.msgSent.withOpacity(0.16),
                                //     blurRadius: 20,
                                //     spreadRadius: 1,
                                //     offset: Offset(0, 5),
                                //   ),
                                // ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Checkbox(materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  //   activeColor: AppColor.primary,
                                  //   value: widget.selected.contains(e),
                                  //   onChanged: (v){
                                  //   if(v==null) return;
                                  //     if(v) {
                                  //       addOption(e);
                                  //     } else {
                                  //       removeOption(e);
                                  //     }
                                  //   }
                                  // ),
                                  Flexible(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w, vertical: 16.h),
                                      
                                      child: Text(
                                        e,
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600,
                                          // overflow: TextOverflow.fade,
                                          color: widget.selected.contains(e)
                                              ? Colors.white
                                              : AppColor.selectOption,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*1,
                  margin: EdgeInsets.symmetric(horizontal:17.5.w),
                  // decoration: getButtonDecoration(),
                  child: ElevatedButton(
                    onPressed: (){

                      Navigator.of(context).pop();
                    },
                    child: Text("Choose",style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: Colors.white
                    )),
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*1,
                  margin: EdgeInsets.symmetric(horizontal:17.5.w),
                  decoration: getButtonDecoration(),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: AppColor.btnSecondary,
                        shadowColor: Colors.white,
                        elevation: 0),
                    onPressed: (){    Navigator.of(context).pop();},
                    child:Text("Cancel",style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.white
                    )),
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
