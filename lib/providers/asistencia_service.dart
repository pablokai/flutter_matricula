import 'dart:convert';

import 'package:flutter_proyecto/models/asistencia.dart';
import 'package:http/http.dart' as http;

class AsistenciaService{

  static var urlServicio='http://192.168.1.82/Proyecto.WebAPI/api/ASISTENCIAS';

   static Future<bool> postAsistencia(Asistencia asistencia) async{   
    var url = Uri.parse(urlServicio);

    asistencia.toJson();
    final response = await http.post(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(asistencia.toJson())
    );

    if(response.statusCode == 201)
    {       
         return true;
    }
    return false;
  }

}
