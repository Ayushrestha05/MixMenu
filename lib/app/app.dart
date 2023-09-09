import 'package:flutter/material.dart';
import 'package:mixmenu/app/routes/export_routes.dart';
import 'package:mixmenu/counter/counter.dart';
import 'package:mixmenu/l10n/l10n.dart';
import 'package:mixmenu/services/navigation_service.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MainScreen(),
      // navigatorKey: NavigationService.navigatorKey,
    );
  }
}

