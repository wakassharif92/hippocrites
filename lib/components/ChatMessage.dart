import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:hmd_chatbot/generated/l10n.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/models/Message.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatMessage extends StatefulWidget {
  var selectedOptions;

  ChatMessage(this.message, this.selectedOptions);

  final Message message;

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  final CarouselController _sliderController = CarouselController();
  int currentSliderIndex = 0;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * 0.85;
    var boxConstraints = BoxConstraints(maxWidth: width, minWidth: 0.0);
    var maxCharLenOfSingleSlide = 0.0;
    var textMessage = [];
    if (widget.message.text != null &&
        widget.message.text.toString().contains('\$\$\$')) {
      textMessage = widget.message.text!.split("\$\$\$");
      int indexOfMaxLineSlide = 0;
      int i = 0;
      for (var element in textMessage) {
        if (element.length > maxCharLenOfSingleSlide) {
          maxCharLenOfSingleSlide = double.parse(element.length.toString());
          indexOfMaxLineSlide = i;
        }
        i++;
      }
      final span = TextSpan(
          text: textMessage[indexOfMaxLineSlide], style: const TextStyle());
      final tp = TextPainter(text: span);
      tp.textDirection = TextDirection.ltr;
      tp.layout(
        maxWidth: 300.w,
      );

      final numLines = tp.computeLineMetrics().length;

      maxCharLenOfSingleSlide = double.parse(numLines.toString());
      // maxCharLenOfSingleSlide = maxCharLenOfSingleSlide / 25;
    } else {
      textMessage.add(widget.message.text.toString());
    }

    if (widget.message.type == Message.SEPARATOR_TYPE) {
      return Container(
        width: double.maxFinite,
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
                    correctDateTime(widget.message.dateTime, context)
                        .substring(0, 3)
                        .toUpperCase(),
                    style: TextStyle(
                        color: AppColor.darkPurple,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    correctDateTime(widget.message.dateTime, context)
                        .substring(
                            4,
                            correctDateTime(widget.message.dateTime, context)
                                .length)
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
    } else {
      return textMessage.length > 1
          ? // if $$$ found show carasold
          Container(
              padding: EdgeInsets.only(
                  right:
                      currentSliderIndex == textMessage.length - 1 ? 8.w : 0),
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: _sliderController,
                    options: CarouselOptions(
                        initialPage: 0,
                        height: maxCharLenOfSingleSlide * 22.h,
                        enableInfiniteScroll: false,
                        // disableCenter: true,
                        padEnds: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            currentSliderIndex = index;
                          });
                        }),
                    items: textMessage.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: EdgeInsets.only(left: 8.w),
                            padding:
                                EdgeInsets.fromLTRB(40.w, 40.h, 40.w, 0.sp),
                            constraints: boxConstraints,
                            decoration: BoxDecoration(
                                color: AppColor.msgBotBackground,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(24.sp),
                                  topLeft: Radius.circular(24.sp),
                                  bottomRight: Radius.circular(24.sp),
                                  bottomLeft: Radius.circular(24.sp),
                                )),
                            // margin: EdgeInsets.only(
                            //     left: //message.fromUser ? 0.0 :
                            //     24.w,
                            //     bottom: 24.h,
                            //     right: 24.w),
                            child: Markdown(
                              onTapLink: (text, link, _) async {
                                if (await canLaunch(link ?? "")) {
                                  launch(link ?? "");
                                }
                              },
                              data: i.toString(),
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              selectable: true,
                              styleSheet: MarkdownStyleSheet(
                                p: TextStyle(
                                    // fontSize: 18.sp,
                                    // fontWeight: FontWeight.w300,
                                    color: widget.message.fromUser
                                        ? AppColor.msgUserText
                                        : AppColor.msgBotText),
                                a: TextStyle(color: AppColor.link),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: textMessage.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              _sliderController.animateToPage(entry.key),
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 4.h,
                                  backgroundColor:
                                      entry.key == currentSliderIndex
                                          ? Colors.white
                                          : AppColor.primary.withOpacity(0.2),
                                ),
                                Positioned.fill(
                                  child: Align(
                                    child: CircleAvatar(
                                        radius: 3.h,
                                        backgroundColor:
                                            entry.key == currentSliderIndex
                                                ? AppColor.primary
                                                : AppColor.primary
                                                    .withOpacity(0.2)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            )
          : Align(
              alignment: (widget.message.fromUser
                  ? Alignment.topRight
                  : Alignment.topLeft),
              child: Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (widget.message.title != null)
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
                                      widget.message.title!.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          color: widget.message.fromUser
                                              ? AppColor.msgUserText
                                              : AppColor.msgBotText),
                                    ),
                                  ),
                                ),
                                if (widget.message.probability != null)
                                  Column(
                                    // mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        (widget.message.probability! < 50
                                                ? S.of(context).low
                                                : widget.message.probability! <
                                                        75
                                                    ? S.of(context).medium
                                                    : S.of(context).high) +
                                            " " +
                                            S.of(context).probability,
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                widget.message.probability! < 50
                                                    ? AppColor.redText
                                                    : Colors.black),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(top: 4.h),
                                        width: 91.w,
                                        height: 2.h,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          child: LinearProgressIndicator(
                                            backgroundColor: AppColor.primary
                                                .withOpacity(0.5),
                                            color:
                                                widget.message.probability! < 50
                                                    ? AppColor.redText
                                                    : AppColor.primary,
                                            value: widget.message.probability! /
                                                100,
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
                        if (widget.message.text != null &&
                            !(widget.message.fromUser))
                          Markdown(
                            onTapLink: (text, link, _) async {
                              if (await canLaunch(link ?? "")) {
                                launch(link ?? "");
                              }
                            },
                            data: textMessage[0],
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            selectable: true,
                            styleSheet: MarkdownStyleSheet(
                              p: TextStyle(
                                  // fontSize: 16.sp,
                                  // fontWeight: FontWeight.w300,
                                  color: widget.message.fromUser
                                      ? AppColor.msgUserText
                                      : AppColor.msgBotText),
                              a: TextStyle(color: AppColor.link),
                            ),
                          )
                        else // message of user
                          Text(
                            textMessage[0],
                            textAlign: TextAlign.left,
                            style: TextStyle(

                                // fontSize: 16.sp,
                                // fontWeight: FontWeight.w300,
                                color: AppColor.msgUserText),
                          ),
                        if (widget.message.description != null)
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
                                        color: widget.message.fromUser
                                            ? AppColor.msgUserText
                                            : AppColor.primary),
                                  ),
                                ),
                                SelectableText(
                                  widget.message.description!,
                                  style: TextStyle(
                                      color: widget.message.fromUser
                                          ? AppColor.msgUserText
                                          : AppColor.msgBotText),
                                ),
                              ],
                            ),
                          ),
                        if (widget.message.treatments != null)
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
                                        color: widget.message.fromUser
                                            ? AppColor.msgUserText
                                            : AppColor.primary),
                                  ),
                                ),
                                SelectableText(
                                  widget.message.treatments!,
                                  style: TextStyle(
                                      color: widget.message.fromUser
                                          ? AppColor.msgUserText
                                          : AppColor.msgBotText),
                                ),
                              ],
                            ),
                          ),
                        if (widget.message.prevention != null)
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
                                        color: widget.message.fromUser
                                            ? AppColor.msgUserText
                                            : AppColor.primary),
                                  ),
                                ),
                                SelectableText(
                                  widget.message.prevention!,
                                  style: TextStyle(
                                      color: widget.message.fromUser
                                          ? AppColor.msgUserText
                                          : AppColor.msgBotText),
                                ),
                              ],
                            ),
                          ),
                        if (widget.message.publications != null)
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
                                  if (await canLaunch(
                                      widget.message.publications!)) {
                                    launch(widget.message.publications!);
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      S.of(context).read_more,
                                      style: TextStyle(
                                          color: AppColor.primary,
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
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
                                )),
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
                      color: widget.message.fromUser
                          ? AppColor.msgUserBackground
                          : AppColor.msgBotBackground,
                      borderRadius: !widget.message.fromUser
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
                      left: //message.fromUser ? 0.0 :
                          24.w,
                      bottom: 24.h,
                      right: 24.w)),
            );
      // Row(
      //   mainAxisAlignment: message.fromUser
      //       ? MainAxisAlignment.spaceBetween
      //       : MainAxisAlignment.start,
      //   children: <Widget>[
      //     Container(),
      //     Column(
      //       crossAxisAlignment:CrossAxisAlignment.start,
      //       children: [
      //
      //
      //       ],
      //     )
      //   ]);
    }
  }

  String correctDateTime(DateTime d, BuildContext context) {
    List months = S.of(context).months.split(" ");
    return "${months[d.month - 1]} ${d.day},  ${d.hour}:${d.minute}";
  }
}
