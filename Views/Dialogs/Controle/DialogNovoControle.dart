// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class DialogNovoControle extends StatefulWidget {
  final Function novoControle;

  const DialogNovoControle({super.key, required this.novoControle});
  @override
  State<DialogNovoControle> createState() => _DialogNovoControleState(novoControle: novoControle);
}

class _DialogNovoControleState extends State<DialogNovoControle> {
  final Function novoControle;

  _DialogNovoControleState({required this.novoControle});

  final TextEditingController _nome = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? marcaSelecionada;
  List<String> marcas = [
    'LG',
    'Samsung',
    'Gree',
    'Panasonic',
  ];

  String? tipoSelecionado;
  List<String> tipos = [
    'TV',
    'Central de Ar'
  ];

  @override
  Widget build(BuildContext context) {
    return Dialog.fullscreen(
      backgroundColor: Color(0xFF012677),
      child: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
                        child: Text(
                          "Novo Controle",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    labelText: 'Nome do controle',
                                  ),
                                  controller: _nome,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Insira um nome para o controle.';
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
                                    DropdownButtonFormField<String>(
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
                                        labelText: "Selecione o tipo do controle",
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      dropdownColor: Colors.black,
                                      value: tipoSelecionado,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Selecione o tipo do controle.';
                                        }
                                        return null;
                                      },
                                      onChanged: (newValue) {
                                        setState(() {
                                          tipoSelecionado = newValue;
                                        });
                                      },
                                      items: tipos.map<DropdownMenuItem<String>>(
                                            (String tipos) {
                                          return DropdownMenuItem<String>(
                                            value: tipos,
                                            child: Text(tipos, style: TextStyle(color: Colors.white),),
                                          );
                                        },
                                      ).toList(),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DropdownButtonFormField<String>(
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
                                        labelText: "Selecione a marca do seu controle",
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Selecione a marca do controle.';
                                        }
                                        return null;
                                      },
                                      dropdownColor: Colors.black,
                                      value: marcaSelecionada,
                                      onChanged: (newValue) {
                                        setState(() {
                                          marcaSelecionada = newValue;
                                        });
                                      },
                                      items: marcas.map<DropdownMenuItem<String>>(
                                            (String marca) {
                                          return DropdownMenuItem<String>(
                                            value: marca,
                                            child: Text(marca, style: TextStyle(color: Colors.white),),
                                          );
                                        },
                                      ).toList(),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: TextButton(
                              onPressed: (){
                                Navigator.pop(context);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.arrow_back_outlined, size: 16, color: Colors.redAccent,),
                                  Text("Voltar", style: TextStyle(color: Colors.redAccent),)
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: TextButton(
                              onPressed: (){
                                if(_formKey.currentState!.validate()){
                                  novoControle(_nome.text,tipoSelecionado, marcaSelecionada);
                                  Navigator.pop(context);
                                }
                              },
                              child: Row(
                                children: [
                                  Text("Salvar"),
                                  Icon(Icons.done, size: 16,),
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )),
      )
    );
  }
}
