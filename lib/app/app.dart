import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixmenu/app/routes/export_routes.dart';
import 'package:mixmenu/app/theme/main_theme.dart';
import 'package:mixmenu/app/views/feeds/bloc/a_bar_above_bloc/a_bar_above_bloc.dart';
import 'package:mixmenu/l10n/l10n.dart';
import 'package:mixmenu/services/service_locator.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const mainTheme = MainTheme();
    // Multi-Bloc Provider Can Be Added here later
    return MaterialApp(
      theme: mainTheme.toThemeData(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          //Feed Blocs
          BlocProvider.value(value: locator<ABarAboveBloc>())
        ],
        child: MainScreen(),
      ),
      // navigatorKey: NavigationService.navigatorKey,
    );
  }
}
