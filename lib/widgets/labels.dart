import 'package:flutter/material.dart';

class Labels extends StatelessWidget {

  final Function onPressed;
  final String texto1;
  final String texto2;

  const Labels({Key key, this.onPressed, this.texto1, this.texto2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            texto2,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: onPressed,
            child: Text(
              texto1, 
              style: TextStyle(
                color: Colors.blue[600], 
                fontSize: 18, 
                fontWeight: 
                FontWeight.bold),),
          )
        ],
      ),
    );
  }
}