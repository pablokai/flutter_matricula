import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_proyecto/screens/home_menu.dart';
import 'package:flutter_proyecto/screens/majors_list.dart';
import 'package:flutter_proyecto/screens/welcome_page.dart';
import 'package:splashscreen/splashscreen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sistema de Asistencia',    
      initialRoute: 'splash',
      routes: {
        'splash': (_) => Splash(),
        '/': (_) => HomeMenu(),
        'carrera': (_) => Carreras(),
        'matricula': (_) => Welcome()
      },
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds:  HomeMenu(),
      
      title:  Text('Powered by PCK',textScaleFactor: 1,),
      image:  Image(image: AssetImage('assets/FLUTTERLOGO2.png')),
      loadingText: Text("Ingresando..."),
      photoSize: 180.0,
      loaderColor: Colors.deepPurpleAccent.shade400,
    );
  }
}


/****  LÓGICA MATRICULA ****/ 
//GET a carreras de la api
//GET de cursos por la carrera elegida /CARRERA -> EN API
//GET de grupos por el curso elegido /CURSO -> EN API
//CON LOS DATOS ELEGIDOS, SE HACE POST A MATRICULA

/****  LÓGICA ASISTENCIA ****/ 
//GET de asistencias por grupos matriculados  /hacer método API
//GET de asistencias por cursos matriculados  /hacer método API
//POST a asistencias con los datos, DEBE PREGUNTAR CONFIRMACIÓN ANTES DE ENVIAR, SE MUESTRA MENSAJE DE ÉXITO
