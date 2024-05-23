// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:presence_jor/src/controller/lista_eventos_controller.dart';
import 'package:presence_jor/src/controller/local_user_controller.dart';
import 'package:presence_jor/src/model/eventos.dart';
import 'package:provider/provider.dart';



class Card_Evento_Info_View extends StatefulWidget {
  const Card_Evento_Info_View({super.key});
  static const routeName = 'Confirmar_Presença';

  @override
  State<Card_Evento_Info_View> createState() => _Card_Evento_Info_View();
}

class _Card_Evento_Info_View extends State<Card_Evento_Info_View> {
  final EventosController controller = EventosController();
  late Future<getLocationUser> _localization;

  @override
  void initState() {
    super.initState();
    _localization = getLocationUserAtual();
  }

  @override
  Widget build(BuildContext context) {
    final eventos = ModalRoute.of(context)!.settings.arguments as Eventos;

    return Scaffold(
    appBar: AppBar(
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 26, 33, 225),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Confirmar Presença',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                    ),
              ),
            ),
          ],
        ),
      ),
      

    body: ListView.builder(
      itemCount: 1,
      itemBuilder: ((context, index) {

        return Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //
                                //Titulo
                                Text(
                                  eventos.title,
                                  style: TextStyle(
                                    fontSize: 28,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(height: 8,),
                                //
                                //Description
                                Text(
                                  eventos.description,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: const Color.fromARGB(255, 52, 51, 51),
                                  ),
                                ),
                              ],
                              ),
                            Center (
                                child: FutureBuilder<getLocationUser>(
                                  future: _localization,
                                  builder: (context, snapshot){
                                    final local = context.watch<getLocationUser>();
                                    String mensagem =  local.erro == '' ? 'latitude ${local.lat} | ${local.long}': local.erro;
                                    return Center(child: Text(mensagem),);
                                  },
                              )
                            )
                          ],

                        )
                  );
      }),
    )
    
    );
  }
}
