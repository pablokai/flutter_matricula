import 'dart:convert';

import 'package:flutter_proyecto/models/matricula.dart';
import 'package:http/http.dart' as http;


class MatriculaService{

  static var url='';

   static var urlServicio='http://192.168.1.82/Proyecto.WebAPI/api/MATRICULAS';

   static Future<bool> postMatricula(Matricula matricula) async{   
    var url = Uri.parse(urlServicio);

    final response = await http.post(url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(matricula.toJson())
    );

    if(response.statusCode == 201)
    {       
         return true;
    }
    return false;
  }

}