import 'package:flutter/material.dart';
import 'package:thunder_monkey_app/Views/App/Agendamentos.dart';
import 'package:thunder_monkey_app/Views/App/ControlarCircuitos.dart';
import 'package:thunder_monkey_app/Views/App/Controles.dart';
import 'package:thunder_monkey_app/Views/App/Rotinas.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: Image.asset("images/logo2.png", scale: 2),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          body: Container(
            color: Color(0xFF012677),
            child: const TabBarView(
              children: [
                ControlarCircuitos(),
                Rotinas(),
                Agendamentos(),
                Controles(),
                Icon(Icons.directions_transit),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.black,
            child: const TabBar(
              labelColor: Color(0xFF012677),
              indicatorColor:Color(0xFF012677),
              unselectedLabelColor: Colors.white,
              dividerColor: Colors.black,
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.repeat)),
                Tab(icon: Icon(Icons.access_time_filled)),
                Tab(icon: Icon(Icons.settings_remote)),
                Tab(icon: Icon(Icons.settings)),
              ],
            ),
          )
        )
    );


  }
}
