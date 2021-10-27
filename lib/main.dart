import 'package:flutter/material.dart';
import 'package:mensajitos/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:mensajitos/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService(),)
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.orange,
          errorColor: Colors.red[400]
        ),
        debugShowCheckedModeBanner: false,
        title: 'Mensajitos',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}