import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presence_jor/src/sample_feature/sample_item_list_view.dart';
import 'package:presence_jor/src/settings/settings_view.dart';
import 'package:presence_jor/src/view/eventos_view.dart';
import '../controller/login_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  static const routeName = 'Home';

  @override
  State<HomeView> createState() => _HomeViewState();
}
class PaginaDestino {
  final String label;
  final Widget icon;
  final Widget selectedIcon;
  final Widget page;

  const PaginaDestino(this.label, this.icon, this.selectedIcon, this.page);
}

class _HomeViewState extends State<HomeView> {

  LoginController user = LoginController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int screenIndex = 0;
  late bool showNavigationDrawer;
  

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }


  List<PaginaDestino> destinations = <PaginaDestino>[
    const PaginaDestino(
          'Home', 
          Icon(Icons.home_outlined), 
          Icon(Icons.home),
          Eventos_view(),
        ),
    const PaginaDestino(
          'Confirmções', 
          Icon(Icons.format_paint_outlined), 
          Icon(Icons.format_paint),
          SampleItemListView(),
        ),
];

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.amber,
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
        actions: [
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
      
      ),
      
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            FutureBuilder<QuerySnapshot>(
              future: user.getDataUser(user.idUsuarioLogado()),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  print(user.idUsuarioLogado());
                  return Center(child: Text('Usuário não encontrado'));
                } else {
                  var userData = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                  return UserAccountsDrawerHeader(
                          accountEmail: Text(userData['email']),
                          accountName: Text(userData['nome']),
                          currentAccountPicture: CircleAvatar(
                            child: Text(userData['nome'].length >= 2 ?   userData['nome'].substring(0, 2).toUpperCase() : userData['nome'])),
                          );
                }
              },
            ),

            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, 'politicas');
              },
              leading: Icon(Icons.info),
              title: Text("Politicas de Privacidade"),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, 'configuracoes');
              },
              leading: Icon(Icons.info),
              title: Text("Configurações"),
            )
          ]
        ),
      ),
      

      
  
      body: Row(
        children: [
          if (showNavigationDrawer)
            buildDrawerScaffold(), // Exibe o NavigationRail se a tela for grande
          Expanded(
            child: destinations[screenIndex].page,
          ),
        ],
      ),
      

      bottomNavigationBar: showNavigationDrawer ? 
        null: 
        buildBottomBarScaffold(),

    );  
  }

Widget buildBottomBarScaffold() {
    return  NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (int index) {
          setState(() {
            screenIndex = index;
          });
        },
        destinations: destinations.map(
          (PaginaDestino destination) {
            return NavigationDestination(
              label: destination.label,
              icon: destination.icon,
              selectedIcon: destination.selectedIcon,
              tooltip: destination.label,
            );
          },
        ).toList(),
      );
  }

  
Widget buildDrawerScaffold() {
    return SafeArea(
        bottom: false,
        top: false,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: NavigationRail(
                minWidth: 50,
                selectedIndex: screenIndex,
                useIndicator: true,
                onDestinationSelected: (int index) {
                  setState(() {
                    screenIndex = index;
                  });
                },
                destinations: destinations.map(
                  (PaginaDestino destination) {
                    return NavigationRailDestination(
                      label: Text(destination.label),
                      icon: destination.icon,
                      selectedIcon: destination.selectedIcon,
                    );
                  },
                  ).toList(),
              ),
            ),
            const VerticalDivider(thickness: 1, width: 1),
          ]
        ),
    );
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showNavigationDrawer = MediaQuery.of(context).size.width >= 500;
  }

}

