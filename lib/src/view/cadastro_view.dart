// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:presence_jor/src/view/login_view.dart';

import '../controller/login_controller.dart';

class CadastrarView extends StatefulWidget {
  const CadastrarView({super.key});
  static const routeName = 'Cadastrar';

  @override
  State<CadastrarView> createState() => _CadastrarViewState();
}

class _CadastrarViewState extends State<CadastrarView> {
  var txtNome = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtCodigo = TextEditingController();
  var txtCurso = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  

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
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 17, 17, 17),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    'Jor',
                    style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                ),
            ],
          ),
          
        ),
        
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Column(
          children: [
            Text(
              'Criar Conta',
              style: TextStyle(fontSize: 40),
            ),
            SizedBox(height: 60),
            Form(
              key: _formKey,
              child: Column(
                children: [
                      TextFormField(
                        controller: txtNome,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite um nome';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Nome',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: txtEmail,
                        validator: (value) {
                          final regex = RegExp(r'^[a-zA-Z0-9._%+-]+@(sou\.unaerp\.edu\.br)$');
                          final regex2 = RegExp(r'^[a-zA-Z0-9._%+-]+@(unaerp\.br)$');
                          if (value == null || value.isEmpty) {
                            return 'Digite um email institucional';
                          }else if (regex.hasMatch(value) == false && regex2.hasMatch(value) == false) {
                            return 'Aceitos somente @unaerp.br ou @sou.unaerp.edu.br';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder()
                          ),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: txtSenha,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite a senha';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                        controller: txtCodigo,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Precisamos do seu código';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Código',
                          prefixIcon: Icon(Icons.badge),
                          border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 15),
                      TextFormField(
                          controller: txtCurso,
                          validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nos informe seu código';
                          }
                          return null;
                        },
                          decoration: InputDecoration(
                            labelText: 'Curso',
                            prefixIcon: Icon(Icons.school),
                            border: OutlineInputBorder()),
                        ),
                      SizedBox(height: 40), 
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.restorablePopAndPushNamed(context, LoginView.routeName);
                  },
                  child: Text(
                    'cancelar',
                    style: TextStyle(color: Colors.black),
                    ),
                ),
                ElevatedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: Size(140, 40),
                    backgroundColor:  Colors.indigo[900]
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                            try {
                              await LoginController().criarConta(
                                context,
                                txtNome.text,
                                txtEmail.text,
                                txtSenha.text,
                                txtCodigo.text,
                                txtCurso.text,
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erro ao criar conta: $e'),
                                ),
                              );
                            }
                          }
                  },
                  child: Text(
                    'salve',
                    style: TextStyle(color: Colors.white),
                    
                    )
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
