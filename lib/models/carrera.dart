// To parse this JSON data, do
//
//     final carrera = carreraFromJson(jsonString);

import 'dart:convert';

List<Carrera> carreraFromJson(String str) => List<Carrera>.from(json.decode(str).map((x) => Carrera.fromJson(x)));

String carreraToJson(List<Carrera> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Carrera {
    Carrera({
        this.idCarrera,
        this.nombreCarrera,
        this.siglas,
    });

    int idCarrera;
    String nombreCarrera;
    String siglas;

    factory Carrera.fromJson(Map<String, dynamic> json) => Carrera(
        idCarrera: json["ID_CARRERA"],
        nombreCarrera: json["NOMBRE_CARRERA"],
        siglas: json["SIGLAS"],
    );

    Map<String, dynamic> toJson() => {
        "ID_CARRERA": idCarrera,
        "NOMBRE_CARRERA": nombreCarrera,
        "SIGLAS": siglas,
    };
}
