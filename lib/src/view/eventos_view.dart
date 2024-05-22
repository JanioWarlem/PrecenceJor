// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:presence_jor/src/controller/lista_eventos_controller.dart';
import 'package:presence_jor/src/model/eventos.dart';
import 'package:presence_jor/src/view/card_evento_info_view.dart';


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
      
              return Card(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: index %2 == 0? Colors.indigo[900]: Colors.black,
                                    child: Center(
                                        child: Text(
                                          (doc['date'] as Timestamp).toDate().day.toString(),
                                          style: TextStyle(color: Colors.white, fontSize: 25),
                                          ),
                                    )
                                  ),
                          hoverColor: Color.fromARGB(255, 188, 201, 236),
                          title: Text(
                                    doc['title'], 
                                    style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20, 
                                    overflow: TextOverflow.ellipsis
                                    ),
                                  ),
                          subtitle: Text(
                                    doc['description'],
                                    style: TextStyle(
                                    color: const Color.fromARGB(255, 56, 56, 56),
                                    overflow: TextOverflow.ellipsis
                                    ),
                                  ), //(doc['date'] as Timestamp).toDate().hour.toString()
                          onTap: () {
                            Eventos eventos = Eventos((doc['date'] as Timestamp).toDate().day.toString(), title: doc['title'], description: doc['description'], location:  doc['location']) ;
                            Navigator.pushNamed(
                              context,
                              'Confirmar_Presença',
                              arguments: eventos
                            );
                          },
                      )
                    );
            },
          );
        },
      ),



    );
  }
}
