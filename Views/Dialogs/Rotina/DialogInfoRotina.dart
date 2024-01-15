import 'package:flutter/material.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Rotina/DialogEditRotina.dart';

class DialogInfoRotina extends StatefulWidget {
  final circuitos;
  final rotina;
  final circuitosRotina;
  final Function deletarRotina;
  final Function editarRotina;

  const DialogInfoRotina(
      {super.key,
      required this.circuitos,
      required this.rotina,
      required this.circuitosRotina,
      required this.deletarRotina,
      required this.editarRotina});

  @override
  State<DialogInfoRotina> createState() => _DialogInfoRotinaState(
        circuitos: circuitos,
        rotina: rotina,
        circuitosRotina: circuitosRotina,
        deletarRotina: deletarRotina,
        editarRotina: editarRotina,
      );
}

class _DialogInfoRotinaState extends State<DialogInfoRotina> {
  final circuitos;
  final rotina;
  final circuitosRotina;
  final Function deletarRotina;
  final Function editarRotina;

  _DialogInfoRotinaState({
    required this.circuitos,
    required this.rotina,
    required this.circuitosRotina,
    required this.deletarRotina,
    required this.editarRotina,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        height: 450,
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                rotina['nome'],
                style: const TextStyle(color: Colors.black, fontSize: 22),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: circuitos.length,
                  itemBuilder: (context, index) {
                    var circuito = circuitos[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                        title: Text(circuito['nome']),
                        leading: Icon(
                          IconData(circuito['icon'],
                              fontFamily: 'MaterialIcons'),
                          color: Colors.black,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Circuito ${circuito['numero_circuito']}"),
                            Text(circuitosRotina[index]['estado'] == true
                                ? 'Ligar'
                                : 'Desligar'),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => DialogEditRotina(
                              editarRotina: editarRotina, rotina: rotina));
                    },
                    child: const Icon(
                      Icons.edit,
                      color: Colors.blueAccent,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                backgroundColor: Colors.white,
                                title: Text(
                                    "Deseja deletar a rotina '${rotina['nome']}'?"),
                                actions: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Row(
                                            children: [
                                              Icon(
                                                Icons.arrow_back,
                                                color: Colors.redAccent,
                                              ),
                                              Text(
                                                "Cancelar",
                                                style: TextStyle(
                                                    color: Colors.redAccent),
                                              )
                                            ],
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            deletarRotina(rotina['id']);
                                            Navigator.pop(context);
                                          },
                                          child: const Row(
                                            children: [
                                              Text("Deletar",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.blueAccent)),
                                              Icon(
                                                Icons.delete,
                                                color: Colors.blueAccent,
                                              ),
                                            ],
                                          ))
                                    ],
                                  )
                                ],
                              ));
                    },
                    child: Icon(Icons.delete, color: Colors.redAccent),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.arrow_back,
                        color: Colors.blueAccent,
                      ),
                      Text('Voltar')
                    ],
                  ),
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
