// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunder_monkey_app/Models/Circuito.dart';

import '../../../Control/CircuitoControler.dart';

class DialogNovaRotina extends StatefulWidget {
  final Function adicionarRotina;
  const DialogNovaRotina({super.key, required this.adicionarRotina});

  @override
  State<DialogNovaRotina> createState() =>
      _DialogNovaRotinaState(adicionarRotina: adicionarRotina);
}

class _DialogNovaRotinaState extends State<DialogNovaRotina> {
  final Function adicionarRotina;
  final TextEditingController _nomeRotina = TextEditingController();
  _DialogNovaRotinaState({ required this.adicionarRotina});

  final _formKey = GlobalKey<FormState>();

  var circuitos = [];
  late int? idDp;

  @override
  void initState() {
    super.initState();
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


  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.flash_on);
      }
      return const Icon(Icons.flash_off);
    },
  );

  bool liga_desliga = true;
  List circuitosAdd = [];
  Map<String, dynamic>  circuitoSelect = {};

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> circuitosConvertidos =
        List<Map<String, dynamic>>.from(circuitos);
    return Dialog.fullscreen(
      backgroundColor: Color(0xFF012677),
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Card(
                  color: Colors.black,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: Text(
                          'Nova Rotina',
                          style: TextStyle(fontSize: 22),
                        ),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    labelText: 'Nome da rotina',
                                  ),
                                  controller: _nomeRotina,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Insira um nome para sua rotina';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(20),
                                child:
                                DropdownButtonFormField<Map<String, dynamic>>(
                                  isExpanded: true,
                                  validator: (value) {
                                    if (circuitosAdd.isEmpty) {
                                      return 'Insira algum circuito para sua rotina.';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide: BorderSide(
                                        color: Color(0xFF012677),
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    fillColor: Colors.white,
                                    labelText: "Selecione o circuito",
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  dropdownColor: Colors.black,
                                  value: circuitoSelect.isNotEmpty ? circuitoSelect : null,
                                  onChanged: (Map<String, dynamic>? value) {
                                    setState(() {
                                      circuitoSelect = value ?? {};
                                    });
                                  },
                                  items: circuitosConvertidos
                                      .map<DropdownMenuItem<Map<String, dynamic>>>(
                                          (Map<String, dynamic> circuito) {
                                        return DropdownMenuItem<Map<String, dynamic>>(
                                          value: circuito,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                                    child: Icon(
                                                      IconData(circuito['icon'], fontFamily: 'MaterialIcons'),
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    circuito['nome'],
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                " (circuito ${circuito['numero_circuito']})",
                                                style: TextStyle(fontSize: 12, color: Colors.white54),
                                              )
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
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
                                            if(circuitoSelect.isNotEmpty) {
                                              circuitoSelect['estado'] = liga_desliga;
                                              for(var entry in circuitos.asMap().entries) {
                                                var index = entry.key;
                                                var circuito = entry.value;
                                                if (circuito['numero_circuito'] == circuitoSelect['numero_circuito']) {
                                                  setState(() {
                                                    circuitosAdd.add(circuitoSelect);
                                                    circuitoSelect = {};
                                                    circuitos.removeAt(index);
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
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                child: Card(
                                  color: Colors.white,
                                  child: SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Column(
                                        children: [
                                          circuitosAdd.isNotEmpty
                                              ? Expanded(
                                              child: ListView.builder(
                                                  itemCount:
                                                  circuitosAdd.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    var circuito =
                                                    circuitosAdd[index];
                                                    return ListTile(
                                                      title: Text(
                                                          circuito['nome']),
                                                      subtitle: Column(
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
                                                            circuito['icon'],
                                                            fontFamily:
                                                            'MaterialIcons'),
                                                        color: Colors.black,
                                                      ),
                                                      trailing: IconButton(
                                                        onPressed: (){
                                                          setState(() {
                                                            circuitosAdd.removeAt(index);
                                                            circuitos.add(circuito);
                                                          });
                                                        },
                                                        icon: Icon(Icons.delete, size: 20, color: Colors.redAccent,),
                                                      ),
                                                    );
                                                  }))
                                              : Expanded(
                                              child: Center(
                                                child: Text("Adicione os circuitos para sua rotina.",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 16
                                                    )),
                                              )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back_outlined, size: 15,),
                                            Text("Voltar")
                                          ],
                                        )
                                    ),
                                    TextButton(
                                        onPressed: (){
                                          if(_formKey.currentState!.validate()) {
                                            adicionarRotina(circuitosAdd, _nomeRotina.text);
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Text("Salvar"),
                                            Icon(Icons.check, size: 15,),
                                          ],
                                        )
                                    )
                                  ],
                                ),
                              )
                            ],

                          )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}
