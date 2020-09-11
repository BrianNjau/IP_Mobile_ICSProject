import 'dart:collection';

import 'package:flutter/material.dart';
import 'properties.dart';

class PropertyNotifier with ChangeNotifier {
  List<Property> _propertyList = [];
  Property _currentProperty;

  UnmodifiableListView<Property> get propertyList =>
      UnmodifiableListView(_propertyList);

  Property get currentProperty => _currentProperty;

  set propertyList(List<Property> propertyList) {
    _propertyList = propertyList;
    notifyListeners();
  }

  set currentProperty(Property property) {
    _currentProperty = property;
    notifyListeners();
  }

  addProperty(Property property) {
    _propertyList.insert(0, property);
    notifyListeners();
  }
}
