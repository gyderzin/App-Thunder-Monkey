// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thunder_monkey_app/Control/ControlesControler.dart';
import 'package:thunder_monkey_app/Models/Controle.dart';

class DialogTVControll extends StatefulWidget {
  final controle;
  final Function atualizar_controles;
  const DialogTVControll(
      {super.key, required this.controle, required this.atualizar_controles});

  @override
  State<DialogTVControll> createState() => _DialogTVControllState(
      atualizar_controles: atualizar_controles, controle: controle);
}

class _DialogTVControllState extends State<DialogTVControll> {
  final controle;
  final Function atualizar_controles;
  var auxControle;
  Map<String, dynamic> controleState = {};

  void initState() {
    super.initState();
    auxControle = jsonDecode(controle['controles']);
    auxControle.forEach((obj) {
      obj.forEach((key, value) {
        controleState[key] = value;
      });
    });
  }

  _DialogTVControllState(
      {required this.atualizar_controles, required this.controle});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          await atualizar_controles();
          return true;
        },
        child: Dialog.fullscreen(
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
                                ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                                controleState['comando'] = controleSamsung.power;
                                ControlesControler.atualizarTVControll(controle['id'], controleState);
                              },
                              icon: Icon(
                                Icons.power_settings_new,
                                color: Colors.redAccent,
                                size: 50,
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: IconButton(
                                onPressed: () {
                                  ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                                  controleState['comando'] = controleSamsung.vol_mais;
                                  ControlesControler.atualizarTVControll(controle['id'], controleState);
                                },
                                icon: Icon(
                                  Icons.add,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Text("VOL", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25
                                ),),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: IconButton(
                                onPressed: () {
                                  ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                                  controleState['comando'] = controleSamsung.vol_menos;
                                  ControlesControler.atualizarTVControll(controle['id'], controleState);
                                },
                                icon: Icon(
                                  Icons.remove,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: IconButton(
                                  onPressed: () {
                                    ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                                    controleState['comando'] = controleSamsung.mute;
                                    ControlesControler.atualizarTVControll(controle['id'], controleState);
                                  },
                                  icon: Icon(
                                    Icons.volume_off,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: IconButton(
                                onPressed: () {
                                  ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                                  controleState['comando'] = controleSamsung.home;
                                  ControlesControler.atualizarTVControll(controle['id'], controleState);
                                },
                                icon: Icon(
                                  Icons.home,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: IconButton(
                                onPressed: () {
                                  ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                                  controleState['comando'] = controleSamsung.ch_mais;
                                  ControlesControler.atualizarTVControll(controle['id'], controleState);
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_up,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Text("CH", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25
                              ),),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: IconButton(
                                onPressed: () {
                                  ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                                  controleState['comando'] = controleSamsung.ch_menos;
                                  ControlesControler.atualizarTVControll(controle['id'], controleState);
                                },
                                icon: Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: IconButton(
                            onPressed: () {
                              ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                              controleState['comando'] = controleSamsung.settings;
                              ControlesControler.atualizarTVControll(controle['id'], controleState);
                            },
                            icon: Icon(
                              Icons.settings,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: IconButton(
                            onPressed: () {
                              ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                              controleState['comando'] = controleSamsung.seta_cima;
                              ControlesControler.atualizarTVControll(controle['id'], controleState);
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_up,
                              size: 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: IconButton(
                            onPressed: () {
                              ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                              controleState['comando'] = controleSamsung.conections;
                              ControlesControler.atualizarTVControll(controle['id'], controleState);
                            },
                            icon: Icon(
                              Icons.cable,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            onPressed: () {
                              ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                              controleState['comando'] = controleSamsung.seta_esquerda;
                              ControlesControler.atualizarTVControll(controle['id'], controleState);
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_left,
                              size: 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            onPressed: () {
                              ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                              controleState['comando'] = controleSamsung.seta_btnOK;
                              ControlesControler.atualizarTVControll(controle['id'], controleState);
                            },
                            icon: Icon(
                              Icons.radio_button_off,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: IconButton(
                            onPressed: () {
                              ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                              controleState['comando'] = controleSamsung.seta_direita;
                              ControlesControler.atualizarTVControll(controle['id'], controleState);
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_right,
                              size: 45,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: IconButton(
                            onPressed: () {
                              ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                              controleState['comando'] = controleSamsung.back;
                              ControlesControler.atualizarTVControll(controle['id'], controleState);
                            },
                            icon: Icon(
                              Icons.keyboard_return,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: IconButton(
                            onPressed: () {
                              ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                              controleState['comando'] = controleSamsung.seta_baixo;
                              ControlesControler.atualizarTVControll(controle['id'], controleState);
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              size: 45,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: IconButton(
                            onPressed: () {
                              ControleTV controleSamsung = ControleTV(marca: controle['marca']);
                              controleState['comando'] = controleSamsung.exit;
                              ControlesControler.atualizarTVControll(controle['id'], controleState);
                            },
                            icon: Icon(
                              Icons.exit_to_app,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
