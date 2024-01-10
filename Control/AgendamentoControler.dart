import 'package:http/http.dart' as http;
String urlBase = "http://172.16.0.90/API-ThuderMonkey/public/api";

class AgendamentoControler {

  static Future recuperar_agendamentos(idDp) async {
    http.Response response = await http.get(
      Uri.parse("$urlBase/agendamento/recuperar_agendamentos/app/$idDp")
    );
    return response.body;
  }

}