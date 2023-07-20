

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/details_screen.dart';
import 'package:mvvm/view/home_screen.dart';
import 'package:mvvm/view/login_view.dart';
import 'package:mvvm/view/navigation.dart';
import 'package:mvvm/view/search_screen.dart';
import 'package:mvvm/view/signp_view.dart';
import 'package:mvvm/view/splash_view.dart';

import '../../view/calling_demo.dart';

class Routes {

  static Route<dynamic>  generateRoute(RouteSettings settings){

    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginView());

      case RoutesName.navigation:
        return MaterialPageRoute(builder: (BuildContext context) =>  Home());

      case RoutesName.search:
        return MaterialPageRoute(builder: (BuildContext context) => const SearchScreen());

      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => const SignUpView());


      case RoutesName.calling:
        return MaterialPageRoute(builder: (BuildContext context) => const MyApp());

      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });

    }
  }
}