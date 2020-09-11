import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {'name': 'Apartments', 'iconPath': 'assets/apart.png'},
  {'name': 'TownHouses', 'iconPath': 'assets/town.png'},
  {'name': 'Bungalows', 'iconPath': 'assets/bung.png'},
  {'name': 'SQs', 'iconPath': 'assets/sq.png'},
  {'name': 'Studio', 'iconPath': 'assets/apart.png'},
];

List<Map<String, dynamic>> drawerItems = [
  {'icon': FontAwesomeIcons.plus, 'title': 'Add Property'},
];
