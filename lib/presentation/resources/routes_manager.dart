import 'package:clean_architecture/presentation/forget_password/forget_password_view.dart';
import 'package:clean_architecture/presentation/login/login_view.dart';
import 'package:clean_architecture/presentation/main/main_view.dart';
import 'package:clean_architecture/presentation/onboarding/onboarding_view.dart';
import 'package:clean_architecture/presentation/register/register_view.dart';
import 'package:clean_architecture/presentation/store_details/store_details_view.dart';
import 'package:flutter/material.dart';

import '../splash/splash_view.dart';

class Routes{
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onBoarding";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String forgetPasswordRoute = "/forgetPassword";
  static const String mainRoute = "/main";
  static const String storeDetailsRoute = "/storeDetails";
}

class RouteGenerator{
  static Route<dynamic> getRoute(RouteSettings routeSettings){
    switch (routeSettings.name){
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_)=> const SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_)=> const LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_)=> const OnBoardingView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_)=> const RegisterView());
      case Routes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_)=> const ForgetPasswordView());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_)=> const MainView());
      case Routes.storeDetailsRoute:
        return MaterialPageRoute(builder: (_)=> const StoreDetailsView());
      default:
        return unDefinedRoute();
    }
  }
static Route<dynamic>unDefinedRoute(){
   return MaterialPageRoute(builder: (_)=>
   Scaffold(
     appBar: AppBar(
       title: const Text("No Route Found"),
     ),
     body: const Text("No Route Found!"),
   )
   ) ;
}
}

