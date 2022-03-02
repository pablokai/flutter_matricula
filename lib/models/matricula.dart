import 'dart:convert';

List<Matricula> matriculaFromJson(String str) => List<Matricula>.from(json.decode(str).map((x) => Matricula.fromJson(x)));

String matriculaToJson(List<Matricula> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Matricula {
    Matricula({
        this.idMatricula,
        this.idEstudiante,
        this.idGrupo,
        this.nota,
        this.tipoMatricula,
    });

    int idMatricula;
    String idEstudiante;
    int idGrupo;
    double nota;
    String tipoMatricula;

    factory Matricula.fromJson(Map<String, dynamic> json) => Matricula(
        idMatricula: json["ID_MATRICULA"],
        idEstudiante: json["ID_ESTUDIANTE"],
        idGrupo: json["ID_GRUPO"],
        nota: json["NOTA"],
        tipoMatricula: json["TIPO_MATRICULA"],
    );

    Map<String, dynamic> toJson() => {
        "ID_MATRICULA": idMatricula,
        "ID_ESTUDIANTE": idEstudiante,
        "ID_GRUPO": idGrupo,
        "NOTA": nota,
        "TIPO_MATRICULA": tipoMatricula,
    };
}
