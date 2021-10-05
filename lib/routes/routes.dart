import 'package:flutter/cupertino.dart';
import 'package:mensajitos/pages/chat_page.dart';
import 'package:mensajitos/pages/loading_page.dart';
import 'package:mensajitos/pages/login_page.dart';
import 'package:mensajitos/pages/registe_page.dart';
import 'package:mensajitos/pages/usuarios_page.dart';

final Map<String, Widget Function(BuildContext)>appRoutes = {

  'usuarios' : (_) => UsuariosPage(),
  'chat' : (_) => ChatPage(),
  'login' : (_) => LoginPage(),
  'register' : (_) => RegisterPage(),
  'loading' : (_) => LoadingPage(),
  
};