// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunder_monkey_app/Control/CircuitoControler.dart';
import 'package:thunder_monkey_app/Models/Circuito.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Circuito/DialogoInfoCircuito.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Circuito/DiaologNovoCircuito.dart';

class ControlarCircuitos extends StatefulWidget {
  const ControlarCircuitos({super.key});
  @override
  State<ControlarCircuitos> createState() => _ControlarCircuitosState();
}

class _ControlarCircuitosState extends State<ControlarCircuitos> {
  late int? idDp;
  late Future<List<CircuitoDB>> circuitosFuture;

  @override
  void initState() {
    super.initState();
    idDp = null;
    circuitosFuture = recuperarCircuitos();
  }

  Future<List<CircuitoDB>> recuperarCircuitos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? resultado = prefs.getInt('idDp');
    setState(() {
      idDp = resultado;
    });
    return CircuitoControler.recuperarCircuitos(idDp);
  }

  Future<void> deletarCircuito(circuitoDelete) async {
    var circuitoSend = jsonEncode({
      'id_dp': circuitoDelete.id_dp,
      'numero_circuito': circuitoDelete.numero_circuito,
    });

    CircuitoControler.deletarCircuito(circuitoSend).then((value) => {
          if (mounted)
            {
              setState(() {
                circuitosFuture = CircuitoControler.recuperarCircuitos(idDp);
              })
            }
        });
  }

  Future<void> editarCircuito(circuitoEdit) async {
    var circuito = jsonEncode({
      'id_dp': circuitoEdit['id_dp'],
      'numero_circuito': circuitoEdit['numero_circuito'],
      'nome': circuitoEdit['nome'],
      'porta': circuitoEdit['porta'],
      'icon': circuitoEdit['icon'],
    });
    CircuitoControler.atualizar_circuito(circuito).then((value) {
      if (mounted) {
        setState(() {
          circuitosFuture = CircuitoControler.recuperarCircuitos(idDp);
        });
      }
    });
  }

  Future<void> adicionarCircuito(Map<String, Object> newCircuito) async {
    List<CircuitoDB> circuitos = await circuitosFuture;

    var circuitoT;
    var numero_circuito;
    if (circuitos.isNotEmpty) {
      for (circuitoT in circuitos) {
        numero_circuito = circuitoT.numero_circuito + 1;
      }
    } else {
      numero_circuito = 1;
    }

    List<Map<String, dynamic>> circuito = [
      {
        'idDp': idDp,
        'nome': newCircuito['nome'],
        'porta': newCircuito['porta'],
        'icon': (newCircuito['icon'] as IconData).codePoint,
        'numero_circuito': numero_circuito,
      }
    ];
    await CircuitoControler.novoCircuito(circuito);

    Future<List<CircuitoDB>> circuitosNovos = recuperarCircuitos();
    setState(() {
      circuitosFuture = circuitosNovos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: circuitosFuture,
      builder: (context, snapshot) {
        if (idDp == null ||
            snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erro: ${snapshot.error}'),
          );
        } else if (snapshot.hasData) {
          List<CircuitoDB> lista = snapshot.data as List<CircuitoDB>;
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 10, 0),
                    child: FloatingActionButton(
                      onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => DialogNovoCircuito(
                                adicionarCircuitoCallback: adicionarCircuito,
                              )),
                      backgroundColor: Colors.black,
                      mini: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 135,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                    ),
                    itemCount: lista.length,
                    itemBuilder: (context, index) {
                      CircuitoDB circuito = lista[index];
                      return GestureDetector(
                        onTap: () {
                          var state = circuito.estado == 1 ? false : true;
                          CircuitoControler.liga_desliga(
                              circuito.id_dp, state, circuito.numero_circuito);
                          setState(() {
                            circuito.estado = state ? 1 : 0;
                          });
                        },
                        child: Card(
                          color: circuito.estado == 0
                              ? Colors.black
                              : Colors.lightBlueAccent,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(padding: EdgeInsets.all(0)),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text(
                                      circuito.nome,
                                      style: TextStyle(
                                        color: circuito.estado == 1
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            DialogInfoCircuito(
                                              circuito: circuito,
                                              editarCircuito: editarCircuito,
                                              deletarCircuito: deletarCircuito,
                                            )),
                                    child: Icon(
                                      Icons.info,
                                      color: circuito.estado == 1
                                          ? Colors.black
                                          : Colors.white,
                                      size: 15,
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  IconData(circuito.icon,
                                      fontFamily: "MaterialIcons"),
                                  color: circuito.estado == 1
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      "Circuito: ${circuito.numero_circuito}",
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: circuito.estado == 1
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "Porta: ${circuito.porta}",
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: circuito.estado == 1
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                    Text(
                                      circuito.estado == 1
                                          ? "Ligado"
                                          : "Desligado" as String,
                                      style: TextStyle(
                                        fontSize: 8,
                                        color: circuito.estado == 1
                                            ? Colors.black
                                            : Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: Text("Nenhum dado disponível."),
          );
        }
      },
    );
  }
}
