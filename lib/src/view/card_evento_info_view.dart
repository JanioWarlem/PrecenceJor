import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

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
  Uint8List? webImage;
  String? imageName;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final eventos = ModalRoute.of(context)!.settings.arguments as Eventos;

    Future<void> pikckImage() async {
      final ImagePicker _pikck = ImagePicker();
      if (kIsWeb) {
        XFile? image = await _pikck.pickImage(source: ImageSource.gallery);
        if (image != null) {
          var f = await image.readAsBytes();
          setState(() {
            webImage = f;
            imageName = image.name;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Nenhuma imagem foi escolhida')),
          );
        }
      } else {
      const Text('Nada foi encontrado');
      }
    }

    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Color.fromARGB(255, 26, 33, 225),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Confirmar Presença',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
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
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
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
                    Center(
                        child: 
                        FutureBuilder<String>(
                            future: imageUrl(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Erro: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                return Image.network(snapshot.data!);
                              } else {
                                return const Text('Nenhum dado disponível');
                              }
                            })
                    ),
                    SizedBox(height: 5,),
                    Center(
                        child: webImage == null
                            ?  Container(
                                decoration: BoxDecoration(
                                color: Colors.grey[400],
                                ),
                                width: 300,
                                height: 100,
                                child: const Icon(
                                  Icons.add_photo_alternate,
                                  size: 60,
                                  color: Colors.grey,
                                ),
                              )
                            : SizedBox(
                                width: webImage != null ? 240 : 5,
                                height: webImage != null ? 450 : 5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: webImage == null
                                      ? null
                                      : Image.memory(webImage!,
                                          fit: BoxFit.cover),
                                ),
                              ),
                          ),
                  const SizedBox(height: 5,),
                    OutlinedButton.icon(
                        onPressed: () {
                          pikckImage();
                        },
                        icon: Icon(
                          webImage == null? Icons.error : Icons.check_circle,
                          color:webImage == null? Colors.red: Colors.green[800],
                        ),
                        label: webImage ==null? Text('Comprove sua participação com uma imagem'): Text(imageName!)
                        )
                  ],
                ));
          }),
        ));
  }
}

Future<String> imageUrl() async {
  GetLocationUser _localization =
      await GetLocationUser().getLocationUserAtual();

  final url =
      GoogleMapStatic.buildMapUrl('${_localization.lat},${_localization.long}');
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return url;
  } else {
    throw Exception('Failed to load image');
  }
}
