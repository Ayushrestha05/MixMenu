import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mixmenu/app/views/feeds/bloc/a_bar_above_bloc/a_bar_above_bloc.dart';
import 'package:mixmenu/app/views/feeds/feeds_screen.dart';
import 'package:mixmenu/app/views/home/home_screen.dart';
import 'package:mixmenu/app/views/search/search_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final ValueNotifier<int> _currentPage = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<int>(
          valueListenable: _currentPage,
          builder: (context, page, _) {
            return <Widget>[
              HomeScreen(),
              SearchScreen(),
              Container(
                color: Colors.blue,
                alignment: Alignment.center,
                child: const Text('Page 3'),
              ),
              FeedScreen(),
            ][page];
          }),
      bottomNavigationBar: ValueListenableBuilder<int>(
          valueListenable: _currentPage,
          builder: (context, page, _) {
            return NavigationBar(
              selectedIndex: page,
              onDestinationSelected: (currentSelected) {
                _currentPage.value = currentSelected;
              },
              destinations: [
                NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home'),
                NavigationDestination(
                    icon: Icon(Icons.search_rounded),
                    selectedIcon: Icon(Icons.search_rounded),
                    label: 'Search'),
                NavigationDestination(
                    icon: Icon(Icons.favorite_border),
                    selectedIcon: Icon(Icons.favorite),
                    label: 'Favourites'),
                NavigationDestination(
                    icon: Icon(Icons.rss_feed_outlined),
                    selectedIcon: Icon(Icons.rss_feed),
                    label: 'Feeds'),
              ],
            );
          }),
    );
  }
}
