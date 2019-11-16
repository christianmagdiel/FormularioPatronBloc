
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:formvalidation/src/models/producto_model.dart';

class ProductosProvider {
  
  final String _url = 'https://flutter-aba02.firebaseio.com';

  Future<bool> crearProducto(ProductoModel producto) async{
    final url = '$_url/productos.json';

   final resp = await http.post(url, body: productoModelToJson(producto));

   final decodeData = json.decode(resp.body);

   print(decodeData);

   return true;
  }

}