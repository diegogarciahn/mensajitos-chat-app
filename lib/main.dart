import 'package:flutter/material.dart';
import 'package:mensajitos/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Mensajitos',
      initialRoute: 'login',
      routes: appRoutes,
    );
  }
}