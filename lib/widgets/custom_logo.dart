import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {

  final String titulo;
  final String subtitulo;

  const Logo({Key key, this.titulo, this.subtitulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Container(
        width: 170,
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image(image: AssetImage('assets/logo.png')),
            SizedBox(
              height: 20,
            ),
            Text(
              titulo,
              style: GoogleFonts.poppins(
                color: Colors.orange,
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              subtitulo,
              style: GoogleFonts.poppins(
                color: Colors.black54,
                fontSize: 13,
                fontWeight: FontWeight.w200
              ),
            ),
          ],
        ),
      ),
    );
  }
}

