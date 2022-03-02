import 'dart:convert';

List<Curso> cursoFromJson(String str) => List<Curso>.from(json.decode(str).map((x) => Curso.fromJson(x)));

String cursoToJson(List<Curso> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Curso {
    Curso({
        this.idCurso,
        this.nombreCurso,
        this.idCarrera,
    });

    String idCurso;
    String nombreCurso;
    int idCarrera;

    factory Curso.fromJson(Map<String, dynamic> json) => Curso(
        idCurso: json["ID_CURSO"],
        nombreCurso: json["NOMBRE_CURSO"],
        idCarrera: json["ID_CARRERA"],
    );

    Map<String, dynamic> toJson() => {
        "ID_CURSO": idCurso,
        "NOMBRE_CURSO": nombreCurso,
        "ID_CARRERA": idCarrera,
    };
}
