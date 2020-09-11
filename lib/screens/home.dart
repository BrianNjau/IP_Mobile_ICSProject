import 'package:flutter/material.dart';
import 'package:listings/screens/dashboard.dart';
import 'package:listings/screens/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          DrawerScreen(),
          Dashboard(),
        ],
      ),
    );
  }
}
