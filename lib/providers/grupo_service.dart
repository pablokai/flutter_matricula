import 'package:flutter_proyecto/models/grupo.dart';
import 'package:http/http.dart' as http;

class GrupoService{

  static var urlServicio='http://192.168.1.82/Proyecto.WebAPI/CURSO?id='; 
  static var urlServicioID = 'http://192.168.1.82/Proyecto.WebAPI/ESTUDIANTEMATRICULA?id='; //se obtienen grupos por idcurso

   static Future<List<Grupo>> getGrupos(String idcurso) async{
    var u = urlServicio + idcurso;
    var url = Uri.parse(u);
    final response = await http.get(url);

    if(response.statusCode == 200)
    {
         List<Grupo> grupos = grupoFromJson(response.body); 
         return grupos;
    }
    return null;
  }

     static Future<List<Grupo>> getGruposID(String id) async{
    var u = urlServicioID + id;
    var url = Uri.parse(u);
    final response = await http.get(url);

    if(response.statusCode == 200)
    {
         List<Grupo> grupos = grupoFromJson(response.body); 
         return grupos;
    }
    return null;
  }

}