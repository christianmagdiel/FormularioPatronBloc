import 'dart:convert';

import 'package:formvalidation/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class UsuarioProvider{

  final String _firebaseKey = 'AIzaSyCuMGrUU-S0lli0QE_BIRdGHFLx2tXeQNU';
  final _prefs = new PreferenciasUsuario();

  Future<Map<String,dynamic>> login(String email, String password) async{
    final authData = {
      'email'   :email,
      'password': password,
      'returnSecureToken' : true
    };
    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$_firebaseKey',
      body: json.encode( authData )
    );

    Map<String, dynamic> decodedResp = json.decode( resp.body );

    print(decodedResp);

    if ( decodedResp.containsKey('idToken') ) {
      
      _prefs.token = decodedResp['idToken'];

      return { 'ok': true, 'token': decodedResp['idToken'] };
    } else {
      return { 'ok': false, 'mensaje': decodedResp['error']['message'] };
    }
  }


  Future<Map<String,dynamic>> nuevoUsuario(String email, String password) async{
    final authData = {
      'email'   :email,
      'password': password,
      'returnSecureToken' : true
    };
    final resp = await http.post(
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$_firebaseKey',
      body: json.encode( authData )
    );

    Map<String,dynamic> decodedResp = json.decode(resp.body);

    print(decodedResp);

    if (decodedResp.containsKey('idToken')){
      //Guardar Token
      _prefs.token = decodedResp['idToken'];
      return {'Ok':true,'token':decodedResp['idToken']};
    }else{
      return {'Ok':false,'mensaje':decodedResp['error']['message']};
    }
  }

}