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
     await http.post(
      Uri.parse("$urlBase/agendamento/novo_agendamento"),
      body: {
        'id_dp': idDp.toString(),
        'nome': nome,
        'hora': hora,
        'intervalo_dias': dias,
        'circuitos': jsonEncode(circuitos)
      }
    );

  }

  static Future editar_agendamento(idAgendamento, nome, hora, dias, circuitos) async {
    http.Response response = await http.put(
      Uri.parse("$urlBase/agendamento/atualizar_agendamentos"),
      body: {
        'id': idAgendamento.toString(),
        'nome': nome,
        'hora': hora,
        'intervalo_dias': dias,
        'circuitos': jsonEncode(circuitos)
      }
    );
  }

  static Future excluir_agendamento (id) async {
    await http.delete(
      Uri.parse("$urlBase/agendamento/deletar_agendamento"),
      body: {
        'id': id.toString()
      }
    );
  }

}
