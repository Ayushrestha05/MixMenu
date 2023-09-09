import 'package:flutter/material.dart';
import 'package:mixmenu/app/app.dart';
import 'package:mixmenu/bootstrap.dart';
import 'package:mixmenu/services/service_locator.dart';
import 'package:mixmenu/services/shared_pref_services.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  print('Start Locator');
  await Future.wait(
    [
      setupLocator().then(
            (value) async => {
          await locator<SharedPrefsServices>().init(),
        },
      ),
    ],
  );
  bootstrap(() => const App());
}
