import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mensajitos/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();

  List<ChatMessage> _messages = [
    // ChatMessage(texto: 'Hola Mundo', uid: '123',),
    // ChatMessage(texto: 'Hola Mundo sasjhKASJHka jshKAJSHkaj shKAJSHKajshkAJS HKajshkAJSH KajshkAJS', uid: '123',),
    // ChatMessage(texto: 'Hola Mundo', uid: '1253',),
    // ChatMessage(texto: 'Hola Mundo sasjhKASJHka jshKAJSHkaj shKAJSHKajshkAJS HKajshkAJSH KajshkAJS', uid: '1223',),
    // ChatMessage(texto: 'Hola Mundo', uid: '123',)

  ];

  bool _estaEscribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'TE',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              backgroundColor: Colors.orange[400],
              maxRadius: 14,
            ),
            SizedBox(
              height: 3,
            ),
            Text('Lizbeth Pineda', style: GoogleFonts.poppins(color: Colors.black87),)
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_, i) => _messages[i],
                reverse: true,
                )
              ),
              Divider(height: 1,),
              Container(
                color: Colors.white,
                child: _inputChat(),
              )
          ],
        ),
      )
    );

  }

  Widget _inputChat() {
      
      return SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [

              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmit,
                  onChanged: (texto){
                    setState(() {
                      if(texto.trim().length > 0) {
                        _estaEscribiendo = true;
                      } else {
                        _estaEscribiendo = false;
                      }
                    });
                  },
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enviar mensaje'
                    ),
                    focusNode: _focusNode,
                )
                ),
                //BOTÓN DE ENVIAR
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: (Platform.isIOS)
                  ?CupertinoButton(
                    disabledColor: Colors.grey,
                    child: Text('Enviar',), 
                    onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text)
                        :null,
                    )
                  :Container(
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    child: IconTheme(
                      data: IconThemeData( color: Colors.orange ),
                      child: IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.send),
                        onPressed: _estaEscribiendo
                        ? () => _handleSubmit(_textController.text)
                        :null,
                      ),
                    ),
                  )  
                )

            ],
          ),
        )
        );
    }

    _handleSubmit(String texto) {

      if ( texto.length == 0 ) return;
      print(texto);
      _textController.clear();
      _focusNode.requestFocus();

      final newMessage = new ChatMessage(
        uid: '123', 
        texto: texto,
        animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 400)),
        );
      _messages.insert(0, newMessage);
      newMessage.animationController.forward();

      setState(() {
              _estaEscribiendo = false;
            });
    }

    @override
    void dispose() {
      //TODO: CANCELAR LA ESCUCHA DEL SOCKET
      for (ChatMessage message in _messages) {
        message.animationController.dispose();
      }
      super.dispose();
    }
}
