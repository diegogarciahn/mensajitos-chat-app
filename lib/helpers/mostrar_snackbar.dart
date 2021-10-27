import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

void showSnackBar(String titulo, String subtitulo, Color color, BuildContext context) {
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