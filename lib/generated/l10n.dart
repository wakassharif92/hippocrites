// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `hmd.care`
  String get app_title {
    return Intl.message(
      'hmd.care',
      name: 'app_title',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Treatments`
  String get treatments {
    return Intl.message(
      'Treatments',
      name: 'treatments',
      desc: '',
      args: [],
    );
  }

  /// `Prevention`
  String get prevention {
    return Intl.message(
      'Prevention',
      name: 'prevention',
      desc: '',
      args: [],
    );
  }

  /// `probability`
  String get probability {
    return Intl.message(
      'probability',
      name: 'probability',
      desc: '',
      args: [],
    );
  }

  /// `low`
  String get low {
    return Intl.message(
      'low',
      name: 'low',
      desc: '',
      args: [],
    );
  }

  /// `high`
  String get high {
    return Intl.message(
      'high',
      name: 'high',
      desc: '',
      args: [],
    );
  }

  /// `medium`
  String get medium {
    return Intl.message(
      'medium',
      name: 'medium',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get read_more {
    return Intl.message(
      'Read more',
      name: 'read_more',
      desc: '',
      args: [],
    );
  }

  /// `Tap to add options`
  String get tap_options {
    return Intl.message(
      'Tap to add options',
      name: 'tap_options',
      desc: '',
      args: [],
    );
  }

  /// `Type your message`
  String get type_message {
    return Intl.message(
      'Type your message',
      name: 'type_message',
      desc: '',
      args: [],
    );
  }

  /// `Thanks for registration!`
  String get thanks_registration {
    return Intl.message(
      'Thanks for registration!',
      name: 'thanks_registration',
      desc: '',
      args: [],
    );
  }

  /// `Please, check your email!!!`
  String get check_email {
    return Intl.message(
      'Please, check your email!!!',
      name: 'check_email',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }
  // String get resetPassword {
  //   return Intl.message(
  //     'Reset Password',
  //     name: 'reset_password',
  //     desc: '',
  //     args: [],
  //   );
  // }

  /// `Forgot password`
  String get forgot_password {
    return Intl.message(
      'Recover Password',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter Valid Email`
  String get enter_valid_email {
    return Intl.message(
      'Enter Valid Email',
      name: 'enter_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your sex`
  String get enter_sex {
    return Intl.message(
      'Enter your sex',
      name: 'enter_sex',
      desc: '',
      args: [],
    );
  }

  /// `sex`
  String get sex {
    return Intl.message(
      'sex',
      name: 'sex',
      desc: '',
      args: [],
    );
  }

  /// `male`
  String get male {
    return Intl.message(
      'male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `female`
  String get female {
    return Intl.message(
      'female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Birthday date`
  String get birthday_date {
    return Intl.message(
      'Birthday date',
      name: 'birthday_date',
      desc: '',
      args: [],
    );
  }

  /// `Enter your birthday date`
  String get enter_birthday_date {
    return Intl.message(
      'Enter your birthday date',
      name: 'enter_birthday_date',
      desc: '',
      args: [],
    );
  }

  /// `Sign up`
  String get sign_up {
    return Intl.message(
      'Sign up',
      name: 'sign_up',
      desc: '',
      args: [],
    );
  }

  /// `You can reset your password`
  String get password_restore {
    return Intl.message(
      'You can reset your password',
      name: 'password_restore',
      desc: '',
      args: [],
    );
  }

  /// `Current password:`
  String get current_password {
    return Intl.message(
      'Current password:',
      name: 'current_password',
      desc: '',
      args: [],
    );
  }

  /// `New password:`
  String get new_password {
    return Intl.message(
      'New password:',
      name: 'new_password',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Enter name`
  String get enter_name {
    return Intl.message(
      'Enter name',
      name: 'enter_name',
      desc: '',
      args: [],
    );
  }

  /// `Search...`
  String get search {
    return Intl.message(
      'Search...',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Start Over`
  String get start_over {
    return Intl.message(
      'Start Over',
      name: 'start_over',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Profile settings`
  String get prof_settings {
    return Intl.message(
      'Profile settings',
      name: 'prof_settings',
      desc: '',
      args: [],
    );
  }

  /// `Password settings`
  String get pass_settings {
    return Intl.message(
      'Password settings',
      name: 'pass_settings',
      desc: '',
      args: [],
    );
  }

  /// `January February March April May June July August September October November December`
  String get months {
    return Intl.message(
      'January February March April May June July August September October November December',
      name: 'months',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
