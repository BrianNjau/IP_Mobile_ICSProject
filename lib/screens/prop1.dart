import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:listings/services/crud.dart';

import 'package:listings/services/crud.dart';

class Prop1 extends StatefulWidget {
  @override
  _Prop1State createState() => _Prop1State();
}

class _Prop1State extends State<Prop1> {
  CrudMethods crudMethods = new CrudMethods();
  Stream propertyStream;
  Widget PropertyList() {
    return Container(
      child: propertyStream != null
          ? Container(
              color: Colors.white,
              child: StreamBuilder(
                  stream: propertyStream,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return SpinKitPouringHourglass(
                        color: Colors.blueGrey[900],
                        size: 50.0,
                      );
                    } else {
                      return PageView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) {
                            return PropertyTile(
                                imgUrl: snapshot
                                    .data.documents[index].data["imgUrl"],
                                propertyTitle: snapshot.data.documents[index]
                                    .data["Propertytitle"],
                                desc: snapshot.data.documents[index]
                                    .data["PropertyDescription"],
                                price: snapshot
                                    .data.documents[index].data["Price"],
                                PhoneNumber: snapshot.data.documents[index]
                                    .data["ContactDetails"]);
                          });
                    }
                  }))
          : Container(
              alignment: Alignment.center,
              child: SpinKitPouringHourglass(
                color: Colors.white,
                size: 50.0,
              ),
            ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    crudMethods.getData().then((result) {
      setState(() {
        propertyStream = result;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PropertyList(),
    );
  }
}

class PropertyTile extends StatelessWidget {
  String imgUrl, propertyTitle, desc, price, PhoneNumber;

  PropertyTile(
      {@required this.imgUrl,
      @required this.propertyTitle,
      @required this.desc,
      @required this.price,
      @required this.PhoneNumber});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.blueGrey[300],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    // mainAxisAlignment:
                    //     MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Row(children: <Widget>[
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 10.0, right: 15.0),
                              child: Divider(
                                color: Colors.black,
                                height: 50,
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Property Description",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: Colors.blueGrey[900]),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Expanded(
                          child: new Container(
                              margin: const EdgeInsets.only(
                                  left: 15.0, right: 10.0),
                              child: Divider(
                                color: Colors.black,
                                height: 50,
                              )),
                        ),
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          desc,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.blueGrey[900],
                              fontSize: 8,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Text(
                          price,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.yellow[600],
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
        Container(
          margin: EdgeInsets.only(top: 40),
          child: Align(
            alignment: Alignment.topCenter,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 100,
            width: 300,
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    propertyTitle,
                    style: TextStyle(color: Colors.blueGrey[900], fontSize: 24),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: 120,
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 70,
                  decoration: BoxDecoration(
                      color: Colors.blueGrey[900],
                      borderRadius: BorderRadius.circular(20)),
                  child: Icon(
                    Icons.message_outlined,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[900],
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                        child: Text(
                      PhoneNumber,
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )),
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                )),
          ),
        )
      ],
    );
  }
}
