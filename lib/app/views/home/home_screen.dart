import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: ListView(
        shrinkWrap: true,
        children: [
          Text(
            'Sip of the Day',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Card(
            child: SizedBox(
              height: 100,
              child: Center(
                  child: Text(
                'Elevated Card',
                style: TextStyle(fontFamily: 'Roboto'),
              )),
            ),
          ),
          Text(
            'Sip of the Day',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
