import 'package:flutter/material.dart';
import 'package:flutter_proyecto/models/grupo.dart';
import 'package:flutter_proyecto/providers/grupo_service.dart';
import 'package:flutter_proyecto/screens/matricula_form.dart';


class Groups extends StatefulWidget {
  final String cursoid;
  final String nombrecarrera;
  const Groups({Key key, @required this.cursoid, @required this.nombrecarrera}) : super(key: key);
  @override
  _GroupState createState() => _GroupState();
}


class _GroupState extends State<Groups> {
  Future<List<Grupo>> grupos;
      int selectedIndex; 
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
    grupos= GrupoService.getGrupos(widget.cursoid);
    super.initState();
  }


Widget _createBody(){
  return Center(
      child: FutureBuilder(
        future: grupos,
        builder: (BuildContext context, AsyncSnapshot<List<Grupo>> snapshot){
          List<Widget> children;
          if(snapshot.hasData && snapshot.connectionState == ConnectionState.done){
           
           return ListView.builder(
             itemCount: snapshot.data.length,
             itemBuilder: (BuildContext context, int index){
              return ListTile(
                title: Text(snapshot.data[index].idGrupo.toString() == null ? "<Sin grupo>": snapshot.data[index].idGrupo.toString()),
                subtitle: Text( snapshot.data[index].numGrupo.toString() == null ? "<Sin nombre>":'Grupo #' + snapshot.data[index].numGrupo.toString()),
                 onTap: () async {
                          setState(() {
                            selectedIndex = index;
                            //final snackBar = SnackBar(content: Text( snapshot.data[selectedIndex].idCarrera.toString()));
                            //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          });
                          final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MatriculaForm(
                                      idgrupo: snapshot
                                          .data[selectedIndex].idGrupo
                                          .toString(),
                                          idcarrera: widget.nombrecarrera,
                                          idcurso: widget.cursoid )));
                        },              
              );
            }
            );
          }else if(snapshot.connectionState == ConnectionState.waiting){

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
          }else{
                children = const <Widget>[                            
                Padding(
                  padding: EdgeInsets.only(top: 30),                 
                  child: Text(
                    'No hay datos',
                    style:TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30
                  ),
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
        }     
      ),
  );
}


}