import 'package:flutter/material.dart';
import 'package:thunder_monkey_app/Control/DispositivoControler.dart';
import 'package:thunder_monkey_app/Models/Dispositivo.dart';
import 'package:thunder_monkey_app/Views/Login/Senha.dart';

class CriarSenha extends StatefulWidget {
  final Dispositivo dispositivo;

  const CriarSenha({Key? key, required this.dispositivo}) : super(key: key);

  @override
  State<CriarSenha> createState() => _CriarSenhaState(dispositivo: dispositivo);
}

class _CriarSenhaState extends State<CriarSenha> {
  final Dispositivo dispositivo;

  _CriarSenhaState({required this.dispositivo});

  TextEditingController _senha = TextEditingController();
  TextEditingController _confirmSenha = TextEditingController();
  bool _obscureText1 = true;
  bool _obscureText2 = true;
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
                            const Padding(
                              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                              child: Text(
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  "Crie uma senha para proteger os seus circuitos. Essa senha servirá para você ter acesso ao app."),
                            ),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        30, 0, 30, 0),
                                    child: TextFormField(
                                      obscureText: _obscureText1,
                                      style: const TextStyle(color: Colors.white),
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Crie uma senha',
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscureText1 = !_obscureText1;
                                            });
                                          },
                                          child: Icon(
                                            _obscureText1
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                        ),
                                      ),
                                      controller: _senha,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Insira uma senha.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        30, 20, 30, 30),
                                    child: TextFormField(
                                      style: const TextStyle(color: Colors.white),
                                      obscureText: _obscureText2,
                                      decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        labelText: 'Confirmar senha',
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _obscureText2 = !_obscureText2;
                                            });
                                          },
                                          child: Icon(
                                            _obscureText2
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                          ),
                                        ),
                                      ),
                                      controller: _confirmSenha,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Confirme sua senha.';
                                        } else if (_senha.text !=
                                            _confirmSenha.text) {
                                          return "Confirme sua senha corretamente.";
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      DispositivoControler.atualizarSenha(
                                          dispositivo.id, _senha.text)
                                          .then((value) => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Senha(
                                                dispositivo: dispositivo),
                                          ),
                                        )
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
        ),
      )
    );
  }
}
