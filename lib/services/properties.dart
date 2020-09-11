import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Property {
  String imgUrl, propertyTitle, desc, price, PhoneNumber;

  Property(
      {@required this.imgUrl,
      @required this.propertyTitle,
      @required this.desc,
      @required this.price,
      @required this.PhoneNumber});

  Property.fromMap(Map<String, dynamic> data) {
    propertyTitle:
    data['Propertytitle'];
    desc:
    data['PropertyDescription'];
    imgUrl:
    data['imgUrl'];
    price:
    data['Price'];
    PhoneNumber:
    data['ContactDetails'];
  }
  Property.fromSnapshot(DocumentSnapshot snapshot)
      : propertyTitle = snapshot['Propertytitle'],
        desc = snapshot['PropertyDescription'],
        imgUrl = snapshot['imgUrl'],
        price = snapshot['Price'],
        PhoneNumber = snapshot['ContactDetails'];
}
