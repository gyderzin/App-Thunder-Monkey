// ignore_for_file: prefer_const_constructors
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunder_monkey_app/Control/CircuitoControler.dart';
import 'package:thunder_monkey_app/Control/RotinaControler.dart';
import 'package:thunder_monkey_app/Models/Circuito.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Rotina/DialogInfoRotina.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Rotina/DialogNovaRotina.dart';

class Rotinas extends StatefulWidget {
  const Rotinas({super.key});

  @override
  State<Rotinas> createState() => _RotinasState();
}

class _RotinasState extends State<Rotinas> {
  late int? idDp;
  var circuitos = [];

  late Future rotinas;

  @override
  void initState() {
    super.initState();
    idDp = null;
    rotinas = RotinaControler.recuperar_rotinas();
    recuperarCircuitos();
  }

  Future recuperarCircuitos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? resultado = prefs.getInt('idDp');
    setState(() {
      idDp = resultado;
    });
    List<CircuitoDB> circuitosDB =
        await CircuitoControler.recuperarCircuitos(idDp);
    var circuito;

    for (circuito in circuitosDB) {
      setState(() {
        circuitos.add({
          'nome': circuito.nome,
          'numero_circuito': circuito.numero_circuito,
          'porta': circuito.porta,
          'icon': circuito.icon
        });
      });
    }
  }

  Future<void> novaRotina(circuitosRotina, nomeRotina) async {
    List circuitosRotinaSend = [];
    for (var circuito in circuitosRotina) {
      circuitosRotinaSend.add({
        'circuito': circuito['numero_circuito'],
        'estado': circuito['estado']
      });
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? idDp = prefs.getInt('idDp');

    RotinaControler.adicionar_rotina(circuitosRotinaSend, nomeRotina, idDp).then((value) => {
          setState(() {
            rotinas = RotinaControler.recuperar_rotinas();
          })
    });


  }

  Future <void> editarRotina(circuitos, nomeRotina, idRotina) async {
    var circuitosSend = [];
    for(var circuito in circuitos) {
      circuitosSend.add({
        'circuito': circuito['numero_circuito'],
        'estado': circuito['estado']
      });
    }
    RotinaControler.editar_rotina(idRotina, circuitosSend, nomeRotina).then((value) => {
      setState(() {
        rotinas = RotinaControler.recuperar_rotinas();
      })
    });
  }

  Future <void> deletarRotina(idRotina) async {
    RotinaControler.delelar_rotina(idRotina).then((value) => {
      setState(() {
        rotinas = RotinaControler.recuperar_rotinas();
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rotinas,
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
          List? lista = snapshot.data;
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
                          child: Text(
                            "Rotinas",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: FloatingActionButton(
                            onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    DialogNovaRotina(
                                      adicionarRotina: novaRotina,
                                    )),
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
                          padding: EdgeInsets.all(10),
                          child: lista!.isNotEmpty ? GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 275,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: lista!.length,
                            itemBuilder: (context, index) {
                              var rotina = lista[index];
                              List circuitosRotina =
                              jsonDecode(lista[index]['circuitos']);
                              var circuitoRotina = [];
                              for (var circuito in circuitos) {
                                for (var circuitoRotina2 in circuitosRotina) {
                                  if (circuitoRotina2['circuito'] ==
                                      circuito['numero_circuito']) {
                                    circuitoRotina.add(circuito);
                                  }
                                }
                              }
                              return InkWell(
                                onTap: () {
                                  CircuitoControler.executar_rotina(rotina)
                                      .then((value) => {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        action: SnackBarAction(
                                          label: 'OK',
                                          onPressed: () {
                                            // Code to execute.
                                          },
                                        ),
                                        content: const Text(
                                            'Rotina executada!'),
                                        duration: const Duration(
                                            milliseconds: 2000),
                                        width:
                                        280.0, // Width of the SnackBar.
                                        padding:
                                        const EdgeInsets.symmetric(
                                          horizontal:
                                          8.0, // Inner padding for SnackBar content.
                                        ),
                                        behavior:
                                        SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              10.0),
                                        ),
                                      ),
                                    )
                                  });
                                },
                                child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Text(
                                          rotina['nome'],
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: circuitoRotina.length,
                                          itemBuilder: (context, index) {
                                            var circuito =
                                            circuitoRotina[index];
                                            return ListTile(
                                              title: Text(
                                                circuito['nome'],
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "Circuito ${circuito['numero_circuito']}"),
                                                  Text(circuitosRotina[index]
                                                  ['estado'] ==
                                                      true
                                                      ? 'Ligar'
                                                      : 'Desligar'),
                                                ],
                                              ),
                                              leading: Icon(
                                                IconData(circuito['icon'],
                                                    fontFamily:
                                                    'MaterialIcons'),
                                                color: Colors.black,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: IconButton(
                                                onPressed: () => showDialog<String>(
                                                    context: context,
                                                    builder: (BuildContext context) =>
                                                        DialogInfoRotina(
                                                          circuitos: circuitoRotina,
                                                          rotina: rotina,
                                                          circuitosRotina: circuitosRotina,
                                                          deletarRotina: deletarRotina,
                                                          editarRotina: editarRotina,
                                                        )
                                                ),
                                                icon: Icon(
                                                  Icons.info,
                                                  color: Colors.lightBlue,
                                                )),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ) : Center(
                            child: Text('Crie suas rotinas no botão + '),
                          )
                      ),
                    )
                  ],
                ),
              ));
        } else {
          return const Center(
            child: Text("Nenhum dado disponível.", style: TextStyle(
              color: Colors.white
            ),),
          );
        }
      },
    );
  }
}
