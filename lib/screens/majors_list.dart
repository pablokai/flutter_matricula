import 'package:flutter/material.dart';
import 'package:flutter_proyecto/models/carrera.dart';
import 'package:flutter_proyecto/models/grupo.dart';
import 'package:flutter_proyecto/providers/carrera_service.dart';
import 'package:flutter_proyecto/screens/courses_list.dart';
import 'package:flutter_proyecto/screens/groups_list.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Carreras extends StatefulWidget {
  @override
  State createState() {
    return _CarreraState();
  }
}

class _CarreraState extends State {
  int selectedIndex;
  Future<List<Carrera>> carreras;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Seleccione una carrera',
            style: TextStyle(color: Colors.white),
            
          ),
          elevation: 0,
          backgroundColor: Colors.deepPurpleAccent.shade400),
      body:  _createBody(),
    );
  }

  @override
  void initState() {
    carreras= CarreraService.getCarreras(); 
   super.initState();
  }

  Widget _createBody() {

    return Center(    
           
        child: FutureBuilder(
            future: carreras,
            builder:
                (BuildContext context, AsyncSnapshot<List<Carrera>> snapshot) {
              List<Widget> children;

               if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                            // ignore: prefer_if_null_operators
                            snapshot.data[index].idCarrera.toString() == null
                                ? "<Sin ID>"
                                : snapshot.data[index].idCarrera.toString()),
                        subtitle: Text(
                            // ignore: prefer_if_null_operators
                            snapshot.data[index].nombreCarrera == null
                                ? "<Sin nombre>"
                                : snapshot.data[index].nombreCarrera),
                        onTap: () async {
                          setState(() {
                            selectedIndex = index;
                            //final snackBar = SnackBar(content: Text( snapshot.data[selectedIndex].idCarrera.toString()));
                            //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          });
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Courses(
                                      idcarrera: snapshot
                                          .data[selectedIndex].idCarrera
                                          .toString(),
                                          nombre: snapshot
                                          .data[selectedIndex].nombreCarrera
                                          .toString())));
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
              /*return TextButton(
                    onPressed: () {
                      setState(() {
                        _inAsyncCall = true;
                      });
                      carreras = CarreraService.getCarreras();
                      setState(() {
                        _inAsyncCall = false;
                      });
                    },
                    child: Text("Traer datos"),
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.teal, primary: Colors.white));
              }*/
            }),
     
    );
  }
}
