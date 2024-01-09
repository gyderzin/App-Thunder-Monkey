// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:thunder_monkey_app/Views/PrimeiroAcesso/ConfiguracaoCircuitos.dart';

class BemVindo extends StatefulWidget {
  final int idDp;
  const BemVindo({super.key, required this.idDp});

  @override
  State<BemVindo> createState() => _BemVindoState(idDp: idDp);
}

class _BemVindoState extends State<BemVindo> {
  final int idDp;
  _BemVindoState({required this.idDp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/logo2.png", scale: 2),
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        // actions: [
        //   IconButton(
        //     icon: const Icon(Icons.done_sharp, color: Colors.white),
        //     tooltip: 'Finalizar',
        //     onPressed: () {},
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.91,
            color: Color(0xFF012677),
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Card(
                  color: Colors.black,
                  child: SizedBox(
                    width: 400,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Bem Vindo",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                fontFamily: 'Roboto'),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "Olá, como é sua primeira vez por aqui, nós vamos fazer as configurações iniciais dos seus circuitos.",
                            style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          child: Text(
                            "Você precisa configurar colocando um nome para o circuito e selecionando a porta lógica do seu ESP32 que fará o controle do mesmo, de acordo com a instalação feita.",
                            style: TextStyle(fontSize: 16, fontFamily: 'Roboto'),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConfiguracaoCircuitos(idDp: idDp,)));
                                  },
                                  style: ButtonStyle(
                                      backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xFFEBECF2))),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      Text(
                                        "Avançar",
                                        style:
                                        TextStyle(color: Color(0xFF0468BF)),
                                      ),
                                      Icon(Icons.arrow_forward,
                                          color: Color(0xFF0468BF))
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
