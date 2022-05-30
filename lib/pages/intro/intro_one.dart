import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hmd_chatbot/helpers/AppColor.dart';
import 'package:hmd_chatbot/helpers/UiHelpers.dart';

class IntroOne extends StatefulWidget {
  VoidCallback callback;

  IntroOne(this.callback);

  @override
  State<IntroOne> createState() => _IntroOneState();
}

class _IntroOneState extends State<IntroOne> {
  int index = 0;
  int currentSliderIndex = 0;
  final CarouselController _sliderController = CarouselController();

  bool showMore1 = false;
  bool showMore2 = true;

  ScrollController _scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/images/intro_bg.png"))),
        child: Stack(
          children: [
            Container(
              height: 500.h,
              // color: Colors.yellow,
              child: ListView(
                controller: _scrollController,
                shrinkWrap: true,
                // reverse: true,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 65.w),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      children: <Widget>[
                        chatMessage("Hello!", "R"),
                        chatMessage("Can i help you?", "R"),
                        chatMessage("Hi, i have a headache!", "S"),
                      ],
                    ),
                  ),
                  if (index > 0)
                    Column(
                      children: [
                        Container(
                            child: CarouselSlider(
                          carouselController: _sliderController,
                          options: CarouselOptions(
                              initialPage: 0,
                              height: 170.h,
                              enableInfiniteScroll: false,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentSliderIndex = index;
                                });
                              }),
                          items: [1, 2, 3].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return secondIntroScreen();
                              },
                            );
                          }).toList(),
                        )),
                        Padding(
                          padding: EdgeInsets.only(top: 24.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [0, 1, 2].asMap().entries.map((entry) {
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
                                                : AppColor.primary,
                                      ),
                                      Positioned.fill(
                                        child: Align(
                                          child: CircleAvatar(
                                              radius: 3.h,
                                              backgroundColor: entry.key ==
                                                      currentSliderIndex
                                                  ? AppColor.primary
                                                  : Colors.white),
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
                  if (index > 1)
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        thirdIntroScreenTab1(),
                        thirdIntroScreenTab2(),
                      ],
                    )
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60.h, left: 16.w),
                  child: Row(
                    children: [
                      Container(
                        width: 113.w,
                        height: 4.h,
                        decoration: BoxDecoration(color: Colors.white),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        width: 113.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                            color: index >= 1
                                ? Colors.white
                                : Colors.white.withOpacity(0.32)),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      Container(
                        width: 113.w,
                        height: 4.h,
                        decoration: BoxDecoration(
                            color: index >= 2
                                ? Colors.white
                                : Colors.white.withOpacity(0.32)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 14.h, // 24, below 10 added
                ),
                GestureDetector(
                  onTap: () {
                    widget.callback();
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 16.w, top: 10.h, right: 16.w),
                    child: Text(
                      "Skip",
                      style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.h,
                ),

                Expanded(child: SizedBox()),
                // SizedBox(
                //   height: 332.h,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 280.w,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (index >= 2) {
                            widget.callback();
                          } else {
                            {
                              setState(() {
                                index++;
                              });
                            }
                          }
                          await Future.delayed(Duration(milliseconds: 300));
                          final position =
                              _scrollController.position.maxScrollExtent;

                          // _scrollController.jumpTo(position);
                          _scrollController.animateTo(
                            position,
                            curve: Curves.easeOut,
                            duration: const Duration(milliseconds: 300),
                          );
                        },
                        child: Text(
                          index == 2 ? "Start the app" : "Next",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60.h,
                ),
              ],
            ),
            Container(
              height: 153,
              width: MediaQuery.of(context).size.width * 1,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                      image: AssetImage(

                "assets/images/shade1.png",
              ))),
            )
          ],
        ),
      ),
    );
  }

  Widget secondIntroScreen() {
    return Container(
      width: 320.w,
      margin: EdgeInsets.only(top: 24.h, left: 10.w),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(24.sp)),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Illness",
            style: TextStyle(
                color: Colors.black,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10.h,
          ),
          Text(
            "This can include infections, colds, and fevers. Headaches are also common with conditions like sinusitis ...",
            style: TextStyle(
                color: AppColor.darkPurple,
                fontSize: 13.sp,
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }

  Widget thirdIntroScreenTab1() {
    return Stack(
      children: [
        Container(
          width: 320.w,
          margin: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24.sp)),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 4.h,
                        backgroundColor: AppColor.redText,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "low probability",
                        style: TextStyle(
                            color: AppColor.redText,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "MIGRAINE HEADACHE",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  if (showMore1)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Treatments",
                          style: TextStyle(
                              color: AppColor.msgSent,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "There are several types of medicines used to treat a peptic ulcer. Your doctor will decide the best treatment based on the cause of your peptic ulcer.",
                          style: TextStyle(
                              color: AppColor.darkPurple,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                ],
              ),
              Positioned(
                right: 0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showMore1 = !showMore1;
                    });
                  },
                  child: Container(
                    height: 32.h,
                    width: 32.h,
                    child: SvgPicture.asset(
                        !showMore1
                            ? "assets/images/add.svg"
                            : "assets/images/minus.svg",
                        height: 24.h
                        // semanticsLabel: 'Acme Logo'
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget thirdIntroScreenTab2() {
    return Stack(
      children: [
        Container(
          width: 320.w,
          margin: EdgeInsets.only(top: 24.h, left: 24.w, right: 24.w),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(24.sp)),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 4.h,
                        backgroundColor: AppColor.redText,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        "low probability",
                        style: TextStyle(
                            color: AppColor.redText,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4.h,
                  ),
                  Text(
                    "MIGRAINE HEADACHE",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  if (showMore2)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Treatments",
                          style: TextStyle(
                              color: AppColor.msgSent,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          "There are several types of medicines used to treat a peptic ulcer. Your doctor will decide the best treatment based on the cause of your peptic ulcer.",
                          style: TextStyle(
                              color: AppColor.darkPurple,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                ],
              ),
              Positioned(
                right: 0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      showMore2 = !showMore2;
                    });
                  },
                  child: Container(
                    height: 32.h,
                    width: 32.h,
                    child: SvgPicture.asset(
                        !showMore2
                            ? "assets/images/add.svg"
                            : "assets/images/minus.svg",
                        height: 24.h
                        // semanticsLabel: 'Acme Logo'
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
