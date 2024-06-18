import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:presence_jor/src/view/home_adm_view.dart';
import '../model/eventos.dart';
import '../view/util.dart';

class EventosController {
  
  //Adicionar uma novo evento
  Future<void> adicionar(BuildContext context, Eventos evento) async {
    try {
      await FirebaseFirestore.instance.collection('eventos').add(evento.toJson());
      sucesso(context, 'Evento adicionado com sucesso!');
    } catch (e) {
      erro(context, 'Não foi possível adicionar o evento');
    } finally {
      Navigator.popAndPushNamed(context, HomeAdmView.routeName);
    }
  }

  //Listar eventos
  Stream<QuerySnapshot> listar() {
    return FirebaseFirestore.instance.collection('eventos').snapshots();
  }

  //Excluir evento
  excluir(context, id) {
    FirebaseFirestore.instance
        .collection('eventos')
        .doc(id)
        .delete()
        .then((value) => sucesso(context, 'evento excluída com sucesso!'))
        .catchError((e) => erro(context, 'Não foi possível excluir a evento.'));
  }

  //Atualizar uma evento
  atualizar(context, id, Eventos t){

    FirebaseFirestore.instance.collection('evento')
      .doc(id)
      .update(t.toJson())
      .then((value) => sucesso(context, 'evento atualizada com sucesso!'))
      .catchError((e) => erro(context, 'Não foi possível atualizada evento.'))
      .whenComplete(() => Navigator.pop(context));
  }


}
