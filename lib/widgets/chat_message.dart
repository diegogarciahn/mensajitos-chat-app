import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessage extends StatelessWidget {

  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({
    Key key, 
    @required this.texto, 
    @required this.uid, 
    @required this.animationController
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: animationController, curve: Curves.elasticOut),
        child: Container(
          child: this.uid == '123'
          ? _myMessage()
          : _notMyMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 5,
          left: 50,
          right: 5 
        ),
        padding: EdgeInsets.all(8.0),
        child: Text(this.texto, style: GoogleFonts.poppins(color: Colors.white),),
        decoration: BoxDecoration(
          color: Colors.orange[400],
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }

  Widget _notMyMessage() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          bottom: 5,
          left: 5,
          right: 50 
        ),
        padding: EdgeInsets.all(8.0),
        child: Text(this.texto, style: GoogleFonts.poppins(color: Colors.black54),),
        decoration: BoxDecoration(
          color: Colors.orange[200],
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }

}