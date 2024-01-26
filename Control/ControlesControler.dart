import 'package:http/http.dart' as http;
import 'package:thunder_monkey_app/Control/DispositivoControler.dart';
String urlBase = "http://172.16.1.179/API-ThuderMonkey/public/api";

class ControlesControler {

  static Future recuperarControles() async {

    var idDp = await DispositivoControler.recuperarIdDP();

    http.Response response = await http.get(
      Uri.parse("$urlBase/aircontroll/recuperar_controles/$idDp/app"),
    );

    return response.body;
  }

}