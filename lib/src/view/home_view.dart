// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:presence_jor/src/settings/settings_view.dart';
import 'package:presence_jor/src/view/cadastro_view.dart';

import '../controller/login_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const routeName = 'Home';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int _currentPageIndex = 0;
  late PageController pc;


  ///Lista de paginas de destino pra o navigatorBat
  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    CadastrarView(),
  ];

  @override
  void initState() {
    super.initState();
    pc = PageController(initialPage: _currentPageIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Precence',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.light
                          ? Color.fromARGB(255, 6, 4, 4)
                          : const Color.fromARGB(255, 255, 254, 254),
                          ),
              ),
            ),
            Center(
              child: Text(
                'Jor',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
          ],
        ),
        /*actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            tooltip: 'sair',
            onPressed: () {
              
              LoginController().logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
          ),
        ],
        */
      
      ),
      body: PageView(
        controller: pc,
        children: [
          HomeView(),
          CadastrarView(),
        ],

      ),
      
      //_widgetOptions.elementAt(_currentPageIndex),
      
    bottomNavigationBar: NavigationBar(
        elevation: 10,
        indicatorColor: Colors.indigo[900],
        selectedIndex: _currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentPageIndex = index;
            print(_currentPageIndex);
          });
        },
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home, color: Colors.white),
            icon: Icon(Icons.home_outlined,),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.event_note, color: Colors.white),
            icon: Icon(Icons.event_note_outlined),
            label: 'Participações',
          ),
        ]
        )




      /*bottomNavigationBar: BottomNavigationBar(
        type:BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Eventos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'School',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 4, 0, 255),
      ),*/
    );

  }
}
