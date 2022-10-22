import 'package:academycourse/src/features/auth/presentation/pages/otp.dart';
import 'package:academycourse/src/features/auth/presentation/pages/sign_in.dart';
import 'package:academycourse/src/features/auth/presentation/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../features/auth/presentation/pages/home.dart';

class AppRoute {
  static const String signInRoute = '/';
  static const String signUpRoute = '/signUpRoute';
  static const String otpRoute = '/otpRoute';
  static const String homeRoute = '/homeRoute';
}

class AppGenerateRoute {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch(settings.name){
      case AppRoute.signInRoute:  return MaterialPageRoute(builder: (_) =>   SignInScreen());
      case AppRoute.signUpRoute:  return MaterialPageRoute(builder: (_) =>  SignUpScreen());
      case AppRoute.otpRoute:  return MaterialPageRoute(builder: (_) =>  const OtpScreen());
      case AppRoute.homeRoute:  return MaterialPageRoute(builder: (_) =>  const HomeScreen());
    }

    return null;
  }
}
