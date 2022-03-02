import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_proyecto/screens/welcome_page.dart';
import 'attendance_login.dart';
import 'majors_list.dart';

class HomeMenu extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: Icon(Icons.account_balance_rounded),
          title: const Text('Universidad ABC'),
          backgroundColor: Colors.deepPurpleAccent.shade400),
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, //New
        onTap: _onItemTapped,
        unselectedIconTheme: IconThemeData(
          color: Colors.white70,
        ),
        unselectedItemColor: Colors.white70,
        unselectedFontSize: 15,
        selectedFontSize: 20,
        selectedIconTheme: IconThemeData(color: Colors.white, size: 30),
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        backgroundColor: Colors.deepPurpleAccent.shade400,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.login_rounded),
            label: 'Matricula',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline_rounded),
            label: 'Asistencia',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final widgetOptions = [
   Welcome(),
   Attendance(),
];

}

/*class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
          ()=>Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder:
                                                          (context) => 
                                                          HomeMenu()
                                                         )
                                       )
         );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child:FlutterLogo(size:MediaQuery.of(context).size.height)
    );
  }
}*/
