import 'package:flutter/material.dart';

class BotonNaranja extends StatelessWidget {

  final Function onPressed;
  final String texto;

  const BotonNaranja({Key key, this.onPressed, this.texto}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        elevation: 2,
        highlightElevation: 5,
        color: Colors.orange,
        shape: StadiumBorder(),
        onPressed: onPressed,
        child: Container(
          height: 50,
          width: double.infinity,
          child: Center(
            child: Text(
              texto,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
