// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class DialogInfoAgendamento extends StatefulWidget {
  final agendamento;
  final circuitos;
  final circuitosAgendamento;
  final Function deletarAgendamento;
  final Function editarAgendamento;

  const DialogInfoAgendamento({super.key, required this.agendamento,required this.circuitos, required this.circuitosAgendamento, required this.deletarAgendamento, required this.editarAgendamento});

  @override
  State<DialogInfoAgendamento> createState() => _DialogInfoAgendamentoState(agendamento: agendamento, circuitos: circuitos, circuitosAgendamento: circuitosAgendamento, deletarAgendamento: deletarAgendamento, editarAgendamento: editarAgendamento);
}

class _DialogInfoAgendamentoState extends State<DialogInfoAgendamento> {

  final agendamento;
  final circuitos;
  final circuitosAgendamento;
  final Function deletarAgendamento;
  final Function editarAgendamento;

  _DialogInfoAgendamentoState({ required this.agendamento, required this.circuitos, required this.circuitosAgendamento, required this.deletarAgendamento, required this.editarAgendamento});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: SizedBox(
        height: 450,
        width: 450,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                agendamento['nome'],
                style: TextStyle(color: Colors.black, fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
