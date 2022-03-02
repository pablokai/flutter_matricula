import 'dart:convert';

List<Grupo> grupoFromJson(String str) => List<Grupo>.from(json.decode(str).map((x)=> Grupo.fromJson(x)));

String grupoToJson(List<Grupo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Grupo {
    Grupo({
        this.idGrupo,
        this.numGrupo,
        this.idCurso,
        this.idProfesor,
        this.horarioE,
        this.horarioS,
        this.dia,
        this.idPeriodo,
    });

    int idGrupo;
    int numGrupo;
    String idCurso;
    String idProfesor;
    String horarioE;
    String horarioS;
    String dia;
    int idPeriodo;

    factory Grupo.fromJson(Map<String, dynamic> json) => Grupo(
        idGrupo: json["ID_GRUPO"],
        numGrupo: json["NUM_GRUPO"],
        idCurso: json["ID_CURSO"],
        idProfesor: json["ID_PROFESOR"],
        horarioE: json["HORARIO_E"],
        horarioS: json["HORARIO_S"],
        dia: json["DIA"],
        idPeriodo: json["ID_PERIODO"],
    );

    Map<String, dynamic> toJson() => {
        "ID_GRUPO": idGrupo,
        "NUM_GRUPO": numGrupo,
        "ID_CURSO": idCurso,
        "ID_PROFESOR": idProfesor,
        "HORARIO_E": horarioE,
        "HORARIO_S": horarioS,
        "DIA": dia,
        "ID_PERIODO": idPeriodo,
    };
}