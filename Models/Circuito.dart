import 'package:flutter/material.dart';

class Circuito {
  String nome;
  String porta;
  IconData icon;
  int numero_circuito;

  Circuito(
      {required this.nome,
      required this.porta,
      required this.icon,
      required this.numero_circuito});
}

class CircuitoDB {
  int id;
  int id_dp;
  int numero_circuito;
  String nome;
  int estado;
  int porta;
  int icon;
  String updated_at;

  CircuitoDB(
      {required this.id,
      required this.id_dp,
      required this.numero_circuito,
      required this.nome,
      required this.estado,
      required this.porta,
      required this.icon,
      required this.updated_at});
}
