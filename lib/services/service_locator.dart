import 'package:get_it/get_it.dart';
import 'package:mixmenu/app/views/feeds/bloc/a_bar_above_bloc/a_bar_above_bloc.dart';
import 'package:mixmenu/services/navigation_service.dart';
import 'package:mixmenu/services/shared_pref_services.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  locator.registerSingleton<NavigationService>(NavigationService());
  locator.registerSingleton<SharedPrefsServices>(SharedPrefsServices());

  //Blocs
  locator.registerLazySingleton<ABarAboveBloc>(() => ABarAboveBloc());
}
