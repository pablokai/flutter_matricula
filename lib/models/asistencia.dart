import 'dart:convert';

List<Asistencia> asistenciaFromJson(String str) => List<Asistencia>.from(json.decode(str).map((x) => Asistencia.fromJson(x)));

String asistenciaToJson(List<Asistencia> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Asistencia {
    Asistencia({
        this.idRegistro,
        this.idCurso,
        this.idGrupo,
        this.idEstudiante,
        this.fechaAsistencia,
        this.tipoRegistro,
    });

    int idRegistro;
    String idCurso;
    int idGrupo;
    String idEstudiante;
    String fechaAsistencia;
    int tipoRegistro;

    factory Asistencia.fromJson(Map<String, dynamic> json) => Asistencia(
        idRegistro: json["ID_REGISTRO"],
        idCurso: json["ID_CURSO"],
        idGrupo: json["ID_GRUPO"],
        idEstudiante: json["ID_ESTUDIANTE"],
        fechaAsistencia: json["FECHA_ASISTENCIA"],
        tipoRegistro: json["TIPO_REGISTRO"],
    );

    Map<String, dynamic> toJson() => {
        "ID_REGISTRO": idRegistro,
        "ID_CURSO": idCurso,
        "ID_GRUPO": idGrupo,
        "ID_ESTUDIANTE": idEstudiante,
        "FECHA_ASISTENCIA": fechaAsistencia,
        "TIPO_REGISTRO": tipoRegistro,
    };
}
