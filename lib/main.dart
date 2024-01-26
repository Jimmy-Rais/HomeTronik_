/*
Created by Rais Gachaba Jimmy
*/
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'rooms.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp2());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: signin(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  DatabaseReference ledStatusRef =
      FirebaseDatabase.instance.reference().child('LED_STATUS');
  DatabaseReference TempStatusRef =
      FirebaseDatabase.instance.reference().child('Temperature');
  DatabaseReference HumRef =
      FirebaseDatabase.instance.reference().child('Humidity');
  String currentStatus = 'Loading...';
  double TempStatus = 0.0;
  int HumStatus = 0;
  @override
  void initState() {
    super.initState();
    _loadLEDStatus();
    _loadTempStatus();
    _loadHumStatus();
  }

  _loadLEDStatus() async {
    DatabaseEvent event = await ledStatusRef.once();
    if (event.snapshot.value != null) {
      setState(() {
        currentStatus = event.snapshot.value.toString();
      });
    }
  }

  _loadTempStatus() async {
    DatabaseEvent event = await TempStatusRef.once();
    if (event.snapshot.value != null) {
      double? parsedValue = double.tryParse(event.snapshot.value.toString());
      setState(() {
        TempStatus = parsedValue!;
      });
    }
  }

  _loadHumStatus() async {
    DatabaseEvent event = await HumRef.once();
    if (event.snapshot.value != null) {
      int? parsedValue2 = int.tryParse(event.snapshot.value.toString());
      setState(() {
        HumStatus = parsedValue2!;
      });
    }
  }

  /*_loadLEDStatus() async {
    DataSnapshot snapshot = await ledStatusRef.once() as DataSnapshot;
    setState(() {
      currentStatus = snapshot.value.toString();
    });
  }*/

  _toggleLEDStatus() async {
    String newStatus = currentStatus == 'ON' ? 'OFF' : 'ON';
    await ledStatusRef.set(newStatus);
    setState(() {
      currentStatus = newStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[300],
      //Color.fromRGBO(20, 20, 20, 0.733),
      /*appBar: AppBar(
        
        backgroundColor: Colors.black,
        title: Center(
          child: Text(
            'HomeTronik',
            style: TextStyle(
              color: Colors.white,
              fontSize: ,
            ),
          ),
        ),
      ),*/
      body: Stack(children: <Widget>[
        Positioned(
          top: 50,
          left: 160,
          child: Text(
            '$TempStatus',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        /*
        Positioned(
          bottom: 280,
          left: 20,
          child: Text(
            'Room Humidity:$HumStatus',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Positioned(
          bottom: 100,
          left: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'LED Status: $currentStatus',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _toggleLEDStatus,
                child: Text('Toggle LED'),
              ),
            ],
          ),
        ),*/
        Positioned(
            top: 50,
            right: 20,
            child: IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => rooms()));
                },
                icon: Icon(
                  Icons.menu_outlined,
                  size: 45,
                  color: const Color.fromARGB(183, 255, 255, 255),
                ))),
        Positioned(
          top: 50,
          left: 25,
          child: Column(
            children: [
              Container(
                height: 70,
                width: 70,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    //shape: BoxShape.circle,
                    //borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade700,
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
                          Colors.grey.shade200,
                          Colors.grey.shade400,
                        ])),
                /*decoration: BoxDecoration(
                  //borderRadius: BorderRadius.only(topLeft: Radius.circular(0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      // Color of the shadow
                      spreadRadius: 2, // Spread radius of the shadow
                      blurRadius: 2, // Blur radius of the shadow
                      offset: Offset(
                          0, 0), // Offset of the shadow (horizontal, vertical)
                    ),
                  ],
                  color: Color.fromRGBO(20, 20, 20, 0.733),
                  shape: BoxShape.circle,
                ),*/
                child: CircleAvatar(
                    child: ClipOval(
                  child: SizedBox(
                      width: 65,
                      height: 65,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('images/jim.JPG'),
                        /* Back(
                                        fit: BoxFit.cover,
                                      image: AssetImage('images/Jim.JPG'),
                                      ),
                                    ),*/
                      )),
                )),
              ),
            ],
          ),
        ),
        Positioned(
            left: 35,
            top: 130,
            child: Column(
              children: [
                Text(
                  "Hi Jimmy!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              ],
            )),
        Positioned(
            left: 35,
            top: 148,
            child: Column(children: [
              Text(
                "Welcome to HomeTronik!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ])),
        Positioned(
          top: 190,
          left: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Row(
              children: [
                Container(
                  child: Column(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.wifi,
                            size: 20,
                            color: Colors.white,
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          "Internet",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      )
                    ],
                  ),
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
                  height: 65,
                  width: 65,
                ),
                SizedBox(width: 28),
                Container(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                            top: 0,
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.shower,
                                size: 20,
                                color: Colors.white,
                              ))),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          "Water",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                  /* decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(30),
                      color: Color.fromRGBO(1, 16, 26, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
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
                  height: 65,
                  width: 65,
                ),
                SizedBox(width: 28),
                Container(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                            top: 0,
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.power,
                                size: 28,
                                color: Colors.white,
                              ))),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          "Electricity",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                  /* decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(30),
                      color: Color.fromRGBO(1, 16, 26, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
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
                  height: 65,
                  width: 65,
                ),
                SizedBox(width: 28),
                Container(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                            top: 0,
                          ),
                          child: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                FontAwesomeIcons.trash,
                                size: 20,
                                color: Colors.white,
                              ))),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          "Trash",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      )
                    ],
                  ),
                  /* decoration: BoxDecoration(
                      //borderRadius: BorderRadius.circular(30),
                      color: Color.fromRGBO(1, 16, 26, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
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
                  height: 65,
                  width: 65,
                ),

                /* Neumorphic(
                    style: NeumorphicStyle(
                        shape: NeumorphicShape.concave,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(12)),
                        depth: 8,
                        lightSource: LightSource.topLeft,
                        color: Colors.grey // Background color
                        ),
                    child: Container(
                      color: Color.fromARGB(160, 25, 83, 102),
                      height: 60,
                      width: 60,
                    ),
                  ),*/
              ],
            ),
          ),
        ),
        Positioned(
          top: 280,
          left: 12,
          bottom: 340,
          right: 0,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                    height: 140,
                    width: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        /*image: DecorationImage(
                        image: AssetImage("images/kitchen.jpg"),
                        fit: BoxFit.cover,
                      ),*/
                        //borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade700,
                            // Color of the shadow
                            spreadRadius: 1, // Spread radius of the shadow
                            blurRadius: 10, // Blur radius of the shadow
                            offset: Offset(3,
                                3), // Offset of the shadow (horizontal, vertical)
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
                            // Color of the shadow
                            spreadRadius: 1, // Spread radius of the shadow
                            blurRadius: 2, // Blur radius of the shadow
                            offset: Offset(-0,
                                -1), // Offset of the shadow (horizontal, vertical)
                          ),
                        ],
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.grey.shade200,
                              Colors.grey.shade400,
                            ])),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          image: DecorationImage(
                            image: AssetImage("images/kitchen.jpg"),
                            fit: BoxFit.cover,
                          )),
                    )),
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => rooms()));
                  },
                  child: Container(
                      height: 140,
                      width: 100,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          /*image: DecorationImage(
                          image: AssetImage("images/kitchen.jpg"),
                          fit: BoxFit.cover,
                        ),*/
                          //borderRadius: BorderRadius.circular(30),
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade700,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 3, // Blur radius of the shadow
                              offset: Offset(1,
                                  1), // Offset of the shadow (horizontal, vertical)
                            ),
                            BoxShadow(
                              color: Colors.grey.shade200,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 8, // Blur radius of the shadow
                              offset: Offset(-1,
                                  -1), // Offset of the shadow (horizontal, vertical)
                            ),
                          ],
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.grey.shade200,
                                Colors.grey.shade400,
                              ])),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                            image: DecorationImage(
                              image: AssetImage("images/living.jpg"),
                              fit: BoxFit.cover,
                            )),
                      )),
                ),
                SizedBox(width: 20),
                Container(
                    height: 140,
                    width: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        /*image: DecorationImage(
                        image: AssetImage("images/kitchen.jpg"),
                        fit: BoxFit.cover,
                      ),*/
                        //borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade700,
                            // Color of the shadow
                            spreadRadius: 1, // Spread radius of the shadow
                            blurRadius: 10, // Blur radius of the shadow
                            offset: Offset(3,
                                3), // Offset of the shadow (horizontal, vertical)
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
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
                              Colors.grey.shade200,
                              Colors.grey.shade400,
                            ])),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          image: DecorationImage(
                            image: AssetImage("images/guest.jpg"),
                            fit: BoxFit.cover,
                          )),
                    )),
                SizedBox(width: 20),
                Container(
                    height: 140,
                    width: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        /*image: DecorationImage(
                        image: AssetImage("images/kitchen.jpg"),
                        fit: BoxFit.cover,
                      ),*/
                        //borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade700,
                            // Color of the shadow
                            spreadRadius: 1, // Spread radius of the shadow
                            blurRadius: 10, // Blur radius of the shadow
                            offset: Offset(3,
                                3), // Offset of the shadow (horizontal, vertical)
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
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
                              Colors.grey.shade200,
                              Colors.grey.shade400,
                            ])),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          image: DecorationImage(
                            image: AssetImage("images/fence.jpg"),
                            fit: BoxFit.cover,
                          )),
                    )),
                SizedBox(width: 20),
                Container(
                    height: 140,
                    width: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        /*image: DecorationImage(
                        image: AssetImage("images/kitchen.jpg"),
                        fit: BoxFit.cover,
                      ),*/
                        //borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade700,
                            // Color of the shadow
                            spreadRadius: 1, // Spread radius of the shadow
                            blurRadius: 10, // Blur radius of the shadow
                            offset: Offset(3,
                                3), // Offset of the shadow (horizontal, vertical)
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
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
                              Colors.grey.shade200,
                              Colors.grey.shade400,
                            ])),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          image: DecorationImage(
                            image: AssetImage("images/hall.png"),
                            fit: BoxFit.cover,
                          )),
                    )),
                SizedBox(width: 20),
                Container(
                    height: 140,
                    width: 100,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        /*image: DecorationImage(
                        image: AssetImage("images/kitchen.jpg"),
                        fit: BoxFit.cover,
                      ),*/
                        //borderRadius: BorderRadius.circular(30),
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade700,
                            // Color of the shadow
                            spreadRadius: 1, // Spread radius of the shadow
                            blurRadius: 10, // Blur radius of the shadow
                            offset: Offset(3,
                                3), // Offset of the shadow (horizontal, vertical)
                          ),
                          BoxShadow(
                            color: Colors.grey.shade200,
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
                              Colors.grey.shade200,
                              Colors.grey.shade400,
                            ])),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          image: DecorationImage(
                            image: AssetImage("images/out.jpg"),
                            fit: BoxFit.cover,
                          )),
                    )),
                SizedBox(width: 20),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
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
                              onPressed: _toggleLEDStatus,
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
                              "Lights $currentStatus",
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
        Positioned(
          top: 50,
          left: 150,
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1, right: 50),
                  child: Icon(
                    Icons.cloud,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 3,
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Temp:',
                        style: TextStyle(
                          color: Color.fromARGB(255, 218, 211, 211),
                          fontSize: 10,
                        ),
                      ),
                      DefaultTextStyle(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 36, 208, 243),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Agne',
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              '$TempStatus°C',
                              speed: const Duration(milliseconds: 300),
                            ),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                      /*    Text(
                        '$TempStatus°C',
                        style: TextStyle(
                          color: Color.fromARGB(255, 36, 208, 243),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),*/
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 2,
                    left: 25,
                  ),
                  child: Row(
                    children: [
                      Text(
                        "Hum:",
                        style: TextStyle(
                            color: Color.fromARGB(255, 218, 211, 211),
                            fontSize: 10),
                      ),
                      DefaultTextStyle(
                        style: const TextStyle(
                          color: Color.fromARGB(255, 36, 208, 243),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'Agne',
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            TypewriterAnimatedText(
                              '$HumStatus%',
                              speed: const Duration(milliseconds: 300),
                            ),
                          ],
                          onTap: () {
                            print("Tap Event");
                          },
                        ),
                      ),
                      /* Text(
                        "$HumStatus%",
                        style: TextStyle(
                          color: Color.fromARGB(255, 36, 208, 243),
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                        ),
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
            /* decoration: BoxDecoration(
                //borderRadius: BorderRadius.circular(30),
                color: //Color.fromARGB(165, 3, 27, 35)
                    Color.fromRGBO(1, 16, 26, 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(162, 172, 203, 214),
                    // Color of the shadow
                    spreadRadius: 2, // Spread radius of the shadow
                    blurRadius: 2, // Blur radius of the shadow
                    offset: Offset(
                        0, 5), // Offset of the shadow (horizontal, vertical)
                  ),
                ]),*/
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                //borderRadius: BorderRadius.circular(30),
                color: Colors.blueGrey[300],
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
            height: 60,
            width: 85,
          ),
        ),
      ]),
    );
  }
}
