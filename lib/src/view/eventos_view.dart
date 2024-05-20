// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:presence_jor/src/controller/lista_eventos_controller.dart';
import 'package:presence_jor/src/model/eventos.dart';


class Eventos_view extends StatefulWidget {
  const Eventos_view({super.key});
  static const routeName = 'Eventos';

  @override
  State<Eventos_view> createState() => _Eventos_view();
}

class _Eventos_view extends State<Eventos_view> {
  final EventosController controller = EventosController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          
        ],
      ),
      

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.

    body: StreamBuilder<QuerySnapshot>(
        stream: controller.listar(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Erro ao carregar eventos.'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              dynamic doc =  data.docs[index].data();
              
              var evento = Eventos.fromJson(doc.data());
              //var dataDoEvento = evento.date(); // Converte para DateTime
              var formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dataDoEvento); // Formata a data

              return ListTile(
                title: Text(doc['title']),
                //subtitle:  Text('Data: $formattedDate'),
                onTap: () {
                  // Navegar para detalhes do evento ou editar evento
                },
              );
            },
          );
        },
      ),



    );
  }
}
