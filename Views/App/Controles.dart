// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:thunder_monkey_app/Control/ControlesControler.dart';
import 'package:thunder_monkey_app/Control/DispositivoControler.dart';

class Controles extends StatefulWidget {
  const Controles({super.key});

  @override
  State<Controles> createState() => _ControlesState();
}

class _ControlesState extends State<Controles> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ControlesControler.recuperarControles(),
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
                              onPressed: () {},
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
                         child:  GridView.builder(
                             itemCount: lista.length,
                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 2,
                               mainAxisExtent: 230,
                               crossAxisSpacing: 15,
                               mainAxisSpacing: 15,
                             ),
                             itemBuilder: (context, index) {
                               var controle = lista[index];
                                return Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Text(
                                            controle['nome'],
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 15
                                            ),
                                          ),
                                      ),
                                      Row(
                                        children: [

                                        ],
                                      )
                                    ],
                                  )
                                );
                             }
                         ),
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
