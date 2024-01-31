// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thunder_monkey_app/Control/ControlesControler.dart';

class DialogAirControll extends StatefulWidget {
  final controle;
  final Function atualizar_controles;
  const DialogAirControll({super.key, required this.controle, required this.atualizar_controles});

  @override
  State<DialogAirControll> createState() =>
      _DialogAirControllState(controle: controle, atualizar_controles: atualizar_controles);
}

enum Mode { coll, heet, fan, auto }

class _DialogAirControllState extends State<DialogAirControll> {
  final Function atualizar_controles;
  final controle;
  var auxControle;
  Map<String, dynamic> controleState = {};
  late Mode mode;
  @override
  void initState() {
    super.initState();
    auxControle = jsonDecode(controle['controles']);
    auxControle.forEach((obj) {
      obj.forEach((key, value) {
        controleState[key] = value;
      });
    });

    if (controle['marca'] == 'Gree') {
      if (controleState['mode'] == "kGreeCool") {
        mode = Mode.coll;
      } else if (controleState['mode'] == "kGreeHeat") {
        mode = Mode.heet;
      } else if (controleState['mode'] == "kGreeFan") {
        mode = Mode.fan;
      } else if (controleState['mode'] == "kGreeAuto") {
        mode = Mode.auto;
      }
    } else if (controle['marca'] == 'LG') {
      if (controleState['mode'] == "kLgAcCool") {
        mode = Mode.coll;
      } else if (controleState['mode'] == "kLgAcHeat") {
        mode = Mode.heet;
      } else if (controleState['mode'] == "kLgAcFan") {
        mode = Mode.fan;
      } else if (controleState['mode'] == "kLgAcAuto") {
        mode = Mode.auto;
      }
    }
  }

  _DialogAirControllState({required this.atualizar_controles, required this.controle});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await atualizar_controles();
          return true;
        },
        child:Dialog.fullscreen(
          child: Scaffold(
            backgroundColor: Color(0xFF012677),
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text(
                controle['nome'],
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Container(
                padding: EdgeInsets.all(20),
                child: Card(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(
                          "Controle ${controle['marca']}",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: IconButton(
                                onPressed: () {
                                  controleState['estado'] =
                                  !controleState['estado'];
                                  ControlesControler.atualizarAirControll(
                                      controle['id'], controleState);
                                  setState(() {
                                    controleState['estado'] =
                                    controleState['estado'];
                                  });
                                },
                                icon: Icon(
                                  Icons.power_settings_new,
                                  color: controleState['estado'] == true
                                      ? Colors.green
                                      : Colors.redAccent,
                                  size: 50,
                                )),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "${controleState['temp'].toString()}º",
                              style: TextStyle(color: Colors.white, fontSize: 40),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: IconButton(
                                onPressed: () {
                                  controleState['temp'] = controleState['temp'] + 1;
                                  ControlesControler.atualizarAirControll(
                                      controle['id'], controleState);
                                  setState(() {
                                    controleState['temp'] = controleState['temp'];
                                  });
                                },
                                icon: Icon(
                                  Icons.add,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              )),
                          Padding(
                              padding: EdgeInsets.all(10),
                              child: IconButton(
                                onPressed: () {
                                  controleState['temp'] = controleState['temp'] - 1;
                                  ControlesControler.atualizarAirControll(
                                      controle['id'], controleState);
                                  setState(() {
                                    controleState['temp'] = controleState['temp'];
                                  });
                                },
                                icon: Icon(
                                  Icons.remove,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: SegmentedButton<Mode>(
                              segments: const <ButtonSegment<Mode>>[
                                ButtonSegment<Mode>(
                                  value: Mode.coll,
                                  icon: Icon(
                                    Icons.severe_cold,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                ButtonSegment<Mode>(
                                  value: Mode.heet,
                                  icon: Icon(
                                    Icons.water_drop,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                ButtonSegment<Mode>(
                                  value: Mode.fan,
                                  icon: Icon(
                                    Icons.wind_power,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                ButtonSegment<Mode>(
                                  value: Mode.auto,
                                  icon: Icon(
                                    Icons.hdr_auto,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                              ],
                              style: ButtonStyle(),
                              selected: <Mode>{mode},
                              showSelectedIcon: false,
                              onSelectionChanged: (Set<Mode> newSelection) {
                                print(newSelection.first);
                                if (controle['marca'] == 'Gree') {
                                  if (newSelection.first == Mode.coll) {
                                    controleState['mode'] = "kGreeCool";
                                  } else if (newSelection.first == Mode.heet) {
                                    controleState['mode'] = "kGreeHeat";
                                  } else if (newSelection.first == Mode.fan) {
                                    controleState['mode'] = "kGreeFan";
                                  } else if (newSelection.first == Mode.auto) {
                                    controleState['mode'] = "kGreeAuto";
                                  }
                                } else if (controle['marca'] == 'LG') {
                                  if (newSelection.first == Mode.coll) {
                                    controleState['mode'] = "kLgAcCool";
                                  } else if (newSelection.first == Mode.heet) {
                                    controleState['mode'] = "kLgAcHeat";
                                  } else if (newSelection.first == Mode.fan) {
                                    controleState['mode'] = "kLgAcFan";
                                  } else if (newSelection.first == Mode.auto) {
                                    controleState['mode'] = "kLgAcAuto";
                                  }
                                }
                                ControlesControler.atualizarAirControll(
                                    controle['id'], controleState);
                                setState(() {
                                  mode = newSelection.first;
                                  controleState['mode'] = controleState['mode'];
                                });
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ),
    );
  }
}
