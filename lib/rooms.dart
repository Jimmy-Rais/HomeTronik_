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
      backgroundColor: Colors.blueGrey[300], //Colors.blueGrey[300],
      body: Stack(children: <Widget>[
        Positioned(
          top: 50,
          // left: 10,
          child: Container(
            child: Column(
              children: [
                /* Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 210,
                  ),
                  child: Icon(
                    Icons.video_camera_back,
                    color: Colors.red,
                  ),
                ),*/
              ],
            ),
            height: 400,
            width: 410,
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
                color: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(0),
                  bottomRight: Radius.circular(0),
                ),
                image: DecorationImage(
                  image: AssetImage("images/living.jpg"),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueGrey.shade700,
                    // Color of the shadow
                    spreadRadius: 1, // Spread radius of the shadow
                    blurRadius: 10, // Blur radius of the shadow
                    offset: Offset(
                        3, 3), // Offset of the shadow (horizontal, vertical)
                  ),
                  BoxShadow(
                    color: Colors.blueGrey.shade200,
                    // Color of the shadow
                    spreadRadius: 1, // Spread radius of the shadow
                    blurRadius: 10, // Blur radius of the shadow
                    offset: Offset(
                        -4, -4), // Offset of the shadow (horizontal, vertical)
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
        ),
        Positioned(
            top: 60,
            right: 15,
            child: Row(
              children: [
                Container(
                  height: 8,
                  width: 8,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  'Live',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            )),
        Positioned(
            top: 50,
            //  left: 50,
            child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back,
                  size: 25,
                  color: Colors.white,
                ))),
        Positioned(
            top: 110,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: 10),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 90,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey[300],
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
                    child: Center(
                      child: Text(
                        "Living room",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 30,
                    width: 90,
                    color: Colors.grey.withOpacity(0.9),
                    child: Center(
                      child: Text(
                        "Kitchen",
                        style: TextStyle(
                          color: const Color.fromARGB(166, 255, 255, 255),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 30,
                    width: 90,
                    color: Colors.grey.withOpacity(0.9),
                    child: Center(
                      child: Text(
                        "fence",
                        style: TextStyle(
                          color: const Color.fromARGB(166, 255, 255, 255),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 30,
                    width: 90,
                    color: Colors.grey.withOpacity(0.9),
                    child: Center(
                      child: Text(
                        "hall",
                        style: TextStyle(
                          color: const Color.fromARGB(166, 255, 255, 255),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 30,
                    width: 90,
                    color: Colors.grey.withOpacity(0.9),
                    child: Center(
                      child: Text(
                        "Kitchen",
                        style: TextStyle(
                          color: const Color.fromARGB(166, 255, 255, 255),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Container(
                    height: 30,
                    width: 90,
                    color: Colors.grey.withOpacity(0.9),
                    child: Center(
                      child: Text(
                        "guest",
                        style: TextStyle(
                          color: const Color.fromARGB(166, 255, 255, 255),
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
        Positioned(
            top: 390,
            child: Padding(
              padding: const EdgeInsets.only(left: 35),
              child: Container(
                height: 50,
                width: 350,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        // bottom: 10,
                        left: 3,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 5),
                            child: Text(
                              "Living Room",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontWeight: FontWeight.w700,
                                fontSize: 12,
                                fontFamily: 'Abel',
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.device_thermostat_outlined,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                ':',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              DefaultTextStyle(
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 36, 208, 243),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Abel',
                                ),
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    TypewriterAnimatedText(
                                      '22°C',
                                      speed: const Duration(milliseconds: 900),
                                    ),
                                  ],
                                  onTap: () {
                                    print("Tap Event");
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 190),
                    Row(
                      children: [
                        Text(
                          "AC",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.2),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                              //left: 30,
                              bottom: 10,
                            ),
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.toggle_on_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ))),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.8),
                    borderRadius: BorderRadius.all(
                      Radius.circular(90),
                    )),
              ),
            )),
        Positioned(
            bottom: 40,
            left: 25,
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
                              top: 40,
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
                      height: 130,
                      width: 160,
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
                      height: 130,
                      width: 160,
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
                              "Sockets",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      height: 130,
                      width: 160,
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
                                    Icons.window_outlined,
                                    size: 45,
                                    color: Colors.white,
                                  ))),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 24,
                            ),
                            child: Text(
                              "Shutter",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      height: 130,
                      width: 160,
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
        /*  Positioned(
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
        ),*/
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
