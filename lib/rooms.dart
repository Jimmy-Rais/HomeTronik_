import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class rooms extends StatefulWidget {
  const rooms({super.key});

  @override
  State<rooms> createState() => _roomsState();
}

class _roomsState extends State<rooms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      body: Stack(children: <Widget>[
        Positioned(
            bottom: 30,
            left: 10,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.lightbulb,
                                size: 35,
                                color: Colors.yellow,
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 25,
                            ),
                            child: Text(
                              "Lights",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      height: 110,
                      width: 140,
                      /*decoration: BoxDecoration(
                          color: Color.fromRGBO(1, 16, 26, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              // Color of the shadow
                              spreadRadius: 2, // Spread radius of the shadow
                              blurRadius: 5, // Blur radius of the shadow
                              offset: Offset(-2,
                                  -2), // Offset of the shadow (horizontal, vertical)
                            ),
                          ]),*/
                      decoration: BoxDecoration(

                          //borderRadius: BorderRadius.circular(30),
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.shade700,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 10, // Blur radius of the shadow
                              offset: Offset(3,
                                  3), // Offset of the shadow (horizontal, vertical)
                            ),
                            BoxShadow(
                              color: Colors.blueGrey.shade200,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 10, // Blur radius of the shadow
                              offset: Offset(-4,
                                  -4), // Offset of the shadow (horizontal, vertical)
                            ),
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blueGrey.shade200,
                                Colors.blueGrey.shade400,
                              ])),
                    ),
                    SizedBox(width: 50),
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.toggle_off,
                                size: 55,
                                color: Colors.white,
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 25,
                            ),
                            child: Text(
                              "Air Conditionners",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      height: 110,
                      width: 140,
                      /*decoration: BoxDecoration(
                          color: Color.fromRGBO(1, 16, 26, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              // Color of the shadow
                              spreadRadius: 2, // Spread radius of the shadow
                              blurRadius: 5, // Blur radius of the shadow
                              offset: Offset(2,
                                  -2), // Offset of the shadow (horizontal, vertical)
                            ),
                          ]),*/
                      decoration: BoxDecoration(

                          //borderRadius: BorderRadius.circular(30),
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.shade700,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 10, // Blur radius of the shadow
                              offset: Offset(3,
                                  3), // Offset of the shadow (horizontal, vertical)
                            ),
                            BoxShadow(
                              color: Colors.blueGrey.shade200,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 10, // Blur radius of the shadow
                              offset: Offset(-4,
                                  -4), // Offset of the shadow (horizontal, vertical)
                            ),
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blueGrey.shade200,
                                Colors.blueGrey.shade400,
                              ])),
                    ),
                  ],
                ),
                SizedBox(height: 25),
                Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                top: 10,
                                right: 5,
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.video_camera_back,
                                    size: 45,
                                    color: Colors.white,
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 22,
                            ),
                            child: Text(
                              "Cameras",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      height: 110,
                      width: 140,
                      /*  decoration: BoxDecoration(
                          color: Color.fromRGBO(1, 16, 26, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              // Color of the shadow
                              spreadRadius: 2, // Spread radius of the shadow
                              blurRadius: 5, // Blur radius of the shadow
                              offset: Offset(-2,
                                  -2), // Offset of the shadow (horizontal, vertical)
                            ),
                          ]),*/
                      decoration: BoxDecoration(

                          //borderRadius: BorderRadius.circular(30),
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.shade700,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 10, // Blur radius of the shadow
                              offset: Offset(3,
                                  3), // Offset of the shadow (horizontal, vertical)
                            ),
                            BoxShadow(
                              color: Colors.blueGrey.shade200,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 10, // Blur radius of the shadow
                              offset: Offset(-4,
                                  -4), // Offset of the shadow (horizontal, vertical)
                            ),
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blueGrey.shade200,
                                Colors.blueGrey.shade400,
                              ])),
                    ),
                    SizedBox(width: 50),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                right: 15,
                              ),
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.lock_rounded,
                                    size: 45,
                                    color:
                                        const Color.fromARGB(255, 235, 49, 36),
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 24,
                            ),
                            child: Text(
                              "Home Security",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      height: 110,
                      width: 140,
                      /* decoration: BoxDecoration(
                          color: Color.fromRGBO(1, 16, 26, 1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white,
                              // Color of the shadow
                              spreadRadius: 2, // Spread radius of the shadow
                              blurRadius: 5, // Blur radius of the shadow
                              offset: Offset(2,
                                  -2), // Offset of the shadow (horizontal, vertical)
                            ),
                          ]),*/
                      decoration: BoxDecoration(

                          //borderRadius: BorderRadius.circular(30),
                          color: Colors.blueGrey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey.shade700,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 10, // Blur radius of the shadow
                              offset: Offset(3,
                                  3), // Offset of the shadow (horizontal, vertical)
                            ),
                            BoxShadow(
                              color: Colors.blueGrey.shade200,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 10, // Blur radius of the shadow
                              offset: Offset(-4,
                                  -4), // Offset of the shadow (horizontal, vertical)
                            ),
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blueGrey.shade200,
                                Colors.blueGrey.shade400,
                              ])),
                    ),
                  ],
                ),
              ],
            )),
        Positioned(
            bottom: 290,
            left: 25,
            child: Text(
              "Devices",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            )),
        Positioned(
          bottom: 280,
          right: 10,
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              )),
        ),
      ]), /*Stack(
        children: <Widget>[
          Container(
            height: 850,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              image: DecorationImage(
                image: AssetImage("images/home.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
            //child: Image(image: AssetImage("images/avatar/home.jpeg")),
          ),
          Positioned(
              bottom: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                decoration: BoxDecoration(
                    color: Colors.blueGrey.shade700,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    )),
              ))
        ],
      ),*/
    );
  }
}
