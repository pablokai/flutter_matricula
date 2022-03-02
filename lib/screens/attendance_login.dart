import 'package:flutter/material.dart';
import 'package:flutter_proyecto/models/grupo.dart';
import 'package:flutter_proyecto/providers/grupo_service.dart';
import 'package:flutter_proyecto/screens/groupsbyid_list.dart';

class Attendance extends StatefulWidget {
  @override
  _AttendanceState createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<Widget> children;
  bool _saving = false;
  final _estudianteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    children = <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 0, bottom: 10),
        child: Text(
          'Registro de Asistencia',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade800),
        ),
      ),
      SizedBox(
        child: Image(
          image: AssetImage('assets/Onlinelesson.png'),
        ),
        width: 250,
        height: 250,
      ),
      Padding(
          padding: EdgeInsets.only(top: 30, bottom: 10, left: 30, right: 30),
          child: TextField(
            controller: _estudianteController,
            decoration: InputDecoration(
                hintText: 'Ingrese la cédula del estudiante',
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.deepPurpleAccent.shade400,
                ),
                labelText: 'Cédula',
                labelStyle:
                    TextStyle(color: Colors.blueGrey.shade800, fontSize: 18),
                filled: true,
                fillColor: Colors.blueGrey.shade50,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                )),
          )),
      Padding(
          padding: EdgeInsets.only(top: 5, left: 35),
          child: TextButton(
            onPressed: () {
              /*Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Carreras()));*/
              setState(() {
                _saving = true;
              });
              getGroups();
            },
            child: Text(
              "Ingresar",
              style: TextStyle(fontSize: 16),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent.shade400,
              primary: Colors.white,
              fixedSize: Size(310, 50),
            ),
          )),
    ];
    return SingleChildScrollView(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  void getGroups() async {
    if (_estudianteController.text.isEmpty) {
      final snackBar = SnackBar(content: Text('Error, llene todos los campos'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _saving = false;
      });
    } else {
      if (await GrupoService.getGruposID(_estudianteController.text) == null) {
        final snackBar =
            SnackBar(content: Text('Error, el estudiante no tiene grupos'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          _saving = false;
        });
      } else {
        Future<List<Grupo>> grupos =
            GrupoService.getGruposID(_estudianteController.text);
        final snackBar =
            SnackBar(content: Text('Bienvenido, se han cargado sus grupos'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GroupsID(lista: grupos, id: _estudianteController.text,)));
      }
    }
  }
}
