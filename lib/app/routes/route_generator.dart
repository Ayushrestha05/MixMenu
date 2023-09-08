import 'package:flutter/material.dart';
import 'package:mixmenu/app/routes/export_routes.dart';
import 'package:mixmenu/app/routes/route_names.dart';

class RouteGenerator {
  RouteGenerator._();

  static Route<dynamic>? generateRoute(RouteSettings settings){
    Object? arguments = settings.arguments;

    switch(settings.name){
      case Routes.mainScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => MainScreen());

      default:
        return MaterialPageRoute(
            settings: settings, builder: (_) => MainScreen());
    }
  }
}