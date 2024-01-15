import 'dart:convert';

import 'package:http/http.dart' as http;
String urlBase = "http://192.168.100.89/API-ThuderMonkey/public/api";

class AgendamentoControler {

  static Future recuperar_agendamentos(idDp) async {
    http.Response response = await http.get(
      Uri.parse("$urlBase/agendamento/recuperar_agendamentos/app/$idDp")
    );
    return response.body;
  }

  static Future adicionar_agendamento(idDp,nome, hora, dias, circuitos) async {
     http.Response response = await http.post(
      Uri.parse("$urlBase/agendamento/novo_agendamento"),
      body: {
        'id_dp': idDp.toString(),
        'nome': nome,
        'hora': hora,
        'intervalo_dias': dias,
        'circuitos': jsonEncode(circuitos)
      }
    );
      print(response.body);
  }

}
