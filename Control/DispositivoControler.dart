import 'dart:convert';
import 'dart:ffi';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:thunder_monkey_app/Models/Dispositivo.dart';
String urlBase = "http://172.16.0.90/API-ThuderMonkey/public/api";
class DispositivoControler {
  // Método para verificar o login usando shared_preferences
  static Future<bool> verificarLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? idDp = prefs.getInt('idDp');
    return idDp != null;
  }

  static Future<List<Dispositivo>> recuperarDispositivo(nSerie) async {
    http.Response response = await http.get(Uri.parse("$urlBase/dispositivo/recuperar_dispositivo/numero_serie/$nSerie"));
    var dadosJson = jsonDecode(response.body);
    List<Dispositivo> dispositivo = List<Dispositivo>.from(dadosJson.map((dispositivo) {
      return Dispositivo(dispositivo["id"], dispositivo["nSerie"], dispositivo["senha"], dispositivo["primeiro_acesso"], dispositivo["updated_at"]);
    }));

    return dispositivo;
  }

  static Future<http.Response> atualizarSenha(int id, String senha) async {
      return http.patch(
        Uri.parse("$urlBase/dispositivo/atualizar_dispositivo/senha"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': id,
          'senha': senha,
        }),
      );
  }

  static Future salvarUsuario(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('idDp', id);
  }

  static Future<int?> recuperarIdDP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? idDp = prefs.getInt('idDp');
    return idDp;
  }

  static Future<http.Response> atualizarPrimeiroAcesso(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('idDp', id);

    return http.patch(
      Uri.parse("$urlBase/dispositivo/atualizar_dispositivo/primeiro_acesso"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id': id,
      }),
    );
  }


}