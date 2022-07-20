import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hmd_chatbot/pages/Index.dart';
import 'package:hmd_chatbot/services/api/APIFactory.dart';

import 'package:hmd_chatbot/services/storage/StorageFactory.dart';

import 'bloc/AuthCubit.dart';
import 'generated/l10n.dart';
import 'helpers/AppColor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageFactory().getStorage().init();
  await GlobalConfiguration().loadFromAsset("app_settings");
  await APIFactory()
      .getHandler()
      .init(GlobalConfiguration().getString("baseUrl"));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent,));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return ScreenUtilInit(
      // designSize: const Size(375, 667),
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xffFFFFFF),
            textTheme: GoogleFonts.montserratTextTheme(
              Theme.of(context).textTheme.copyWith(
                    headline1: TextStyle(
                        fontSize: 28.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    headline2: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                    headline3: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    headline4: TextStyle(
                        fontSize: 21.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                    headline5: TextStyle(
                        fontSize: 8.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    headline6: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                    subtitle1: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                    subtitle2: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                    bodyText1: TextStyle(),
                    bodyText2: TextStyle(),
                  ), // If this is not set, then ThemeData.light().textTheme is used.
            ),
            inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: AppColor.inputBg,
                errorStyle: TextStyle(
                  color: AppColor.error,
                ),
                contentPadding:
                    EdgeInsets.only(left: 28.w, top: 26.h, bottom: 23.h),
                labelStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColor.inputBorder, width: 1.0),
                    borderRadius: BorderRadius.circular(
                      10.sp,
                    )),
                disabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: AppColor.inputBorder, width: 1.0),
                    borderRadius: BorderRadius.circular(
                      10.sp,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColor.primary, width: 1.0),
                    borderRadius: BorderRadius.circular(
                      10.sp,
                    )),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColor.error, width: 1.0),
                    borderRadius: BorderRadius.circular(
                      10.sp,
                    )),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: AppColor.error, width: 1.0),
                    borderRadius: BorderRadius.circular(
                      10.sp,
                    )),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                  10.sp,
                ))),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: 21.h,
                ),
                textStyle: GoogleFonts.montserrat(
                    fontSize: 15.sp, fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.sp),
                ),
              ),
            ),
            colorScheme: const ColorScheme.light(
              primary: AppColor.primary,
            )),
        home: BlocProvider(
          create: (BuildContext context) => AuthCubit(
              storageFactory: StorageFactory(), apiFactory: APIFactory()),
          child: const Index(),
        ),
      ),
    );
  }
}
