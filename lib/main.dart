import 'package:flutter/material.dart';
import 'package:shoppinglist_manager/screens/shoppinglistscreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const ShoppinglistManager());
}

class ShoppinglistManager extends StatelessWidget {
  const ShoppinglistManager({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
       supportedLocales: [
         Locale('fr')
       ],
      //onGenerateRoute: RouteGenerator.generateRoute,
      //initialRoute: homeRoute,
      debugShowCheckedModeBanner: false,
      home: Shoppinglistscreen(),
    );
  }
}
