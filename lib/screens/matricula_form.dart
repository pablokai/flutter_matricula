import 'package:flutter/material.dart';
import 'package:flutter_proyecto/models/matricula.dart';
import 'package:flutter_proyecto/providers/matricula_service.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MatriculaForm extends StatefulWidget {
  final String idgrupo;
  final String idcarrera;
  final String idcurso;
  const MatriculaForm({Key key, @required this.idgrupo, @required this.idcarrera,@required this.idcurso}) : super(key: key);
  @override
  _MatriculaFormState createState() => _MatriculaFormState();
}

class _MatriculaFormState extends State<MatriculaForm> {
  bool _active = false;
  bool _saving = false;
  final _estudianteController = TextEditingController();
  final _notaController = TextEditingController();
  String _ddlValue = "Ordinaria";
  var items = ["Ordinaria", "Extraordinaria"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Matricula'),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _saving = true;
                });
                _enrollStudent();
              },
              icon: Icon(Icons.add_circle_outlined))
        ],
        backgroundColor: Colors.deepPurpleAccent.shade400,
      ),
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          children: [
            TextField(
              controller: _estudianteController,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.blueGrey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Ingrese el id de estudiante',
                  labelText: 'Cédula de Identidad',
                  labelStyle:
                      TextStyle(color: Colors.blueGrey.shade800, fontSize: 18),
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.deepPurpleAccent.shade400,
                  )),
            ),
            space(),
            TextField(
              controller: _notaController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: 'Ingrese la nota',
                  icon: Icon(
                    Icons.school_outlined,
                    color: Colors.deepPurpleAccent.shade400,
                  ),
                  labelText: 'Nota',
                  labelStyle:
                      TextStyle(color: Colors.blueGrey.shade800, fontSize: 18),
                  filled: true,
                  fillColor: Colors.blueGrey.shade50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  )),
            ),
             space(),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurpleAccent.shade400,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  labelText: widget.idcarrera,
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  icon: Icon(Icons.category_rounded,
                      color: Colors.deepPurpleAccent.shade400),
                  enabled: false),
            ),
             space(),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurpleAccent.shade400,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  labelText: " Curso " + widget.idcurso,
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  icon: Icon(Icons.book_rounded,
                      color: Colors.deepPurpleAccent.shade400),
                  enabled: false),
            ),
            space(),
            TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.deepPurpleAccent.shade400,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  labelText: " Grupo " + widget.idgrupo,
                  labelStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  icon: Icon(Icons.people_alt_rounded,
                      color: Colors.deepPurpleAccent.shade400),
                  enabled: false),
            ),
            space(),
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  labelText: "Tipo de matrícula",
                  labelStyle: TextStyle(
                      color: Colors.blueGrey.shade900,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  icon: Icon(Icons.list_alt_rounded,
                      color: Colors.deepPurpleAccent.shade400),
                  enabled: false),
            ),
            space2(),
            DropdownButton(
              value: _ddlValue,
              isExpanded: true,
              dropdownColor: Colors.blueGrey.shade50,
              icon: Icon(Icons.keyboard_arrow_down),
              borderRadius: BorderRadius.circular(15),
              items: items.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              style: TextStyle(color: Colors.blueGrey.shade900, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.deepPurpleAccent.shade200,
              ),
              onChanged: (String newValue) {
                setState(() {
                  _ddlValue = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _enrollStudent() async {
    if (_estudianteController.text.isEmpty || _notaController.text.isEmpty) {
      final snackBar =
          SnackBar(content: Text('Error, llene todos los campos'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _saving = false;
      });
    } else if (double.parse(_notaController.text) < 0 ||
        double.parse(_notaController.text) > 100) {
      final snackBar =
          SnackBar(content: Text('Error en la nota, verifique los datos'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _saving = false;
      });
    } else {
      var m = Matricula();

      m
        ..idMatricula = 0
        ..idEstudiante = _estudianteController.text
        ..idGrupo = int.parse(widget.idgrupo)
        ..nota = double.parse(_notaController.text)
        ..tipoMatricula = _ddlValue == "Ordinario" ? "ordinario" : "extraordinario";

      if (await MatriculaService.postMatricula(m)) {

        final snackBar = SnackBar(content: Text('Se ha matriculado con éxito'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.pop(
          context,
          ModalRoute.withName('matricula'),
        );
      } else {
        final snackBar =
         SnackBar(content: Text('Error al matricular al estudiante, inténtelo de nuevo'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          _saving = false;
        });
      }
    }
  }
}

class space extends StatelessWidget {
  const space({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 5,
      color: Colors.transparent,
      height: 30,
    );
  }
}

class space2 extends StatelessWidget {
  const space2({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 5,
      color: Colors.transparent,
      height: 20,
    );
  }
}
