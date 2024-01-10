import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:thunder_monkey_app/Control/DispositivoControler.dart';
String urlBase = "http://172.16.0.90/API-ThuderMonkey/public/api";

class RotinaControler {

  static Future<List> recuperar_rotinas() async {
    int? idDp = await DispositivoControler.recuperarIdDP();

    http.Response response = await http.get(
      Uri.parse("$urlBase/rotina/recuperar_rotinas/$idDp"),
    );
    var dadosJson = jsonDecode(response.body);
    var rotina;
    List rotinas = [];
    for (rotina in dadosJson) {
      rotinas.add(
          {
            "id": rotina['id'],
            "id_dp": rotina['id_dp'],
            "circuitos": rotina['circuitos'],
            "nome": rotina['nome'],
            "updated_at": rotina['updated_at']
          }
      );
    }
    return rotinas;
  }

  static Future adicionar_rotina(circuitosRotina, nomeRotina, idDp) async {
    var circuitosSend = jsonEncode(circuitosRotina);
    await http.post(
        Uri.parse("$urlBase/rotina/criar_rotina"),
        body: {
          'id_dp': idDp.toString(),
          'circuitos': circuitosSend,
          'nome': nomeRotina
        }
    );
  }

  static Future editar_rotina(idRotina, circuitos, nome) async{
    var circuitosSend = jsonEncode(circuitos);
    print(idRotina);
    print(circuitosSend);
    print(nome);
    await http.put(
      Uri.parse("$urlBase/rotina/atualizar_rotina"),
      body:  {
        'id_rotina': idRotina.toString(),
        'nome': nome,
        'circuitos': circuitosSend
      }
    );
  }

  static Future delelar_rotina(idRotina) async {
    await http.delete(
      Uri.parse("$urlBase/rotina/deletar_rotina"),
      body: {
        "id_rotina": idRotina.toString()
      }
    );
  }
}