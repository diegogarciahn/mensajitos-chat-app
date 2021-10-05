import 'package:flutter/material.dart';
import 'package:mensajitos/widgets/custom_input.dart';

class FormCustom extends StatefulWidget {
  @override
  _FormCustomState createState() => _FormCustomState();
}

class _FormCustomState extends State<FormCustom> {

  final emailCtrol = TextEditingController();
  final passCtrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          MaterialButton(
            child: Text('Ingresar',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),),
            color: Colors.orange,
            onPressed: () {
            print(emailCtrol.text);
            print(passCtrol.text);
          })
          ],
      ),
    );
  }
}
