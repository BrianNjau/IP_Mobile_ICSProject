import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:listings/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';

import 'package:random_string/random_string.dart';

class AddProp extends StatefulWidget {
  @override
  _AddPropState createState() => _AddPropState();
}

class _AddPropState extends State<AddProp> {
  String propertyTitle, desc, price, Phonenumber;
  File selectedImage;
  bool _isUploading = false;

  CrudMethods crudMethods = new CrudMethods();
//
  Future getImage() async {
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      selectedImage = image;
    });
  }

  uploadProp() async {
    setState(() {
      _isUploading = true;
    });

    if (selectedImage != null) {
      // uploading image to firebase storage
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child("propertyImages");

      final StorageUploadTask task = firebaseStorageRef.putFile(selectedImage);
      var downloadUrl = await (await task.onComplete).ref.getDownloadURL();
      print("this is the URL $downloadUrl");

      Map<String, dynamic> propertyMap = {
        "imgUrl": downloadUrl,
        "Propertytitle": propertyTitle,
        "Price": price,
        "PropertyDescription": desc,
        "ContactDetails": Phonenumber
      };
      crudMethods.addData(propertyMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  // @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  'Add',
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Text(
                'Property',
                style: TextStyle(fontSize: 22, color: Colors.yellow[600]),
              )
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                uploadProp();
              },
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Icon(Icons.file_upload)),
            )
          ],
        ),
        body: _isUploading
            ? Container(
                alignment: Alignment.center,
                child: SpinKitPouringHourglass(
                  color: Colors.white,
                  size: 50.0,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: selectedImage != null
                            ? Container(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(6),
                                    child: Image.file(selectedImage)),
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                              )
                            : Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black45,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Property Title",
                                  hintStyle: TextStyle(color: Colors.grey)),
                              onChanged: (value) {
                                propertyTitle = value;
                              },
                            ),
                            TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Price for Sale or Rent",
                                  hintStyle: TextStyle(color: Colors.grey)),
                              onChanged: (value) {
                                price = value;
                              },
                            ),
                            TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Property Description",
                                  hintStyle: TextStyle(color: Colors.grey)),
                              onChanged: (value) {
                                desc = value;
                              },
                            ),
                            TextField(
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  hintText: "Contact Details eg. Phone Number",
                                  hintStyle: TextStyle(color: Colors.grey)),
                              onChanged: (value) {
                                Phonenumber = value;
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
