import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thunder_monkey_app/Control/DispositivoControler.dart';
import 'package:thunder_monkey_app/Models/Dispositivo.dart';
import 'package:thunder_monkey_app/Views/App/Home.dart';
import 'package:thunder_monkey_app/Views/PrimeiroAcesso/BemVindo.dart';

class Senha extends StatefulWidget {
  final Dispositivo dispositivo;

  const Senha({Key? key, required this.dispositivo}) : super(key: key);

  @override
  State<Senha> createState() => _SenhaState(dispositivo: dispositivo);
}

class _SenhaState extends State<Senha> {
  final Dispositivo dispositivo;
  _SenhaState({required this.dispositivo});

  final TextEditingController _senha = TextEditingController();
  bool _obscureText = true;
  var valid = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        color: const Color(0xFF012677),
        padding: const EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
                color: Colors.black,
                child: SizedBox(
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Image.asset(
                            "images/logo2.png",
                            scale: 1,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                30, 0, 30, 30),
                            child: TextFormField(
                              style: const TextStyle(color: Colors.white),
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                labelText: 'Senha',
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                              ),
                              controller: _senha,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Digite sua senha.';
                                } else if (valid == false) {
                                  return 'Senha incorreta.';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                if (valid == false) {
                                  setState(() {
                                    valid = true;
                                  });
                                }
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  int idDP = dispositivo.id;
                                  DispositivoControler.recuperarDispositivo(
                                          dispositivo.nSerie)
                                      .then((List<Dispositivo> dispositivo) => {
                                            if (dispositivo[0].senha ==
                                                _senha.text)
                                              {
                                                if (dispositivo[0]
                                                        .primeiroAcesso ==
                                                    1)
                                                  {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                BemVindo(
                                                                    idDp:
                                                                        idDP)))
                                                  }
                                                else
                                                  {
                                                    DispositivoControler
                                                            .salvarUsuario(idDP)
                                                        .then((value) => {
                                                              Navigator
                                                                  .pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const Home()),
                                                                (route) =>
                                                                    false,
                                                              )
                                                            })
                                                  }
                                              }
                                            else
                                              {
                                                setState(() {
                                                  valid = false;
                                                })
                                              }
                                          });
                                }
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Avançar",
                                  ),
                                  Icon(Icons.arrow_forward)
                                ],
                              )),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    )));
  }
}
