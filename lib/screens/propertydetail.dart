import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:listings/services/propertynotifier.dart';
import 'package:provider/provider.dart';

class PropertyDetail extends StatefulWidget {
  @override
  _PropertyDetailState createState() => _PropertyDetailState();
}

class _PropertyDetailState extends State<PropertyDetail> {
  Widget PropertyDetails() {
    if (Firestore.instance.collection('property').snapshots() != null) {
      StreamBuilder(
          stream: Firestore.instance.collection('property').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return PageView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Scaffold(
                    body: Stack(
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
                                          snapshot.data.documents.elementAt(
                                              index)['PropertyDescription'],
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
                                          snapshot.data.documents
                                              .elementAt(index)['Price'],
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    icon: Icon(Icons.arrow_back_ios),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              child: Image.network(snapshot.data.documents
                                  .elementAt(index)['imgUrl']),
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
                                    snapshot.data.documents
                                        .elementAt(index)['Propertytitle'],
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 24),
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
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Center(
                                        child: Text(
                                      snapshot.data.documents
                                          .elementAt(index)['ContactDetails'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 24),
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
                    ),
                  );
                },
              );
            } else {
              return SpinKitPouringHourglass(
                color: Colors.white,
                size: 50.0,
              );
            }
          });
    } else {
      Container(
        alignment: Alignment.center,
        child: SpinKitPouringHourglass(
          color: Colors.white,
          size: 50.0,
        ),
      );
    }
  }

  @override
  void initState() {
    PropertyDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          appBar: AppBar(),
          body: StreamBuilder(
              stream: Firestore.instance.collection('property').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return PageView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Scaffold(
                        body: Stack(
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
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 10,
                                                      color:
                                                          Colors.blueGrey[900]),
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
                                              snapshot.data.documents.elementAt(
                                                  index)['PropertyDescription'],
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
                                              snapshot.data.documents
                                                  .elementAt(index)['Price'],
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
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        icon: Icon(Icons.arrow_back_ios),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                  child: Image.network(snapshot.data.documents
                                      .elementAt(index)['imgUrl']),
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
                                        snapshot.data.documents
                                            .elementAt(index)['Propertytitle'],
                                        style: TextStyle(
                                            color: Colors.blueGrey[900],
                                            fontSize: 24),
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                            child: Text(
                                          snapshot.data.documents.elementAt(
                                              index)['ContactDetails'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 24),
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
                        ),
                      );
                    },
                  );
                } else {
                  return SpinKitPouringHourglass(
                    color: Colors.white,
                    size: 50.0,
                  );
                }
              })),
    );
  }
}
