// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunder_monkey_app/Control/AgendamentoControler.dart';
import 'package:thunder_monkey_app/Control/CircuitoControler.dart';
import 'package:thunder_monkey_app/Models/Circuito.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Agendamento/DialogInfoAgendamento.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Agendamento/DialogNovoAgendamento.dart';

class Agendamentos extends StatefulWidget {
  const Agendamentos({super.key});

  @override
  State<Agendamentos> createState() => _AgendamentosState();
}

class _AgendamentosState extends State<Agendamentos> {
  late int? idDp;
  late Future agendamentosFuture;
  var circuitos = [];

  @override
  void initState() {
    super.initState();
    idDp = null;
    agendamentosFuture = recuperarAgendamentos();
    recuperarCircuitos();
  }

  Future recuperarAgendamentos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? resultado = prefs.getInt('idDp');
    setState(() {
      idDp = resultado;
    });
    return AgendamentoControler.recuperar_agendamentos(idDp);
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

  Future novoAgendamento(nome, hora, dias, circuitos) async {
    var horaSend = '${hora.hour}:${hora.minute.toString().padLeft(2, '0')}';
    var diasSend = dias.join(', ');

    var circuitosSend = [];

    for (var circuito in circuitos) {
      circuitosSend.add({
        'circuito': circuito['numero_circuito'],
        'estado': circuito['estado']
      });
    }

    AgendamentoControler.adicionar_agendamento(
            idDp, nome, horaSend, diasSend, circuitosSend)
        .then((value) => {
              setState(() {
                agendamentosFuture = recuperarAgendamentos();
              })
            });
  }

  Future editarAgendamento(idAgendamento, nome, hora, dias, circuitos) async {
    var horaSend = '${hora.hour}:${hora.minute.toString().padLeft(2, '0')}';
    var diasSend = dias.join(', ');

    var circuitosSend = [];

    for (var circuito in circuitos) {
      circuitosSend.add({
        'circuito': circuito['numero_circuito'],
        'estado': circuito['estado']
      });
    }
    AgendamentoControler.editar_agendamento(
        idAgendamento, nome, horaSend, diasSend, circuitosSend)
        .then((value) => {
      setState(() {
        agendamentosFuture = recuperarAgendamentos();
      })
    });
  }

  Future excluir_agendamento(id) async {
    AgendamentoControler.excluir_agendamento(id).then((value) => {
      setState(() {
        agendamentosFuture = recuperarAgendamentos();
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: agendamentosFuture,
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
          var lista = jsonDecode(snapshot.data);
          return Container(
            padding: EdgeInsets.all(20),
            child: Card(
              color: Colors.black,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(20),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(45, 20, 0, 20),
                        child: Text("Agendamentos",
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
                                  DialogNovoAgendamento(
                                    novoAgendamento: novoAgendamento,
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
                        padding: EdgeInsets.all(25),
                        child: lista.isNotEmpty
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisExtent: 330,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: lista.length,
                                itemBuilder: (context, index) {
                                  var agendamento = lista[index];

                                  List circuitosAgendamento =
                                      jsonDecode(lista[index]['circuitos']);
                                  var circuitoAgendamento = [];
                                  for (var circuito in circuitos) {
                                    for (var circuitoRotina2
                                        in circuitosAgendamento) {
                                      if (circuitoRotina2['circuito'] ==
                                          circuito['numero_circuito']) {
                                        circuitoAgendamento.add(circuito);
                                      }
                                    }
                                  }

                                  return Card(
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            agendamento['nome'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                                    child: Text(
                                                      'Dias de execução',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontFamily: 'Roboto'
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                                    child: Text(
                                                      agendamento['intervalo_dias'] == 'seg, ter, qua, qui, sex, sab, dom' ? 'Todos os dias': agendamento['intervalo_dias'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 12
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                                    child: Text(
                                                      'Hora de execução',
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15,
                                                          fontFamily: 'Roboto'
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                                                    child: Text(
                                                      agendamento['hora'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 13
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: ListView.builder(
                                            itemCount:
                                                circuitoAgendamento.length,
                                            itemBuilder: (context, index) {
                                              var circuito =
                                                  circuitoAgendamento[index];
                                              return ListTile(
                                                title: Text(
                                                  circuito['nome'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Circuito ${circuito['numero_circuito']}"),
                                                    Text(circuitosAgendamento[
                                                                    index]
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
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: IconButton(
                                            onPressed: () => showDialog<String>(
                                                context: context,
                                                builder: (BuildContext
                                                        context) =>
                                                    DialogInfoAgendamento(agendamento: agendamento, circuitos: circuitoAgendamento, circuitosAgendamento: circuitosAgendamento, deletarAgendamento: excluir_agendamento, editarAgendamento: editarAgendamento ,)
                                            ),
                                            icon: Icon(Icons.info),
                                            color: Colors.lightBlue,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                })
                            : Center(
                                child:
                                    Text('Crie seus agendamentos no botão + '),
                              )),
                  ),
                ],
              ),
            ),
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
