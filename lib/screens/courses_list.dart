import 'package:flutter/material.dart';
import 'package:flutter_proyecto/models/curso.dart';
import 'package:flutter_proyecto/models/grupo.dart';
import 'package:flutter_proyecto/providers/curso_service.dart';
import 'package:flutter_proyecto/providers/grupo_service.dart';
import 'package:flutter_proyecto/screens/groups_list.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Courses extends StatefulWidget {
  final String idcarrera;
  final String nombre;
  const Courses({Key key, @required this.idcarrera,  @required this.nombre }) : super(key: key);
  @override
 
   _CourseState createState() => _CourseState();  
}


class _CourseState extends State<Courses> {
  Future<List<Curso>> cursos;
    int selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Seleccione un curso'),
          backgroundColor: Colors.deepPurpleAccent.shade400),
      body: _createBody(),
      );
  }

  @override
  void initState() {
    cursos=CursoService.getCursos(widget.idcarrera);
   super.initState();
  }

  Widget _createBody() {
    return Center(
        child: FutureBuilder(
            future: cursos,
            builder:
                (BuildContext context, AsyncSnapshot<List<Curso>> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        // ignore: prefer_if_null_operators
                        title: Text(snapshot.data[index].idCurso == null
                            ? "<Sin nombre>"
                            : snapshot.data[index].idCurso),
                        // ignore: prefer_if_null_operators
                        subtitle: Text(snapshot.data[index].nombreCurso == null
                            ? "<Sin nombre>"
                            : snapshot.data[index].nombreCurso),
                        onTap: () async {
                          setState(() {
                            selectedIndex = index;
                            
                          });
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Groups(
                                      cursoid: snapshot
                                          .data[selectedIndex].idCurso
                                          .toString(),
                                      nombrecarrera: widget.nombre                                         
                                          )));
                                      
                        },
                      );
                    });
              } else {
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
              }
            }),    
    );
  }
}

