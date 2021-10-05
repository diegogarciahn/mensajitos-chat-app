import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatelessWidget {

  final IconData icono;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType tipoTeclado;
  final bool isPassword;

  const CustomInput({
    Key key, 
    @required this.icono, 
    @required this.placeholder, 
    @required this.textController, 
    this.tipoTeclado = TextInputType.text, 
    this.isPassword = false
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
            padding: EdgeInsets.only(right: 20, top: 5, left: 5, bottom: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: Offset(0,5),
                    blurRadius: 5
                  )
              ]
            ),
            child: TextField(
              obscureText: (isPassword)?true:false,
              controller: textController,
              autocorrect: false,
              keyboardType: tipoTeclado,
              // obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(icono),
                focusedBorder: InputBorder.none,
                border: InputBorder.none,
                hintText: placeholder
              ),
            ),
          );
  }
}