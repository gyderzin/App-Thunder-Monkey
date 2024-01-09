import 'package:flutter/material.dart';
import 'package:thunder_monkey_app/Models/Circuito.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Circuito/DialogEditCircuito.dart';

class DialogInfoCircuito extends StatefulWidget {
  final CircuitoDB circuito;
  final Function editarCircuito;
  final Function deletarCircuito;
  const DialogInfoCircuito(
      {super.key, required this.circuito, required this.editarCircuito, required this.deletarCircuito});

  @override
  State<DialogInfoCircuito> createState() => _DialogInfoCircuitoState(
      circuito: circuito, editarCircuito: editarCircuito, deletarCircuito: deletarCircuito);
}

class _DialogInfoCircuitoState extends State<DialogInfoCircuito> {
  final CircuitoDB circuito;
  final Function deletarCircuito;
  final Function editarCircuito;

  void editarCircuitoInter(index, circuitoEdit) {
    var circuitoEdited = {
      'id_dp': circuito.id_dp,
      'numero_circuito': circuito.numero_circuito,
      'nome': circuitoEdit['nome'],
      'porta': circuitoEdit['porta'],
      'icon': (circuitoEdit['icon'] as IconData).codePoint,
    };
    editarCircuito(circuitoEdited);
    Navigator.pop(context);
  }

  _DialogInfoCircuitoState(
      {required this.circuito, required this.editarCircuito, required this.deletarCircuito});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
          height: 260,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Circuito ${circuito.numero_circuito}",
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  ListTile(
                      title: Text(circuito.nome),
                      subtitle: Text("Porta: ${circuito.porta}"),
                      leading: Icon(
                        IconData(circuito.icon, fontFamily: "MaterialIcons"),
                        color: Colors.black,
                      ),
                      trailing: IconButton(
                          onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) =>
                                  DialogEditCircuito(
                                    editarCircuitoCallback: editarCircuitoInter,
                                    index: 1,
                                    circuitoEdit: circuito,
                                    pai: 'DialogInfo',
                                  )),
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blueAccent,
                            size: 18,
                          ))),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              backgroundColor: Colors.white,
                              title:
                                  const Text('Deseja deletar este circuito?'),
                              content: ListTile(
                                title: Text(circuito.nome),
                                subtitle: Text("Porta: ${circuito.porta}"),
                                leading: Icon(
                                  IconData(circuito.icon,
                                      fontFamily: "MaterialIcons"),
                                  color: Colors.black,
                                ),
                              ),
                              actions: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Row(
                                        children: [
                                          Icon(Icons.arrow_back, size: 15, color: Colors.redAccent,),
                                          Text(
                                            'Cancelar',
                                            style:
                                            TextStyle(color: Colors.redAccent),
                                          ),
                                        ],
                                      )
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deletarCircuito(circuito);
                                        Navigator.pop(context);
                                      },
                                      child: const Row(
                                        children: [
                                          Text('Deletar'),
                                          Icon(Icons.delete, size: 15,),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                          size: 22,
                        )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Row(
                            children: [
                              Icon(Icons.arrow_back_outlined, size: 15),
                              Text("Voltar")
                            ],
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ))),
    );
  }
}
