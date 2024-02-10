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
import 'package:flutter_tts/flutter_tts.dart';

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
  bool dark_theme = false;
  bool newdarktheme = false;
  var kitchen = "images/kitchen.jpg";
  var guest = "images/guest.jpg";
  var living = "images/living.jpg";
  var hall = "images/hall.jpg";
  var out = "images/out.jpg";
  var fence = "images/fence.jpg";
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
    _toggle();
  }

  _toggle() async {
    dark_theme == true ? false : true;
    print(dark_theme);
    setState(() {
      dark_theme = !dark_theme; //? false : true;
      print(dark_theme);
    });
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
      backgroundColor: dark_theme
          ? Colors.black
          : Color.fromARGB(255, 255, 255, 255), //Colors.blueGrey[300],
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
        Positioned(
            top: 50,
            right: 20,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu_outlined,
                  size: 45,
                  color: dark_theme
                      ? Color.fromARGB(183, 255, 255, 255)
                      : Colors.black,
                ))),
        Positioned(
            top: 30,
            right: 70,
            child: IconButton(
                onPressed: () {
                  _toggle();
                },
                icon: Icon(
                  dark_theme ? Icons.toggle_off : Icons.toggle_on,
                  size: 45,
                  color: dark_theme
                      ? Color.fromARGB(183, 255, 255, 255)
                      : Colors.black,
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
                    color: dark_theme ? Colors.white : Colors.grey[300],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60),
                      bottomRight: Radius.circular(60),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: dark_theme ? Colors.white : Colors.grey.shade700,
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
                          dark_theme
                              ? Colors.black
                              : Color.fromARGB(255, 233, 231, 231),
                          dark_theme
                              ? Colors.black
                              : Color.fromARGB(255, 245, 242, 242)
                        ])),
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
                    color: dark_theme ? Colors.white : Colors.black,
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
                  color: dark_theme ? Colors.white : Colors.black,
                  fontSize: 10,
                ),
              ),
            ])),
        Positioned(
          top: 190,
          left: 3,
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: SingleChildScrollView(
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
                              color: dark_theme ? Colors.white : Colors.black,
                            )),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Text(
                            "Internet",
                            style: TextStyle(
                              color: dark_theme ? Colors.white : Colors.black,
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
                            color: dark_theme
                                ? Colors.white
                                : Colors.blueGrey.shade700,
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
                              dark_theme
                                  ? Colors.black
                                  : Colors.white, //Colors.blueGrey.shade200,
                              dark_theme
                                  ? Colors.black
                                  : Color.fromARGB(255, 255, 255,
                                      255), //Colors.blueGrey.shade400,
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
                                  color:
                                      dark_theme ? Colors.white : Colors.black,
                                ))),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Text(
                            "Water",
                            style: TextStyle(
                              color: dark_theme ? Colors.white : Colors.black,
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
                            color: dark_theme
                                ? Colors.white
                                : Colors.blueGrey.shade700,
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
                              dark_theme ? Colors.black : Colors.white,
                              dark_theme ? Colors.black : Colors.white,
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
                                  Icons.gas_meter,
                                  size: 28,
                                  color:
                                      dark_theme ? Colors.white : Colors.black,
                                ))),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Text(
                            "Smart meter",
                            style: TextStyle(
                              color: dark_theme ? Colors.white : Colors.black,
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
                            color: dark_theme
                                ? Colors.white
                                : Colors.blueGrey.shade700,
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
                              dark_theme ? Colors.black : Colors.white,
                              dark_theme ? Colors.black : Colors.white,
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
                                  color:
                                      dark_theme ? Colors.white : Colors.black,
                                ))),
                        Padding(
                          padding: EdgeInsets.only(top: 0),
                          child: Text(
                            "Trash",
                            style: TextStyle(
                              color: dark_theme ? Colors.white : Colors.black,
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
                            color: dark_theme
                                ? Colors.white
                                : Colors.blueGrey.shade700,
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
                              dark_theme ? Colors.black : Colors.white,
                              dark_theme ? Colors.black : Colors.white,
                            ])),
                    height: 65,
                    width: 65,
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 310,
          left: 12,
          right: 15,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => rooms(dark_theme, kitchen)));
                  },
                  child: Container(
                      height: 250,
                      width: 150,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: dark_theme ? Colors.white : Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 3, // Blur radius of the shadow
                              offset: Offset(1,
                                  1), // Offset of the shadow (horizontal, vertical)
                            ),
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
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
                              image: AssetImage("images/kitchen.jpg"),
                              fit: BoxFit.cover,
                            )),
                      )),
                ),
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => rooms(dark_theme, living)));
                  },
                  child: Container(
                      height: 250,
                      width: 150,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: dark_theme ? Colors.white : Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 3, // Blur radius of the shadow
                              offset: Offset(1,
                                  1), // Offset of the shadow (horizontal, vertical)
                            ),
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => rooms(dark_theme, guest)));
                  },
                  child: Container(
                      height: 250,
                      width: 150,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: dark_theme ? Colors.white : Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 3, // Blur radius of the shadow
                              offset: Offset(1,
                                  1), // Offset of the shadow (horizontal, vertical)
                            ),
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
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
                              image: AssetImage("images/guest.jpg"),
                              fit: BoxFit.cover,
                            )),
                      )),
                ),
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => rooms(dark_theme, fence)));
                  },
                  child: Container(
                      height: 250,
                      width: 150,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: dark_theme ? Colors.white : Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 3, // Blur radius of the shadow
                              offset: Offset(1,
                                  1), // Offset of the shadow (horizontal, vertical)
                            ),
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
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
                              image: AssetImage("images/fence.jpg"),
                              fit: BoxFit.cover,
                            )),
                      )),
                ),
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => rooms(dark_theme, fence)));
                  },
                  child: Container(
                      height: 250,
                      width: 150,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: dark_theme ? Colors.white : Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 3, // Blur radius of the shadow
                              offset: Offset(1,
                                  1), // Offset of the shadow (horizontal, vertical)
                            ),
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
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
                              image: AssetImage("images/hall.png"),
                              fit: BoxFit.cover,
                            )),
                      )),
                ),
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => rooms(dark_theme, out)));
                  },
                  child: Container(
                      height: 250,
                      width: 150,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: dark_theme ? Colors.white : Colors.black,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
                              // Color of the shadow
                              spreadRadius: 1, // Spread radius of the shadow
                              blurRadius: 3, // Blur radius of the shadow
                              offset: Offset(1,
                                  1), // Offset of the shadow (horizontal, vertical)
                            ),
                            BoxShadow(
                              color: dark_theme ? Colors.black : Colors.white,
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
                              image: AssetImage("images/out.jpg"),
                              fit: BoxFit.cover,
                            )),
                      )),
                ),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
        Positioned(
          top: 45,
          left: 150,
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 1, right: 50),
                  child: Icon(
                    Icons.cloud,
                    size: 18,
                    color: dark_theme ? Colors.white : Colors.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 1,
                    left: 16,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Temp:',
                        style: TextStyle(
                          color: dark_theme ? Colors.white : Colors.black,
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
                            color: dark_theme ? Colors.white : Colors.black,
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
                    color: dark_theme ? Colors.white : Colors.blueGrey.shade700,
                    // Color of the shadow
                    spreadRadius: 1, // Spread radius of the shadow
                    blurRadius: 10, // Blur radius of the shadow
                    offset: Offset(
                        3, 3), // Offset of the shadow (horizontal, vertical)
                  ),
                  BoxShadow(
                    color: Colors.white,
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
                      dark_theme ? Colors.black : Colors.white,
                      dark_theme ? Colors.black : Colors.white,
                    ])),
            height: 60,
            width: 85,
          ),
        ),
      ]),
    );
  }
}
