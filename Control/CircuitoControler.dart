import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:thunder_monkey_app/Control/DispositivoControler.dart';
import 'package:thunder_monkey_app/Models/Rotinas.dart';
import '../Models/Circuito.dart';

String urlBase = "http://172.16.1.18/API-ThuderMonkey/public/api";

class CircuitoControler {
  static Future<void> enviarCircuitos(circuitos, idDp) async {
    final List<Map<String, dynamic>> circuitosSend = [];
    for (Circuito circuito in circuitos) {
      Map<String, dynamic> circuitoData = {
        'id_dp': idDp,
        'nome': circuito.nome,
        'porta': circuito.porta,
        'icon': circuito.icon.codePoint,
        'numero_circuito': circuito.numero_circuito
      };
      circuitosSend.add(circuitoData);
    }
    final response = await http.post(
      Uri.parse("$urlBase/circuito/adicionar_circuitos"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(circuitosSend),
    );
  print(response.body);
  }

  static Future<void> novoCircuito(List<Map<String, dynamic>> circuitos) async {
    final response = await http.post(
      Uri.parse("$urlBase/circuito/novo_circuito"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(circuitos),
    );
    print(response.body);
  }

  static Future<List<CircuitoDB>> recuperarCircuitos(idDp) async {
    http.Response response = await http
        .get(Uri.parse("$urlBase/circuito/recuperar_circuitos/$idDp/app"));
    var dadosJson = jsonDecode(response.body);

    List<CircuitoDB> circuitos =
        List<CircuitoDB>.from(dadosJson.map((circuito) {
      return CircuitoDB(
          id: circuito['id'],
          id_dp: circuito['id_dp'],
          numero_circuito: circuito['numero_circuito'],
          nome: circuito['nome'],
          estado: circuito['estado'],
          porta: circuito['porta'],
          icon: circuito['icon'],
          updated_at: circuito['updated_at']);
    }));
    return circuitos;
  }

  static Future<http.Response> liga_desliga(idDp, state, circuito) {
    return http.patch(
      Uri.parse("$urlBase/circuito/liga_desliga"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_dp': idDp,
        'state': state,
        'circuito': circuito
      }),
    );
  }

  static Future deletarCircuito(circuitoDelete) async {
    http.Response response =
        await http.delete(Uri.parse("$urlBase/circuito/deletar_circuito"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: circuitoDelete);
  }

  static Future atualizar_circuito(circuitoEdit) async {
    http.Response response =
        await http.put(Uri.parse("$urlBase/circuito/atualizar_circuito"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: circuitoEdit);
    return response.body;
  }

  static Future executar_rotina(rotina) async {
    rotina = jsonEncode(rotina);
    http.put(
      Uri.parse("$urlBase/circuito/executar_comando/app"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: rotina
    );
  }

}
