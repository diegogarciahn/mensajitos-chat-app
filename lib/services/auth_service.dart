import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:mensajitos/global/environment.dart';
import 'package:mensajitos/models/login_respone.dart';
import 'package:mensajitos/models/usuario_model.dart';

class AuthService with ChangeNotifier {

  Usuario usuario;
  bool _autenticando = false;

  // Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  // GETTERS DEL TOKEN DE FORMA ESTATICA
  static Future<String> getToken() async{
    // Create storage
    final _storage = new FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async{
    // Create storage
    final _storage = new FlutterSecureStorage();
    await _storage.delete(key: 'token');

  }

  Future<bool> login(String email, String password) async{

    this.autenticando = true;

    final data = {
      'email' : email,
      'password' : password
    };

    final uri = Uri.parse('${Environment.apiUrl}/login');

    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print(resp.body);
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);
      
      return true;
    } else {
      return false;
    }


  }

  Future register(String nombre, String email, String password) async{

    this.autenticando = true;

    final data = {
      'nombre' : nombre,
      'email' : email,
      'password' : password
    };

    final uri = Uri.parse('${Environment.apiUrl}/login/new');

    final resp = await http.post(uri,
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    print(resp.body);
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      await this._guardarToken(loginResponse.token);
      
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }

  }

  Future<bool> isLoggedIn() async{
    final token = await this._storage.read(key: 'token');

    final uri = Uri.parse('${Environment.apiUrl}/login/renew');


    final resp = await http.get(uri,
      headers: {
        'Content-Type': 'application/json',
        'x-token' : token
      });

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
      await this._guardarToken(loginResponse.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }

  Future _guardarToken(String token) async{
    return await _storage.write(key: 'token', value: token);
  }

  Future logout() async{
    // Delete value 
    await _storage.delete(key: 'token');
  }
}