import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:listings/services/propertynotifier.dart';
import 'package:random_string/random_string.dart';
import 'package:listings/services/properties.dart';
import 'package:provider/provider.dart';

class CrudMethods {
  Future<void> addData(propertyData) async {
    Firestore.instance.collection("property").add(propertyData).catchError((e) {
      print(e);
    });
  }

  getData() async {
    try {
      return await Firestore.instance.collection("property").snapshots();
    } catch (e) {
      return "There are no Images Left";
    }
  }
}

getProperty(PropertyNotifier propertyNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('property')
      .orderBy("Price", descending: true)
      .getDocuments();

  List<Property> _propertyList = [];

  snapshot.documents.forEach((document) {
    Property property = Property.fromMap(document.data);
    _propertyList.add(property);
  });

  propertyNotifier.propertyList = _propertyList;
}
