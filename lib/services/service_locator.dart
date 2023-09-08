import 'package:get_it/get_it.dart';
import 'package:mixmenu/services/navigation_service.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async{
  locator.registerSingleton<NavigationService>(NavigationService());
}