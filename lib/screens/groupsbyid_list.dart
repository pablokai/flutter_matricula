import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_proyecto/models/asistencia.dart';
import 'package:flutter_proyecto/models/grupo.dart';
import 'package:flutter_proyecto/providers/asistencia_service.dart';
import 'package:flutter_proyecto/providers/grupo_service.dart';
import 'package:flutter_proyecto/screens/matricula_form.dart';
import 'package:intl/intl.dart';

class GroupsID extends StatefulWidget {
  final Future<List<Grupo>> lista;
  final String id;
  const GroupsID({Key key, @required this.lista, @required this.id})
      : super(key: key);
  @override
  _GroupsIDState createState() => _GroupsIDState();
}

class _GroupsIDState extends State<GroupsID> {
  Future<List<Grupo>> grupos;
  int selectedIndex;
  bool _saving = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Seleccione un grupo'),
          backgroundColor: Colors.deepPurpleAccent.shade400),
      body: _createBody(),
    );
  }

  @override
  void initState() {
    grupos = widget.lista;
    super.initState();
  }

  Widget _createBody() {
    return Center(
      child: FutureBuilder(
          future: grupos,
          builder: (BuildContext context, AsyncSnapshot<List<Grupo>> snapshot) {
            List<Widget> children;
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(
                          snapshot.data[index].idGrupo.toString() == null
                              ? "<Sin grupo>"
                              : "Grupo #" +
                                  snapshot.data[index].idGrupo.toString()),
                      subtitle: Text(snapshot.data[index].idCurso.toString() ==
                              null
                          ? "<Sin curso>"
                          : 'Curso ' + snapshot.data[index].idCurso.toString()),
                      onTap: () async {
                        setState(() {
                          selectedIndex = index;
                          //final snackBar = SnackBar(content: Text( snapshot.data[selectedIndex].idCarrera.toString()));
                          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                        _showMyDialog(snapshot.data[index].idCurso.toString(),
                            snapshot.data[index].idGrupo.toString());
                        //registerAttendance(snapshot.data[index].idCurso.toString(), snapshot.data[index].idGrupo.toString(), );
                      },
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              children = const <Widget>[
                SizedBox(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                  width: 80,
                  height: 80,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'Trayendo datos',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ];
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ));
            } else {
              children = const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(
                    'No hay datos',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: Colors.deepPurpleAccent,
                    size: 80,
                  ),
                ),
              ];

              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: children,
              ));

              /*Padding(
                  child: Text("No hay datos",
                  style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  )),
                  )*/
            }
          }),
    );
  }

  void registerAttendance(String idcurso, String idgrupo) async {
    String datetime = DateTime.now().toString();
    var a = Asistencia();
    a
      ..idRegistro = 0
      ..idCurso = idcurso
      ..idGrupo = int.parse(idgrupo)
      ..idEstudiante = widget.id
      ..fechaAsistencia = datetime
      ..tipoRegistro = 1;

    if (await AsistenciaService.postAsistencia(a) == false) {
      final snackBar =
          SnackBar(content: Text('Error, no se pudo registrar la asistencia'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _saving = false;
      });
    } else {
      final snackBar = SnackBar(
          content: Text('Asistencia registrada en el grupo #' + idgrupo + " del curso " + idcurso));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<void> _showMyDialog(String idcurso, String idgrupo) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(children: [
            Image(
                image: AssetImage('assets/Checklist.png'),
                width: 100,
                height: 100,
                fit: BoxFit.contain),
            Text('Registro de asistencia',
                style: TextStyle(
                    color: Colors.blueGrey.shade900,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ]),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Se marcará asistencia en el Grupo # ' +
                    idgrupo +
                    " del Curso " +
                    idcurso),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Aceptar',
                style: TextStyle(fontSize: 16),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                primary: Colors.blueGrey.shade900,
                fixedSize: Size(80, 50),
              ),
              onPressed: () {
                registerAttendance(idcurso, idgrupo);
                 setState(() {
                _saving = true;
                });
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.redAccent.shade400,
                primary: Colors.white,
                fixedSize: Size(80, 50),
              ),
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
