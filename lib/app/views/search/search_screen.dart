import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          SearchBar(
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {},
            onChanged: (_) {},
            leading: const Icon(Icons.search),
          ),
        ],
        shrinkWrap: true,
      ),
    );
  }
}
