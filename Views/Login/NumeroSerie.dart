// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thunder_monkey_app/Control/DispositivoControler.dart';
import 'package:thunder_monkey_app/Views/Login/CriarSenha.dart';
import 'package:thunder_monkey_app/Views/Login/Senha.dart';
import '../../Models/Dispositivo.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _numeroSerie = TextEditingController();
  var valid = true;
  var waiting = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 1,
        color: const Color(0xFF012677),
        padding: EdgeInsets.all(50),
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
                          padding: EdgeInsets.all(20),
                          child: Image.asset(
                            "images/logo2.png",
                            scale: 1,
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(30, 0, 30, 30),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              style: TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'Número de série ',
                              ),
                              controller: _numeroSerie,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Insira o número de série.';
                                } else if (valid == false) {
                                  return 'Número de série invalido.';
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
                                  setState(() {
                                    waiting = true;
                                  });
                                  DispositivoControler.recuperarDispositivo(
                                          _numeroSerie.text)
                                      .then((List<Dispositivo> dispositivo) => {
                                            //dispositivos[0].nSerie
                                            if (dispositivo.isNotEmpty)
                                              {
                                                if (dispositivo[0]
                                                        .primeiroAcesso ==
                                                    1)
                                                  {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            CriarSenha(
                                                                dispositivo:
                                                                    dispositivo[
                                                                        0]),
                                                      ),
                                                    ),
                                                    setState(() {
                                                      waiting = false;
                                                    })
                                                  }
                                                else
                                                  {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Senha(
                                                                dispositivo:
                                                                    dispositivo[
                                                                        0]),
                                                      ),
                                                    ),
                                                    setState(() {
                                                      waiting = false;
                                                    })
                                                  }
                                              }
                                            else
                                              {
                                                setState(() {
                                                  valid = false;
                                                  waiting = false;
                                                })
                                              }
                                          });
                                }
                              },
                              child: waiting == true
                                  ? SizedBox(
                                      width: 20.0,
                                      height: 20.0,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 4.0,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
