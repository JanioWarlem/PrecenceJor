// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:presence_jor/src/controller/lista_eventos_controller.dart';
import 'package:presence_jor/src/model/eventos.dart';
import 'package:presence_jor/src/view/eventos_view.dart';



class Card_Evento_Info_View extends StatefulWidget {
  const Card_Evento_Info_View({super.key});
  static const routeName = 'Confirmar_Presença';

  @override
  State<Card_Evento_Info_View> createState() => _Card_Evento_Info_View();
}

class _Card_Evento_Info_View extends State<Card_Evento_Info_View> {
  final EventosController controller = EventosController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventos = ModalRoute.of(context)!.settings.arguments as Eventos;

    return Scaffold(
    appBar: AppBar(
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 41, 32, 165),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Confirmar Presença',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color:  Color.fromARGB(255, 255, 250, 250)
                    ),
              ),
            ),
          ],
        ),
      ),
      

    body: Text('Titulo ${eventos.title}\n ${eventos.description}')

    );
  }
}
