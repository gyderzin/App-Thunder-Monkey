// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:thunder_monkey_app/Control/CircuitoControler.dart';
import 'package:thunder_monkey_app/Control/DispositivoControler.dart';
import 'package:thunder_monkey_app/Models/Circuito.dart';
import 'package:thunder_monkey_app/Views/App/Home.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Circuito/DialogEditCircuito.dart';
import '../Dialogs/Circuito/DiaologNovoCircuito.dart';

class ConfiguracaoCircuitos extends StatefulWidget {
  final int idDp;
  const ConfiguracaoCircuitos({super.key, required this.idDp});

  @override
  State<ConfiguracaoCircuitos> createState() =>
      _ConfiguracaoCircuitosState(idDp: idDp);
}

class _ConfiguracaoCircuitosState extends State<ConfiguracaoCircuitos> {
  @override
  final int idDp;
  _ConfiguracaoCircuitosState({required this.idDp});

  final List<Circuito> circuitos = [];

  Future<void> adicionarCircuito(Map<String, Object> circuitoInfo) async {
    print(circuitos.length);
    Circuito novoCircuito = Circuito(
        nome: circuitoInfo['nome'] as String,
        porta: circuitoInfo['porta'] as String,
        icon: circuitoInfo['icon'] as IconData,
        numero_circuito: circuitos.length + 1);
    setState(() {
      circuitos.add(novoCircuito);
      print(circuitos.length);
    });
  }

  Future<void> editarCircuito(int index, circuitoEdit) async {
    Circuito editedCircuito = Circuito(
        nome: circuitoEdit['nome'] as String,
        porta: circuitoEdit['porta'] as String,
        icon: circuitoEdit['icon'] as IconData,
        numero_circuito: index + 1);
    setState(() {
      circuitos[index] = editedCircuito;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/logo2.png", scale: 2),
        centerTitle: true,
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.done_sharp, color: Colors.white),
            tooltip: 'Finalizar',
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text(
                  'Tudo pronto?',
                  style: TextStyle(color: Colors.white),
                ),
                content: const Text(
                    'Ao confirmar, você está salvando os circuitos criados aqui e terá concluído as configurações iniciais.'),
                backgroundColor: Colors.black,
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () {
                          CircuitoControler.enviarCircuitos(circuitos, idDp)
                              .then((value) => {
                                    DispositivoControler
                                            .atualizarPrimeiroAcesso(idDp)
                                        .then((value) => {
                                              Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home()),
                                                (route) => false,
                                              )
                                            })
                                  });
                        },
                        child: const Text('Confirmar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Container(
          color: const Color(0xFF012677),
          padding: EdgeInsets.all(10),
          child: Card(
            color: Colors.black,
            child: SizedBox(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 30)),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text("Circuitos",
                            style: TextStyle(
                              fontSize: 22,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: TextButton(
                          onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  DialogNovoCircuito(
                                    adicionarCircuitoCallback:
                                        adicionarCircuito,
                                  )),
                          child: Icon(Icons.add),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Expanded(
                      child: circuitos.isNotEmpty
                          ? ListView.builder(
                              itemCount: circuitos.length,
                              itemBuilder: (BuildContext context, int index) {
                                var circuito = circuitos[index];
                                return ListTile(
                                  title: Text(
                                    circuito.nome,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Circuito: ${circuito.numero_circuito}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "Porta: ${circuito.porta}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                              onPressed: () => showDialog<
                                                      String>(
                                                  context: context,
                                                  builder: (BuildContext
                                                          context) =>
                                                      DialogEditCircuito(
                                                        editarCircuitoCallback:
                                                            editarCircuito,
                                                        index: index,
                                                        circuitoEdit:
                                                            circuitos[index],
                                                        pai: 'PrimeiroAcesso',
                                                      )),
                                              icon: Icon(Icons.edit,
                                                  size: 16,
                                                  color: Colors.lightBlue)),
                                          IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  circuitos.removeAt(index);
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                size: 16,
                                                color: Colors.redAccent,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  leading: Icon(
                                    IconData(circuito.icon.codePoint,
                                        fontFamily: "MaterialIcons"),
                                    color: Colors.white,
                                  ),
                                );
                              })
                          : Text(
                              "Clique no botao + a esquerda para adicionar um circuito",
                              style: TextStyle(color: Colors.white),
                            )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
