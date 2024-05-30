import 'dart:io';

import 'package:camera/camera.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';


import 'package:presence_jor/src/controller/lista_eventos_controller.dart';
import 'package:presence_jor/src/controller/local_user_controller.dart';
import 'package:presence_jor/src/model/google_maps_static_api.dart';
import 'package:presence_jor/src/model/eventos.dart';
import 'package:http/http.dart' as http;


class Card_Evento_Info_View extends StatefulWidget {
  const Card_Evento_Info_View({super.key});
  static const routeName = 'Confirmar_Presença';

  @override
  State<Card_Evento_Info_View> createState() => _Card_Evento_Info_View();
}

class _Card_Evento_Info_View extends State<Card_Evento_Info_View> {

  final EventosController controller = EventosController();
  late File arquivoImg;
  
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
                  padding: EdgeInsets.all(30),
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
                            //
                            //Carregamento do mapa com local do user.
                            Center (
                                child: FutureBuilder<String>(
                                  future: imageUrl(),
                                  builder:  (context, snapshot) {
                                        if (snapshot.connectionState == ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text('Erro: ${snapshot.error}');
                                        } else if (snapshot.hasData) {
                                            return  Image.network(snapshot.data!);
                                        } else {
                                          return Text('Nenhum dado disponível');
                                        }
                                  }
                              )
                            ),
                            OutlinedButton.icon(
                              onPressed: (){
                                Navigator.push(context, CameraCamera(onFile: ((file) => print(file))));

                              },
                              icon: Icon(Icons.check_circle, color: Colors.green[800],),
                              label: Text('Validar participação')
                            )
                          
                          
                          ],

                        )
                  );
      }),
    )
    
    );
    
  }
}
Future<String> imageUrl() async {
    GetLocationUser _localization =  await GetLocationUser().getLocationUserAtual();

    final url = GoogleMapStatic.buildMapUrl('${_localization.lat},${_localization.long}');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return url;
    } else {
      throw Exception('Failed to load image');
    }
  }
