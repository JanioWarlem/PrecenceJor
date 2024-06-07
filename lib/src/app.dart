import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:presence_jor/src/controller/AuthGuard.dart';
import 'package:presence_jor/src/view/cadastro_view.dart';
import 'package:presence_jor/src/view/card_evento_info_view.dart';
import 'package:presence_jor/src/view/config_user_view.dart';
import 'package:presence_jor/src/view/home_view.dart';
import 'package:presence_jor/src/view/login_view.dart';
import 'package:presence_jor/src/view/politica_privacidade_view.dart';

import 'sample_feature/sample_item_details_view.dart';
import 'sample_feature/sample_item_list_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget{
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The ListenableBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return ListenableBuilder(
      listenable: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,


          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return AuthGuard(child: SettingsView(controller: settingsController));
                  case LoginView.routeName:
                    return const LoginView();
                  case SampleItemDetailsView.routeName:
                    return const SampleItemDetailsView(); 
                  case HomeView.routeName:
                    return AuthGuard(child: HomeView());
                  case CadastrarView.routeName:
                    return const CadastrarView();
                  case ConfigUserView.routeName:
                    return ConfigUserView();
                  case Card_Evento_Info_View.routeName:
                    return const Card_Evento_Info_View();
                  case PoliticaPrivacidadeView.routeName:
                    return const PoliticaPrivacidadeView();
                  case SampleItemListView.routeName:
                  default:
                    return const LoginView();
                }
              },
            );
          },
        );
      },
    );
  }
}
