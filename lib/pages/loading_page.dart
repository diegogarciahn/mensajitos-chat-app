import 'package:flutter/material.dart';
import 'package:mensajitos/pages/login_page.dart';
import 'package:mensajitos/pages/usuarios_page.dart';
import 'package:mensajitos/services/auth_service.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (
          context, 
          snapshot) {
          
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.orange,
            ),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async{
    final authService = Provider.of<AuthService>(context, listen: false);

    final autenticado = await authService.isLoggedIn();

    if (autenticado) {
      // Navigator.pushReplacementNamed(context, 'usuarios');
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => UsuariosPage(),
          transitionDuration: Duration(milliseconds: 0),
        )
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0),
        )
      );
    } 
  }
}
