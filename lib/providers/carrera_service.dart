import 'package:flutter_proyecto/models/carrera.dart';
import 'package:http/http.dart' as http;

class CarreraService{

  static var urlServicio='http://192.168.1.82/Proyecto.WebAPI/api/CARRERAS';

   static Future<List<Carrera>> getCarreras() async{
    var url = Uri.parse(urlServicio);
    final response = await http.get(url);

    if(response.statusCode == 200)
    {
         List<Carrera> carreras = carreraFromJson(response.body);
         return carreras;
    }
    return null;
  }

}