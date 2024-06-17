import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:presence_jor/src/view/home_adm_view.dart';
import 'package:presence_jor/src/view/login_view.dart';

import '../view/util.dart';
import '../view/home_view.dart';

class LoginController extends ChangeNotifier{
  //
  // CRIAR CONTA de um usuário no serviço Firebase Authentication
  //
  criarConta(context, nome, email, senha, codigo, curso) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: senha,
    )
        .then(
      (resultado) {
        //Usuário criado com sucesso!

        //Armazenar o NOME e UID do usuário no Firestore
        FirebaseFirestore.instance.collection("usuarios").add(
          {
            "uid": resultado.user!.uid,
            "nome": nome,
            "codigo": codigo,
            "email": email,
            "curso": curso
          },
        );

        sucesso(context, 'Usuário criado com sucesso!');
        Navigator.restorablePopAndPushNamed(context, LoginView.routeName);
      },
    ).catchError((e) {
      //Erro durante a criação do usuário
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.');
          break;
        case 'invalid-email':
          erro(context, 'O formato do e-mail é inválido.');
          break;
        default:
          erro(context, 'ERRO: ${e.toString()}');
      }
    });
  }

  //
  // LOGIN de usuário a partir do provedor Email/Senha e redireciona para dele adm ou comum
  //
  login(context, email, senha) {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {

        FirebaseFirestore.instance
          .collection('usuarios')
          .where('uid', isEqualTo: LoginController().idUsuarioLogado())
          .get()
          .then((QuerySnapshot querySnapshot) {
            if (querySnapshot.docs.isNotEmpty) {
              var docSnapshot = querySnapshot.docs.first;
              var data = docSnapshot.data() as Map<String, dynamic>;
              var isAdm = data['isAdm'];
                if(isAdm.toString() == "true"){
                  Navigator.restorablePopAndPushNamed(context, HomeAdmView.routeName);
                }else{
                  Navigator.restorablePopAndPushNamed(context, HomeView.routeName);
                }
            }
            }).catchError((error) {
            // Caso ocorra algum erro na consulta
            print("Erro ao consultar o Firestore: $error");
          });
        sucesso(context, 'Usuário autenticado com sucesso!');

    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          erro(context, 'O formato do e-mail é inválido.');
        case 'invalid-credential':
          erro(context, 'Usuário e/ou senha inválida.');
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  esqueceuSenha(context, email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance.sendPasswordResetEmail(
        email: email,
      );
      sucesso(context, 'Email enviado com sucesso.');
    } else {
      erro(context, 'Informe o email para recuperar a conta.');
    }
  }

  //
  // Efetuar logou do usuário
  //
  logout() {
    FirebaseAuth.instance.signOut();
  }

  //
  // Retornar o UID (User Identifier) do usuário que está logado no App
  //
  idUsuarioLogado() {
    return FirebaseAuth.instance.currentUser!.uid;
  }
  
  Future<QuerySnapshot> getDataUser(String uid) {
    return FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: uid)
        .get();
  }
  
  loginFederacao() {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    googleProvider.addScope('https://www.googleapis.com/auth/userinfo.email');
    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });
    
  }




}
