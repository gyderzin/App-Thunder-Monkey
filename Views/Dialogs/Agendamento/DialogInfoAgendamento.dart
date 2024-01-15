// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:thunder_monkey_app/Views/Dialogs/Agendamento/DialogEditAgendamento.dart';

class DialogInfoAgendamento extends StatefulWidget {
  final agendamento;
  final circuitos;
  final circuitosAgendamento;
  final Function deletarAgendamento;
  final Function editarAgendamento;

  const DialogInfoAgendamento(
      {super.key,
      required this.agendamento,
      required this.circuitos,
      required this.circuitosAgendamento,
      required this.deletarAgendamento,
      required this.editarAgendamento});

  @override
  State<DialogInfoAgendamento> createState() => _DialogInfoAgendamentoState(
      agendamento: agendamento,
      circuitos: circuitos,
      circuitosAgendamento: circuitosAgendamento,
      deletarAgendamento: deletarAgendamento,
      editarAgendamento: editarAgendamento);
}

class _DialogInfoAgendamentoState extends State<DialogInfoAgendamento> {
  final agendamento;
  final circuitos;
  final circuitosAgendamento;
  final Function deletarAgendamento;
  final Function editarAgendamento;

  _DialogInfoAgendamentoState(
      {required this.agendamento,
      required this.circuitos,
      required this.circuitosAgendamento,
      required this.deletarAgendamento,
      required this.editarAgendamento});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: 550,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                agendamento['nome'],
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 5, 20),
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
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Text(
                          agendamento['intervalo_dias'] ==
                                  'seg, ter, qua, qui, sex, sab, dom'
                              ? 'Todos os dias'
                              : agendamento['intervalo_dias'],
                          style: TextStyle(color: Colors.black, fontSize: 12),
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
                              fontFamily: 'Roboto'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Text(
                          agendamento['hora'],
                          style: TextStyle(color: Colors.black, fontSize: 13),
                        ),
                      ),
                    ],
                  )
                ],
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
                            Text(circuitosAgendamento[index]['estado'] == true
                                ? 'Ligar'
                                : 'Desligar'),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) =>
                                DialogEditAgendamento(
                                  editAgendamento: editarAgendamento,
                                  agendamento: agendamento,
                                ));
                      },
                      icon: Icon(Icons.edit, color: Colors.lightBlue)),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete, color: Colors.redAccent))
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [Icon(Icons.arrow_back), Text('Voltar')],
                        ))
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
