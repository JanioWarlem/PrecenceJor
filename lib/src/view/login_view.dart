// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:flutter/material.dart';
import 'package:presence_jor/src/settings/settings_view.dart';
import 'package:presence_jor/src/view/cadastro_view.dart';

import '../controller/login_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const routeName = 'Login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtEmailEsqueceuSenha = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Precence',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                          ? Color.fromARGB(255, 6, 4, 4)
                          : const Color.fromARGB(255, 255, 254, 254),
                          ),
              ),
            ),
            Center(
              child: Text(
                'Jor',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
          ],
        ),
        
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePopAndPushNamed(
                  context, SettingsView.routeName);
            },
          ),
        ],
      ),
      
      body: Padding( 
          padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
            child: SingleChildScrollView( 
              scrollDirection: Axis.vertical,
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                  Center(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ]),
                TextField(
                  controller: txtEmail,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: UnderlineInputBorder(),
                    focusColor: Colors.indigo[900],
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: txtSenha,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: 'Senha',
                      prefixIcon: Icon(Icons.password),
                      border: UnderlineInputBorder()),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Esqueceu a senha?",
                                style: TextStyle(color: Colors.blue)),
                            content: Container(
                              height: 150,
                              child: Column(
                                children: [
                                  Text(
                                      "Identifique-se para receber um e-mail com as instruções e o link para criar uma nova senha.",
                                      style: TextStyle(color: Colors.black)),
                                  SizedBox(height: 25),
                                  TextField(
                                    controller: txtEmailEsqueceuSenha,
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      prefixIcon: Icon(Icons.email),
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actionsPadding: EdgeInsets.all(20),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  //
                                  // Enviar email recuperação de senha
                                  //
                                  LoginController().esqueceuSenha(
                                    context,
                                    txtEmailEsqueceuSenha.text,
                                  );
                                  Navigator.pop(context);
                                },
                                child: Text('enviar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('Esqueceu a senha?',
                        style: TextStyle(color: Colors.indigo[900])),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(400, 40),
                    backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  onPressed: () {
                    //
                    // LOGIN
                    //
                    LoginController().login(
                      context,
                      txtEmail.text,
                      txtSenha.text,
                    );
                  },
                  child: Text('Entrar',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ainda não tem conta?'),
                    TextButton(
                      onPressed: () {
                        Navigator.restorablePushNamed(
                            context, CadastrarView.routeName);
                      },
                      child: Text('Cadastre-se',
                          style: TextStyle(color: Colors.indigo[900])),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "from\nJanio",
                      textAlign: TextAlign.center,
                    ),
                  ],
                )
              ],
            ),
            
            )
          ),
    
    );
  }
}
