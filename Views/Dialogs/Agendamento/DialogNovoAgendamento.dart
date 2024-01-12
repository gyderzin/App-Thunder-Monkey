// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunder_monkey_app/Control/CircuitoControler.dart';
import 'package:thunder_monkey_app/Models/Circuito.dart';

class DialogNovoAgendamento extends StatefulWidget {
  final Function novoAgendamento;
  const DialogNovoAgendamento({super.key, required this.novoAgendamento});

  @override
  State<DialogNovoAgendamento> createState() =>
      _DialogNovoAgendamentoState(novoAgendamento: novoAgendamento);
}

class _DialogNovoAgendamentoState extends State<DialogNovoAgendamento> {
  final Function novoAgendamento;

  _DialogNovoAgendamentoState({required this.novoAgendamento});

  TextEditingController _nomeAgendamento = TextEditingController();

  TimeOfDay _time = TimeOfDay.now();
  late String formattedTime;

  late TimeOfDay picked;

  var circuitos = [];
  late int? idDp;

  bool liga_desliga = true;
  List circuitosAdd = [];
  Map<String, dynamic> circuitoSelect = {};

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.flash_on);
      }
      return const Icon(Icons.flash_off);
    },
  );

  final _formKey = GlobalKey<FormState>();

  List diasSemana = [
    {'seg': false},
    {'ter': false},
    {'qua': false},
    {'qui': false},
    {'sex': false},
    {'sab': false},
    {'dom': false},
  ];

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

  Future<Null> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
      helpText: 'Defina a hora do seu agendamento.',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: Colors.blue,
            hintColor: Colors.blueAccent,
          ),
          child: child!,
        );
      },
    ))!;
    setState(() {
      _time = picked;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime dateTimeNow = DateTime.now().toUtc().add(Duration(hours: -4));
    _time = TimeOfDay.fromDateTime(dateTimeNow);
    recuperarCircuitos();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> circuitosConvertidos =
        List<Map<String, dynamic>>.from(circuitos);
    return Dialog.fullscreen(
        backgroundColor: Color(0xFF012677),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.all(15),
                    child: Card(
                        color: Colors.black,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(20),
                                child: Text('Novo Agendamento',
                                    style: TextStyle(fontSize: 22)),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    labelText: 'Nome do agendamento',
                                  ),
                                  controller: _nomeAgendamento,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Insira um nome para seu agendamento';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          "Defina a hora da execução do agendamento"),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: IconButton(
                                              onPressed: () {
                                                selectTime(context);
                                              },
                                              icon: Icon(
                                                  Icons.access_time_outlined),
                                              color: Colors.white,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 10),
                                            child: Text(
                                                '${_time.hour}:${_time.minute.toString().padLeft(2, '0')}',
                                                style: TextStyle(fontSize: 16)),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        child: Text(
                                            'Defina os dias da semana que será executado'),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 5),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text("Seg"),
                                                Checkbox(
                                                  value: diasSemana[0]['seg'],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      diasSemana[0]['seg'] =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Ter"),
                                                Checkbox(
                                                  value: diasSemana[1]['ter'],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      diasSemana[1]['ter'] =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Qua"),
                                                Checkbox(
                                                  value: diasSemana[2]['qua'],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      diasSemana[2]['qua'] =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Qui"),
                                                Checkbox(
                                                  value: diasSemana[3]['qui'],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      diasSemana[3]['qui'] =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(10, 0, 10, 0),
                                        child: Row(
                                          children: [
                                            Row(
                                              children: [
                                                Text("Sex"),
                                                Checkbox(
                                                  value: diasSemana[4]['sex'],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      diasSemana[4]['sex'] =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Sab"),
                                                Checkbox(
                                                  value: diasSemana[5]['sab'],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      diasSemana[5]['sab'] =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text("Dom"),
                                                Checkbox(
                                                  value: diasSemana[6]['dom'],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      diasSemana[6]['dom'] =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(20),
                                        child: DropdownButtonFormField<
                                            Map<String, dynamic>>(
                                          isExpanded: true,
                                          validator: (value) {
                                            if (circuitosAdd.isEmpty) {
                                              return 'Insira algum circuito para seu agendamento.';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              borderSide: BorderSide(
                                                color: Color(0xFF012677),
                                                width: 2,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(20),
                                            ),
                                            fillColor: Colors.white,
                                            labelText: "Selecione o circuito",
                                            labelStyle: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          dropdownColor: Colors.black,
                                          value: circuitoSelect.isNotEmpty
                                              ? circuitoSelect
                                              : null,
                                          onChanged:
                                              (Map<String, dynamic>? value) {
                                            setState(() {
                                              circuitoSelect = value ?? {};
                                            });
                                          },
                                          items: circuitosConvertidos.map<
                                              DropdownMenuItem<
                                                  Map<String, dynamic>>>(
                                                  (Map<String, dynamic> circuito) {
                                                return DropdownMenuItem<
                                                    Map<String, dynamic>>(
                                                  value: circuito,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            EdgeInsets.symmetric(
                                                                horizontal: 10),
                                                            child: Icon(
                                                              IconData(
                                                                  circuito['icon'],
                                                                  fontFamily:
                                                                  'MaterialIcons'),
                                                              color: Colors.white,
                                                            ),
                                                          ),
                                                          Text(
                                                            circuito['nome'],
                                                            style: TextStyle(
                                                                color: Colors.white),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        " (circuito ${circuito['numero_circuito']})",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.white54),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                        ),
                                      ),
                                      Padding(
                                          padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 20),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Switch(
                                                thumbIcon: thumbIcon,
                                                value: liga_desliga,
                                                onChanged: (bool value) {
                                                  setState(() {
                                                    liga_desliga = value;
                                                  });
                                                },
                                              ),
                                              TextButton(
                                                  onPressed: () {
                                                    if (circuitoSelect
                                                        .isNotEmpty) {
                                                      circuitoSelect['estado'] =
                                                          liga_desliga;
                                                      for (var entry in circuitos
                                                          .asMap()
                                                          .entries) {
                                                        var index = entry.key;
                                                        var circuito =
                                                            entry.value;
                                                        if (circuito[
                                                        'numero_circuito'] ==
                                                            circuitoSelect[
                                                            'numero_circuito']) {
                                                          setState(() {
                                                            circuitosAdd.add(
                                                                circuitoSelect);
                                                            circuitoSelect = {};
                                                            circuitos
                                                                .removeAt(index);
                                                          });
                                                        }
                                                      }
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Text('Adicionar'),
                                                      Icon(
                                                        Icons.add,
                                                        size: 16,
                                                      )
                                                    ],
                                                  ))
                                            ],
                                          )),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(20, 0, 20, 20),
                                        child: Card(
                                          color: Colors.white,
                                          child: SizedBox(
                                            height: 100,
                                            width: 300,
                                            child: Container(
                                              padding: EdgeInsets.all(10),
                                              child: Column(
                                                children: [
                                                  circuitosAdd.isNotEmpty
                                                      ? Expanded(
                                                      child: ListView.builder(
                                                          itemCount:
                                                          circuitosAdd
                                                              .length,
                                                          itemBuilder:
                                                              (context,
                                                              index) {
                                                            var circuito =
                                                            circuitosAdd[
                                                            index];
                                                            return ListTile(
                                                              title: Text(
                                                                  circuito[
                                                                  'nome']),
                                                              subtitle:
                                                              Column(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Text(
                                                                      "Circuito ${circuito['numero_circuito']}"),
                                                                  Text(circuito['estado'] ==
                                                                      true
                                                                      ? 'Ligar'
                                                                      : 'Desligar'),
                                                                ],
                                                              ),
                                                              leading: Icon(
                                                                IconData(
                                                                    circuito[
                                                                    'icon'],
                                                                    fontFamily:
                                                                    'MaterialIcons'),
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              trailing:
                                                              IconButton(
                                                                onPressed:
                                                                    () {
                                                                  setState(
                                                                          () {
                                                                        circuitosAdd
                                                                            .removeAt(
                                                                            index);
                                                                        circuitos.add(
                                                                            circuito);
                                                                      });
                                                                },
                                                                icon: Icon(
                                                                  Icons
                                                                      .delete,
                                                                  size: 20,
                                                                  color: Colors
                                                                      .redAccent,
                                                                ),
                                                              ),
                                                            );
                                                          }))
                                                      : Expanded(
                                                      child: Center(
                                                        child: Text(
                                                            "Adicione os circuitos para seu agendamento.",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16)),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        EdgeInsets.fromLTRB(10, 0, 10, 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                        Icons.arrow_back_outlined,
                                                        size: 15),
                                                    Text('Voltar')
                                                  ],
                                                )),
                                            TextButton(
                                                onPressed: () {
                                                  if(_formKey.currentState!.validate()) {
                                                    var diasSend;
                                                    for(var dia in diasSemana) {
                                                      print(dia);
                                                    }
                                                    novoAgendamento(
                                                      _nomeAgendamento.text,
                                                      '${_time.hour}:${_time.minute.toString().padLeft(2, '0')}',


                                                    );
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    Text('Salvar'),
                                                    Icon(Icons.check, size: 15),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ],
                          )
                        )
                    )
                )
              ],
            ),
          ),
        ));
  }
}
