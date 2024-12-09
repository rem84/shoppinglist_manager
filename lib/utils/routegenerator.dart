import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppinglist_manager/utils/constant.dart';
import 'package:shoppinglist_manager/screens/shoppinglistscreen.dart';


class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case listarticleRoute:
        return CupertinoPageRoute(
          builder: (_) => const Shoppinglistscreen(),//ListArticleScreen();
        );
      case homeRoute:
        return CupertinoPageRoute(
          builder: (_) => const Shoppinglistscreen(),
        );      
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Error',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          body: const Center(
            child: Text('No Routes Found'),
          ),
        );
      },
    );
  }
}