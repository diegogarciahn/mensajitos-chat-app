import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mensajitos/services/auth_service.dart';

import 'package:mensajitos/widgets/btn_orange.dart';
import 'package:mensajitos/widgets/custom_input.dart';
import 'package:mensajitos/widgets/custom_logo.dart';
import 'package:mensajitos/widgets/labels.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(
                  titulo: 'Registro',
                  subtitulo: 'Completa los datos para crear tu cuenta.',
                ),
                _FormCustom(),
                SizedBox(
                  height: 20,
                ),
                Labels(
                  texto2: '¿Ya tienes cuenta?',
                  texto1: 'Inicia sesión',
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () => print('¡Estoy aquí!'),
                        text: 'Revisa aquí',
                        style: GoogleFonts.poppins(
                            color: Colors.black38,
                            fontWeight: FontWeight.w700)),
                    TextSpan(
                        text: ' los terminos y condiciones',
                        style: GoogleFonts.poppins(color: Colors.black38)),
                  ]),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ));
  }
}

class _FormCustom extends StatefulWidget {
  @override
  __FormCustomState createState() => __FormCustomState();
}

class __FormCustomState extends State<_FormCustom> {
  final namCtrol = TextEditingController();
  final emailCtrol = TextEditingController();
  final passCtrol = TextEditingController();
  final pass2Ctrol = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Container(
      margin: EdgeInsets.only(top: 41),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icono: Icons.perm_identity,
            placeholder: 'Nombre',
            tipoTeclado: TextInputType.text,
            textController: namCtrol,
          ),
          CustomInput(
            icono: Icons.mail_outline,
            placeholder: 'Correo electrónico',
            tipoTeclado: TextInputType.emailAddress,
            textController: emailCtrol,
          ),
          CustomInput(
            icono: Icons.lock_outline,
            placeholder: 'Contraseña',
            textController: passCtrol,
            isPassword: true,
          ),
          CustomInput(
            icono: Icons.lock_outline,
            placeholder: 'Repetir contraseña',
            textController: pass2Ctrol,
            isPassword: true,
          ),
          Provider.of<AuthService>(context).autenticando
          ?LinearProgressIndicator(
            backgroundColor: Colors.orange,
          )
          :BotonNaranja(
            onPressed: () async{
              if (namCtrol.text.length != 0 &&
                  emailCtrol.text.length != 0 &&
                  passCtrol.text.length != 0 &&
                  pass2Ctrol.text.length != 0) {
                
                if (!validateMyInput(emailCtrol.text)) {
                  showSnackBar(
                      'Dirección de correo valida:',
                      ' por favor ingrese una dirección de correo valida.',
                      Colors.red[400]);
                } else if (passCtrol.text != pass2Ctrol.text) {
                  showSnackBar(
                      'Los campos de contraseña no coinciden:',
                      ' por favor revisa de nuevo la contraseña',
                      Colors.red[400]);
                } else {
                  print('Todo bien todo correcto');
                  final registroOK = await authService.register(
                      namCtrol.text.trim(), emailCtrol.text.trim(), passCtrol.text.trim());
                  if (registroOK == true) {
                    Navigator.pushReplacementNamed(context, 'usuarios');
                  } else {
                    showSnackBar(
                        'Error al registrar:',
                        ' el correo ya está registrado.',
                        Colors.red[400]);
                  }
                }
              } else {
                showSnackBar(
                    'Datos incompletos:',
                    ' por favor complete todos los campos para crear una cuenta.',
                    Colors.red[400]);
              }
            },
            texto: 'Crear cuenta',
          )
        ],
      ),
    );
  }

  void showSnackBar(String titulo, String subtitulo, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: RichText(
        text: TextSpan(children: [
          TextSpan(
              recognizer: new TapGestureRecognizer()
                ..onTap = () => print('¡Estoy aquí!'),
              text: titulo,
              style: GoogleFonts.poppins(
                  color: Colors.black38, fontWeight: FontWeight.w700)),
          TextSpan(
              text: subtitulo,
              style: GoogleFonts.poppins(color: Colors.black38)),
        ]),
      ),
      backgroundColor: color,
    ));
  }

  bool validateMyInput(String value) {
    Pattern pattern = r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
  }
}
