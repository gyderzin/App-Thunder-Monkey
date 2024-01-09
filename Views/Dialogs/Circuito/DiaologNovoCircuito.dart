// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DialogNovoCircuito extends StatefulWidget {
  final Function adicionarCircuitoCallback;

  const DialogNovoCircuito({required this.adicionarCircuitoCallback, super.key});

  @override
  State<DialogNovoCircuito> createState() => _DialogNovoCircuitoState(adicionarCircuitoCallback: adicionarCircuitoCallback);
}

class _DialogNovoCircuitoState extends State<DialogNovoCircuito> {
  final Function adicionarCircuitoCallback;
  _DialogNovoCircuitoState({required this.adicionarCircuitoCallback});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _porta = TextEditingController();
  IconData selectedIcon = Icons.lightbulb;

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
        backgroundColor: const Color(0xFF012677),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Card(
                  color: Colors.black,
                  child: SizedBox(
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                              child: Text(
                                "Novo Circuito",
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      labelText: 'Nome do circuito',
                                    ),
                                    controller: _nome,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Insira um nome para o circuito.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 0, 30, 20),
                                  child: TextFormField(
                                    style: const TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    decoration: InputDecoration(
                                      border: const UnderlineInputBorder(),
                                      labelText: 'Porta lógica do ESP32',
                                    ),
                                    controller: _porta,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Insira uma porta lógica.';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      DropdownButtonFormField(
                                        decoration: InputDecoration(
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            borderSide: BorderSide(
                                                color: Color(0xFF012677),
                                                width: 2),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          fillColor: Colors.white,
                                          labelText: "Selecione o ícone do seu circuito",
                                          labelStyle: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        dropdownColor: Colors.black,
                                        value: selectedIcon,
                                        onChanged: (IconData? newValue) {
                                          if (newValue != null) {
                                            setState(() {
                                              selectedIcon = newValue;
                                            });
                                          }
                                        },
                                        items: [
                                          Icon(Icons.tv),
                                          Icon(Icons.light_mode),
                                          Icon(Icons.roofing_sharp),
                                          Icon(Icons.house),
                                          Icon(Icons.balcony),
                                          Icon(Icons.yard),
                                          Icon(Icons.garage),
                                          Icon(Icons.outlet),
                                          Icon(Icons.mode_night_outlined),
                                          Icon(Icons.lightbulb),
                                          Icon(Icons.light_outlined),
                                          Icon(Icons.wind_power),
                                        ].map<DropdownMenuItem<IconData>>(
                                            (Icon icon) {
                                          return DropdownMenuItem<IconData>(
                                            value: icon.icon,
                                            child: IconTheme(
                                              data: IconThemeData(
                                                color: Colors.white,
                                                size:
                                                    24.0, // Ajuste o tamanho do ícone conforme necessário
                                              ),
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: icon,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      )
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: EdgeInsets.all(20),
                                    child:  TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.arrow_back, size: 16, color: Colors.redAccent,),
                                            Text(
                                                "Voltar",
                                                style: TextStyle(
                                                  color: Colors.redAccent
                                                ),
                                            ),
                                          ],
                                        )
                                    )
                                ),
                                Padding(
                                    padding: EdgeInsets.all(20),
                                    child:  TextButton(
                                        onPressed: () {
                                          if(_formKey.currentState!.validate()) {
                                            adicionarCircuitoCallback({
                                              "nome": _nome.text,
                                              "porta": _porta.text,
                                              "icon": selectedIcon,
                                            });
                                            Navigator.pop(context);
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Text("Salvar"),
                                            Icon(Icons.done, size: 16,),
                                          ],

                                        )
                                    )
                                ),

                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
