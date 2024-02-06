import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thunder_monkey_app/Control/DispositivoControler.dart';
import 'package:thunder_monkey_app/Models/Conexao.dart';

Conexao conexao = Conexao();
String urlBase = conexao.urlBase;

class ControlesControler {
  static Future recuperarControles() async {
    var idDp = await DispositivoControler.recuperarIdDP();

    http.Response response = await http.get(
      Uri.parse("$urlBase/controll/recuperar_controles/$idDp/app"),
    );

    return response.body;
  }

  static Future atualizarAirControll(idControle, controle) async {

    List<Map<String, dynamic>> controleSend = [];
    
    controle.forEach((key, value) {
      Map<String, dynamic> obj = {key: value};
      controleSend.add(obj);
    });
    http.Response response = await http.patch(
      Uri.parse("$urlBase/controll/atualizar_controle"),
      body: {
        'id_controle': idControle.toString(),
        'controle': jsonEncode(controleSend)
      }
    );
  }

  static Future atualizarTVControll(idControle, controle) async {
    print(idControle.toString());
    if(controle['controle'] == 1){
      controle['controle'] = 0;
    } else if(controle['controle'] == 0) {
      controle['controle'] = 1;
    }
    var controleSend = [
      {"comando": controle["comando"]},
      {"controle": controle["controle"]}
    ];
    await http.patch(
      Uri.parse("$urlBase/controll/atualizar_controle"),
        body: {
          'id_controle': idControle.toString(),
          'controle': jsonEncode(controleSend)
        }
    );
  }

  static Future novoControle(nome, tipo, marca) async {
    var controleSend;
    if(tipo == 'TV') {
      controleSend = [
        {"comando": ''},
        {"controle": 0}
      ];
    } else if(tipo == 'Central de Ar') {
      tipo = "Air";
      if (marca == 'Gree') {
        controleSend = [
          {"estado":false},{"temp":22},{"mode":"kGreeCool"},{"vent":"kGreeAuto"}
        ];

      } else if (marca == 'LG') {
        controleSend = [
          [{"estado":false},{"temp":18},{"mode":"kLgAcCool"},{"vent":"kLgAcAuto"}]
        ];
      }
    }
    var idDp = await DispositivoControler.recuperarIdDP();


    http.Response response = await http.post(
      Uri.parse("$urlBase/controll/novo_controle"),
      body: {
        'id_dp': idDp.toString(),
        'nome': nome,
        'controle': jsonEncode(controleSend),
        'tipo': tipo,
        'marca': marca
      }
    );

    print(response.body);
  }
}
