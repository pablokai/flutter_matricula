import 'package:flutter/material.dart';
import 'package:flutter_proyecto/screens/home_menu.dart';
import 'package:flutter_proyecto/screens/majors_list.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    children = <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 0, bottom: 40),
        child: Text(
          'Proceso de Matrícula',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade800),
        ),
      ),
      SizedBox(
        child: Image(
          image: AssetImage('assets/Notification.png'),
        ),
        width: 250,
        height: 250,
      ),
      Padding(
          padding: EdgeInsets.only(top: 40, bottom: 0),
          child: TextButton(
            
            onPressed: () {
              /*Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Carreras()));*/
              Navigator.pushNamed(context, 'carrera');
            },
            child: Text("Iniciar matrícula", style: TextStyle(fontSize: 16),),
            style: TextButton.styleFrom(
                backgroundColor: Colors.deepPurpleAccent.shade400,
                primary: Colors.white,
                fixedSize: Size(180, 50),
                
                ),
          ))
    ];

    return Center(
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
}
