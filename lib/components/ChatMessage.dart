import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/models/Message.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMessage extends StatelessWidget {
  var selectedOptions;
   ChatMessage( this.message,this.selectedOptions);

  final Message message;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.85;
    var boxConstraints = BoxConstraints(maxWidth: width, minWidth: 150.0);


    if (message.type == Message.SEPARATOR_TYPE ) {
      return Container(
        width: double.maxFinite,
        // height: 50,
        margin: EdgeInsets.symmetric(vertical: 30),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    correctDateTime(message.dateTime, context)
                        .substring(0, 3)
                        .toUpperCase(),
                    style: TextStyle(
                        color: AppColor.darkPurple,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600),
                  ), Text(
                    correctDateTime(message.dateTime, context)
                        .substring(4, correctDateTime(message.dateTime, context).length)
                        .toUpperCase(),
                    style: TextStyle(
                        color: AppColor.darkPurple,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400),
                  ),
                  // Text(correctDateTime(message.dateTime, context)),
                ],
              ),
              // child: Text(correctDateTime(message.dateTime, context)),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 48.h, top: 24.h, left: 24.w, right: 24.w),
              child: Divider(
                thickness: 1.5.sp,
                color: AppColor.lightGrey,
              ),
            )
          ],
        ),
      );
    }

      else {
      return Row(
          mainAxisAlignment: message.fromUser
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.start,
          children: <Widget>[
            Container(),
            Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          if (message.title != null)
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 5),
                                      child: SelectableText(
                                        message.title!.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w600,
                                            color: message.fromUser
                                                ? AppColor.msgUserText
                                                : AppColor.msgBotText),
                                      ),
                                    ),
                                  ),
                                  if (message.probability != null)
                                    Column(
                                      // mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text((message.probability! < 50
                                                ? S.of(context).low
                                                : message.probability! < 75
                                                    ? S.of(context).medium
                                                    : S.of(context).high) +
                                            " " +
                                            S.of(context).probability,
                                        style: TextStyle(fontSize: 10.sp,fontWeight: FontWeight.w400),),
                                        Container(
                                          margin: EdgeInsets.only(top: 4.h),
                                          width: 91.w,
                                          height:2.h ,

                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            child: LinearProgressIndicator(

                                              backgroundColor:
                                                  AppColor.primary.withOpacity(0.5),
                                              color: AppColor.primary,
                                              value: message.probability! / 100,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  else
                                    Container()
                                ],
                              ),
                            ),
                          if (message.text != null)
                            Markdown(
                              onTapLink: (text, link, _) async {
                                if (await canLaunch(link ?? "")) {
                                  launch(link ?? "");
                                }
                              },
                              data: message.text!,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              selectable: true,
                              styleSheet: MarkdownStyleSheet(
                                p: TextStyle(
                                  fontSize: 18.sp,
                                    fontWeight: FontWeight.w300,
                                    color: message.fromUser
                                        ? AppColor.msgUserText
                                        : AppColor.msgBotText),
                                a: TextStyle(color: AppColor.link),
                              ),
                            ),
                          if (message.description != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: SelectableText(
                                      S.of(context).description,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: message.fromUser
                                              ? AppColor.msgUserText
                                              : AppColor.primary),
                                    ),
                                  ),
                                  SelectableText(
                                    message.description!,
                                    style: TextStyle(
                                        color: message.fromUser
                                            ? AppColor.msgUserText
                                            : AppColor.msgBotText),
                                  ),
                                ],
                              ),
                            ),
                          if (message.treatments != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: SelectableText(
                                      S.of(context).treatments,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: message.fromUser
                                              ? AppColor.msgUserText
                                              : AppColor.primary),
                                    ),
                                  ),
                                  SelectableText(
                                    message.treatments!,
                                    style: TextStyle(
                                        color: message.fromUser
                                            ? AppColor.msgUserText
                                            : AppColor.msgBotText),
                                  ),
                                ],
                              ),
                            ),
                          if (message.prevention != null)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: SelectableText(
                                      S.of(context).prevention,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: message.fromUser
                                              ? AppColor.msgUserText
                                              : AppColor.primary),
                                    ),
                                  ),
                                  SelectableText(
                                    message.prevention!,
                                    style: TextStyle(
                                        color: message.fromUser
                                            ? AppColor.msgUserText
                                            : AppColor.msgBotText),
                                  ),
                                ],
                              ),
                            ),
                          if (message.publications != null)
                            Container(
                              width: MediaQuery.of(context).size.width * 1,
                              // padding:
                              // EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppColor.lightGrey,
                                    shadowColor: Colors.white,
                                    elevation: 0),
                                onPressed: () async {
                                  if (await canLaunch(message.publications!)) {
                                    launch(message.publications!);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      S.of(context).read_more,
                                      style:  TextStyle(color: AppColor.primary,
                                          fontSize: 15.sp,fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 12.w,),
                                    Container(
                                      height: 16.h,
                                      width: 16.h,
                                      child: SvgPicture.asset(
                                          "assets/images/link.svg",
                                          height: 16.h
                                        // semanticsLabel: 'Acme Logo'
                                      ),
                                    ),
                                  ],
                                )
                              ),
                            ),
                            // GestureDetector(
                            //     onTap: () async {
                            //       if (await canLaunch(message.publications!)) {
                            //         launch(message.publications!);
                            //       }
                            //     },
                            //     child: Text(
                            //       S.of(context).read_more,
                            //       style: const TextStyle(color: AppColor.link),
                            //     )),

                        ]),
                    padding: EdgeInsets.fromLTRB(24.w, 16.sp, 24.sp, 12.sp),
                    constraints: boxConstraints,
                    decoration: BoxDecoration(
                        color: message.fromUser
                            ? AppColor.msgUserBackground
                            : AppColor.msgBotBackground,
                        borderRadius: !message.fromUser
                            ? BorderRadius.only(
                                topRight: Radius.circular(24.sp),
                                topLeft: Radius.circular(24.sp),
                                bottomRight: Radius.circular(24.sp),
                              )
                            : BorderRadius.only(
                                topRight: Radius.circular(24.sp),
                                topLeft: Radius.circular(24.sp),
                                bottomLeft: Radius.circular(24.sp),
                              )),
                    margin: EdgeInsets.only(
                        left: message.fromUser ? 0.0 : 24.w,
                        bottom: 24.h,
                        right: 24.w)),

              ],
            )
          ]);
    }
  }

  String correctDateTime(DateTime d, BuildContext context) {
    List months = S.of(context).months.split(" ");
    return "${months[d.month - 1]} ${d.day},  ${d.hour}:${d.minute}";
  }
}
