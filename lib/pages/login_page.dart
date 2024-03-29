import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:mensajitos/services/auth_service.dart';

import 'package:mensajitos/helpers/mostrar_snackbar.dart';

import 'package:mensajitos/widgets/btn_orange.dart';
import 'package:mensajitos/widgets/custom_input.dart';
import 'package:mensajitos/widgets/custom_logo.dart';
import 'package:mensajitos/widgets/labels.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: size.height * 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(
                    titulo: 'Mensajitos',
                    subtitulo: 'La app de mensajería más macanuda xdxd',
                  ),
                  _FormCustom(),
                  Labels(
                    texto2: '¿No tienes cuenta?',
                    texto1: 'Registrate',
                    onPressed: (){
                      Navigator.pushReplacementNamed(context, 'register');
                    },
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          recognizer: new TapGestureRecognizer()..onTap = () => print('¡Estoy aquí!'),
                          text: 'Revisa aquí',
                          style: GoogleFonts.poppins(
                            color: Colors.black38,
                            fontWeight: FontWeight.w700
                          )
                        ),
                        TextSpan(
                          text: ' los terminos y condiciones',
                          style: GoogleFonts.poppins(
                            color: Colors.black38
                          )
                        ),
                      ]
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
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
  final emailCtrol = TextEditingController();
  final passCtrol = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);

    return Container(
      margin: EdgeInsets.only(top: 41),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
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
          Provider.of<AuthService>(context).autenticando 
          ?LinearProgressIndicator(
            backgroundColor: Colors.orange,
          )
          :BotonNaranja(
            onPressed: () async{
              if(emailCtrol.text.isNotEmpty && passCtrol.text.isNotEmpty) {

                FocusScope.of(context).unfocus();

                final loginOk = await authService.login(emailCtrol.text.trim(), passCtrol.text.trim());

                if (loginOk) {
                  Navigator.pushReplacementNamed(context, 'usuarios');
                } else {
                  showSnackBar(
                        'Datos incorrectos:',
                        ' por favor revise bien sus credenciales.',
                        Colors.red[400],
                        context);
                }
              } else {
                showSnackBar('Datos incompletos:', ' por favor complete todos los campos.', Colors.red[400], context);
              }
            },
            texto: 'Acceder',
          )
        ],
      ),
    );
  }
}
