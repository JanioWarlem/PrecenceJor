import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:presence_jor/src/sample_feature/sample_item_list_view.dart';
import 'package:presence_jor/src/settings/settings_view.dart';
import 'package:presence_jor/src/view/cadastro_view.dart';
import 'package:presence_jor/src/view/login_view.dart';

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
        'Login', 
        Icon(Icons.home_outlined), 
        Icon(Icons.home),
        LoginView(),
      ),
  const PaginaDestino(
        'set', 
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
      
      /*drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountEmail: Text("janiowarlem@gmail.com"),
              accountName: Text("Janio Warlem"),
              currentAccountPicture: CircleAvatar(
                child: Text("JW"),
              ),
            ),
            ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.pushNamed(context, 'sobre');
              },
              leading: Icon(Icons.info),
              title: Text("Sobre"),
            )
          ]
        ),
      ),
      */


      bottomNavigationBar: NavigationBar(
        selectedIndex: screenIndex,
        onDestinationSelected: (int index){
          setState(() {
            screenIndex = index;
          });
          getNavPagina(index, context, destinations[index].label);
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
        
        ),
    );
  }
}

void getNavPagina(int index,  BuildContext context, String name){
  Navigator.restorablePopAndPushNamed(context, name);
}


