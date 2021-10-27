import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:mensajitos/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:mensajitos/models/usuario_model.dart';


class UsuariosPage extends StatefulWidget {

  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  
  final usuarios = [
    Usuario(uid: '1', nombre: 'Lizbeth', email: 'test1@test.com', online: true),
    Usuario(uid: '2', nombre: 'Lucas', email: 'test2@test.com', online: true),
    Usuario(uid: '3', nombre: 'Erick', email: 'test3@test.com', online: true),
    Usuario(uid: '4', nombre: 'Daniela', email: 'test4@test.com', online: false),
    Usuario(uid: '5', nombre: 'Isaac', email: 'test5@test.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context, listen: false);
    final usuario = authService.usuario;

    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.nombre, style: GoogleFonts.montserrat(fontSize: 20)),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app), onPressed: (){
            Navigator.pushReplacementNamed(context, 'login');
            AuthService.deleteToken();
          }
          ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue[400],),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete: Icon(Icons.check, color: Colors.orange[400],),
          waterDropColor: Colors.orange,
        ),
        child: _listViewUsuarios(),
      )
   );
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      separatorBuilder: (_, i) => Divider(), 
      itemCount: usuarios.length,
      itemBuilder: (_, i) => _usuarioListTile(usuarios[i]), 
      );
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      onTap: (){
        Navigator.pushNamed(context, 'chat');
      },
        title: Text(usuario.nombre),
        leading: CircleAvatar(
          backgroundColor: Colors.orange[600],
          child: Text(usuario.nombre.substring(0,2), style: GoogleFonts.lato(color: Colors.white,)),
          ),
        trailing: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(100)
          ),
        ),  
      );
  }

  _cargarUsuarios() async{

    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();

  }
}