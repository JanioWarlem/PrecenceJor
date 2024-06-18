// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/fitness/v1.dart';
import 'package:presence_jor/src/controller/eventos_controller.dart';
import 'package:presence_jor/src/model/eventos.dart';
import 'package:presence_jor/src/view/home_adm_view.dart';
import 'package:presence_jor/src/view/login_view.dart';


class CirarEventoView extends StatefulWidget {
  const CirarEventoView({super.key});
  static const routeName = 'cadastrtar_eventos';

  @override
  State<CirarEventoView> createState() => _CirarEventoViewState();
}

class _CirarEventoViewState extends State<CirarEventoView> {

  var txtTitle= TextEditingController();
  var txtDescription = TextEditingController();
  var txtlocation = TextEditingController();
  var txtDate = TextEditingController();
  var txtLatitude = TextEditingController();
  var txtLongitude = TextEditingController();


  final _formKey = GlobalKey<FormState>();
  

  //Criacao co calendário
  Future<void> _selectData() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_pickedDate != null) {
      TimeOfDay? _pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (_pickedTime != null) {
        final DateTime _pickedDateTime = DateTime(
          _pickedDate.year,
          _pickedDate.month,
          _pickedDate.day,
          _pickedTime.hour,
          _pickedTime.minute,
        );

        setState(() {
          txtDate.text = _pickedDateTime.toString();
        });
      }
    }
  }

  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                'Criar evento',
                style: TextStyle(fontSize: 26),
                ),
              ],
            ),
            SizedBox(height: 60),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  //titulo
                      TextFormField(
                        controller: txtTitle,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite um título';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Título',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder()
                        ),
                      ),
                      SizedBox(height: 15),
                      //descricao
                      TextFormField(
                        controller: txtDescription,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite uma drecrição';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Drecrição',
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder()
                          ),
                      ),
                      //local
                      SizedBox(height: 15),
                      TextFormField(
                        controller: txtlocation,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Precisamos de um local para o evento';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Local',
                          prefixIcon: Icon(Icons.badge),
                          border: OutlineInputBorder()),
                      ),
                      SizedBox(height: 15),
                      //data
                      TextFormField(
                        controller: txtDate,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Digite a data';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: 'Data',
                            prefixIcon: Icon(Icons.calendar_today),
                            border: OutlineInputBorder()
                            //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blue))
                          ),
                          readOnly: true,
                          onTap: () {
                            _selectData();
                          },
                      ),
                      SizedBox(height: 15),
                      TextField(
                          controller: txtLatitude,
                          decoration: InputDecoration(labelText: 'Latitude'),
                          keyboardType: TextInputType.number,
                        ),
                      TextField(
                        controller: txtLongitude,
                        decoration: InputDecoration(labelText: 'Longitude'),
                        keyboardType: TextInputType.number,
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
                    Navigator.popAndPushNamed(context, HomeAdmView .routeName);
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
                               // Converter txtDate.text para DateTime
                              DateTime dateTime;
                              if (txtDate.text.isNotEmpty) {
                                dateTime = DateTime.parse(txtDate.text);
                              } else {
                                throw Exception('Data não pode estar vazia');
                              }
                              final latitude = double.tryParse(txtLatitude.text);
                              final longitude = double.tryParse(txtLongitude.text);
                              final geoPoint;
                              if (latitude != null && longitude != null){
                                  geoPoint = GeoPoint(latitude, longitude);
                                  
                                  final evento = Eventos(
                                  title: txtTitle.text,
                                  description: txtDescription.text,
                                  date: dateTime,
                                  location: txtlocation.text,
                                  inscritos: {}, // Iniciando como um mapa vazio
                                  geoLocation: geoPoint,
                                );
                                await EventosController().adicionar(context, evento);
                              }

                              
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Erro ao Adicionar evento: $e'),
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
