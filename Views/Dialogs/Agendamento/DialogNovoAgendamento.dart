// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogNovoAgendamento extends StatefulWidget {
  const DialogNovoAgendamento({super.key});


  @override
  State<DialogNovoAgendamento> createState() => _DialogNovoAgendamentoState();
}

class _DialogNovoAgendamentoState extends State<DialogNovoAgendamento> {

  TextEditingController _nomeAgendamento = TextEditingController();

  TimeOfDay _time = TimeOfDay.now();
  late String formattedTime;

  late TimeOfDay picked;


  Future<Null> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
      helpText: 'Defina a hora do seu agendamento.',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: Colors.blue,
            hintColor: Colors.blueAccent,
          ),
          child: child!,
        );
      },

    ))!;
    setState(() {
      _time = picked;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime dateTimeNow = DateTime.now().toUtc().add(Duration(hours: -4));
    _time = TimeOfDay.fromDateTime(dateTimeNow);
  }

  @override
  Widget build(BuildContext context) {
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
                            padding: EdgeInsets.all(20),
                            child: Text('Novo Agendamento', style: TextStyle(fontSize: 22)),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: 'Nome do agendamento',
                            ),
                            controller: _nomeAgendamento,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Insira um nome para sua rotina';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Defina a hora da execução do agendamento"),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: IconButton(
                                      onPressed: (){
                                        selectTime(context);
                                      },
                                      icon: Icon(Icons.access_time_outlined), color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                      child: Text('${_time.hour}:${_time.minute.toString().padLeft(2, '0')}', style: TextStyle(fontSize: 16)),
                                  ),
                                ],
                              )
                            ],
                          )
                        ),


                      ],
                    )
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
