import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:listings/config/configuration.dart';

import 'package:listings/screens/propertydetail.dart';
import 'package:listings/services/crud.dart';
import 'package:listings/services/propertynotifier.dart';
import 'package:random_string/random_string.dart';
import 'package:provider/provider.dart';

import 'prop1.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  CrudMethods crudMethods = new CrudMethods();

  Stream propertyStream;

  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  Widget PropertyList() {
    return Container(
      child: propertyStream != null
          ? Column(
              children: <Widget>[
                StreamBuilder(
                    stream: propertyStream,
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return SpinKitPouringHourglass(
                          color: Colors.blueGrey[900],
                          size: 50.0,
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
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
                    })
              ],
            )
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
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isDrawerOpen
                      ? IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            setState(() {
                              xOffset = 230;
                              yOffset = 150;
                              scaleFactor = 0.6;
                              isDrawerOpen = true;
                            });
                          }),
                  Column(
                    children: [
                      Text('Karibu'),
                      Row(
                        children: [
                          Text('Nyumbani'),
                          // Icon(
                          //   Icons.home,
                          //   color: Colors.blueGrey[900],
                          // ),
                        ],
                      ),
                    ],
                  ),
                  CircleAvatar()
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.search),
                  Text('Search For Property'),
                  Icon(Icons.settings)
                ],
              ),
            ),
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: shadowList,
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            categories[index]['iconPath'],
                            height: 50,
                            width: 50,
                            color: Colors.grey[700],
                          ),
                        ),
                        Text(categories[index]['name'])
                      ],
                    ),
                  );
                },
              ),
            ),
            GestureDetector(onTap: () {}, child: PropertyList()),
            // Container(
            //   height: 240,
            //   margin: EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Stack(
            //           children: [
            //             Container(
            //               decoration: BoxDecoration(
            //                 color: Colors.orange[100],
            //                 borderRadius: BorderRadius.circular(20),
            //                 boxShadow: shadowList,
            //               ),
            //               margin: EdgeInsets.only(top: 50),
            //             ),
            //             Align(
            //               child: Image.asset('assets/house_02.jpg'),
            //             )
            //           ],
            //         ),
            //       ),
            //       Expanded(
            //           child: Container(
            //         margin: EdgeInsets.only(top: 60, bottom: 20),
            //         decoration: BoxDecoration(
            //             color: Colors.white,
            //             boxShadow: shadowList,
            //             borderRadius: BorderRadius.only(
            //                 topRight: Radius.circular(20),
            //                 bottomRight: Radius.circular(20))),
            //       ))
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
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
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Prop1()));
        },
        child: Container(
          height: 200,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: shadowList,
                        ),
                        margin: EdgeInsets.only(top: 80),
                      ),
                    ),
                    Align(
                      child: Container(
                          child: CachedNetworkImage(
                        imageUrl: imgUrl,
                        fit: BoxFit.cover,
                      )),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(top: 60, bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: shadowList,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(propertyTitle,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueGrey[900])),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      desc,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 6,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      price,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          color: Colors.blueGrey[900]),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(PhoneNumber,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 6,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: Colors.yellow[800],
                        ))
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
