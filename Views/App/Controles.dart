// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thunder_monkey_app/Control/ControlesControler.dart';
import 'package:thunder_monkey_app/Control/DispositivoControler.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Controle/DialogAirControll.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Controle/DialogNovoControle.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Controle/DialogTVControll.dart';

class Controles extends StatefulWidget {
  const Controles({super.key});

  @override
  State<Controles> createState() => _ControlesState();
}

class _ControlesState extends State<Controles> {
  late Future controles;

  Future atualizar_controles() async {
    setState(() {
      controles = ControlesControler.recuperarControles();
    });
  }

  Future novo_controle(nome, tipo, marca) async {
    ControlesControler.novoControle(nome, tipo, marca).then((value) => {
          setState(() {
            controles = ControlesControler.recuperarControles();
          })
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controles = ControlesControler.recuperarControles();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: controles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var lista = jsonDecode(snapshot.data);
            return Container(
              padding: EdgeInsets.all(20),
              child: Card(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(45, 20, 0, 20),
                            child: Text("Controles",
                                style: TextStyle(
                                  fontSize: 25,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: FloatingActionButton(
                              onPressed: () => showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DialogNovoControle(novoControle: novo_controle,)),
                              backgroundColor: Colors.white,
                              mini: true,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Icon(Icons.add, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(25),
                          child: GridView.builder(
                              itemCount: lista.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisExtent: 180,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                              ),
                              itemBuilder: (context, index) {
                                var controle = lista[index];

                                return GestureDetector(
                                  onTap: () => showDialog<String>(
                                      context: context,
                                      builder: (BuildContext context) {
                                        if (controle['tipo'] == 'Air') {
                                          return DialogAirControll(
                                            controle: controle,
                                            atualizar_controles:
                                                atualizar_controles,
                                          );
                                        } else {
                                          return DialogTVControll(
                                            controle: controle,
                                            atualizar_controles:
                                                atualizar_controles,
                                          );
                                        }
                                      }),
                                  child: Card(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          controle['nome'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          "Clique aqui para acessar o controle da ${controle['tipo'] == 'Air' ? 'Central de Ar' : "TV"}.",
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Icon(
                                            controle['tipo'] == 'Air'
                                                ? Icons.settings_remote
                                                : Icons.tv,
                                            size: 30,
                                          )),
                                    ],
                                  )),
                                );
                              }),
                        ),
                      )
                    ],
                  )),
            );
          } else {
            return const Center(
              child: Text("Nenhum dado disponível."),
            );
          }
        });
  }
}
