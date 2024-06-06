import 'package:flutter/material.dart';

class ConfigUserView extends StatefulWidget {
  const ConfigUserView({super.key});
    static const routeName = 'politicas';


  @override
  State<ConfigUserView> createState() => _ConfigUserView();
}

class _ConfigUserView extends State<ConfigUserView> {
  var title1 = 'Presence';
  var title2 = 'Jor';
  var txtEmail = TextEditingController();
  String idUser = idUsuarioLogado();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Color.fromARGB(255, 26, 33, 225),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
                    controller: txtEmail,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: UnderlineInputBorder(),
                      focusColor: Colors.indigo[900],
                    ),
                  ),

              SizedBox(height: 50),
              ClipOval(
                child: Material(
                  color: Colors.blue, // Button color
                  child: InkWell(
                    splashColor: Color.fromARGB(255, 132, 174, 237), // Splash color
                    onTap: () {
                      Navigator.popAndPushNamed(context, 'Home');
                    },
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: Icon(Icons.reply),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
