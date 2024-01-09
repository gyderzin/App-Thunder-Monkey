// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunder_monkey_app/Control/DispositivoControler.dart';
import 'package:thunder_monkey_app/Models/Dispositivo.dart';
import 'package:thunder_monkey_app/Views/App/Home.dart';
import 'package:thunder_monkey_app/Views/Login/NumeroSerie.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white
          )
        ),
        fontFamily: 'Afacad',
      ),
      home: FutureBuilder(
        future: DispositivoControler.verificarLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && snapshot.data != false) {
              return Home();
            } else {
              return Login();
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
