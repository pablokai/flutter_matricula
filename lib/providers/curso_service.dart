import 'package:http/http.dart' as http;
import 'package:flutter_proyecto/models/curso.dart';

class CursoService{

  static var urlServicio='http://192.168.1.82/Proyecto.WebAPI/CARRERA?carrera=';  //se obtienen cursos por idcarrera

   static Future<List<Curso>> getCursos(String idcarrera) async{
    var u = urlServicio + idcarrera;
    var url = Uri.parse(u);
    final response = await http.get(url);

    if(response.statusCode == 200)
    {
         List<Curso> cursos = cursoFromJson(response.body);
         return cursos;
    }
    return null;
  }

}