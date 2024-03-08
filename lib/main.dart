/*
Created by Rais Gachaba Jimmy    
*/
import 'package:esp/Voice_Assistant/mainassistant.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'Pages/signin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Pages/rooms.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'Bills/electricitybills.dart';
import 'package:esp/ButtonStyling/buttons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:esp/Voice_Assistant/mainassistant.dart';

//import 'package:syncfusion_flutter_gauges/gauges.dart';
//import 'package:syncfusion_flutter_charts/sparkcharts.dart';
/*import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';*/
const talk = "images/tk.gif";
const sleep = "images/sleep.gif";
const listen = "images/listen.gif";
const talk_d = "images/talk_d.gif";
const sleep_d = "images/sleep_d.gif";
const listen_d = "images/listen_d.gif";
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
  bool isDaily = false;
  String plotype = "monthly";
  double plotwidth = 0;
  bool dark_theme = false;
  bool newdarktheme = false;
  String dropdownValue = 'daily';
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
    _plotCat();
  }

  void updatePlotName(String newPlotName) {
    setState(() {
      plotype = newPlotName;
    });
  }

  _toggle() async {
    dark_theme == true ? false : true;
    print(dark_theme);
    setState(() {
      dark_theme = !dark_theme; //? false : true;
      print(dark_theme);
    });
  }

  _plotCat() async {
    isDaily == true ? false : true;
    isDaily ? plotype = "daily" : plotype = "weekly";
    setState(() {
      isDaily = !isDaily; //? false : true;
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
            left: 20,
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
            left: 20,
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
            top: 150,
            left: 240,
            right: 5,
            child: voiceassist2(
                dark_theme,
                dark_theme
                    ? sleep_d
                    : sleep) /*InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(dark_theme ? sleep_d : sleep),
            ),
          ),*/
            ),

        /* SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              //Main Features buttons
              children: [
                buttonStyle2(Icons.wifi, dark_theme, "Internet", () {}),
                SizedBox(width: 28),
                buttonStyle2(
                    FontAwesomeIcons.shower, dark_theme, "Water", () {}),
                SizedBox(width: 28),
                buttonStyle2(Icons.gas_meter, dark_theme, "Smart meter", () {}),
                SizedBox(width: 28),
                buttonStyle2(
                    FontAwesomeIcons.trash, dark_theme, "Trash", () {}),
                SizedBox(width: 28),
                buttonStyle2(
                    FontAwesomeIcons.trash, dark_theme, "Trash", () {}),
              ],
            ),
          ),
        ),*/
        Positioned(
          top: 310,
          left: 12,
          right: 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                //Kitchen decorated button
                buttonStyle(kitchen, dark_theme, () {
                  /*Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          rooms(dark_theme, kitchen),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = 0.0;
                        var end = 1.0;
                        var curve = Curves.ease;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return ScaleTransition(
                          scale: animation.drive(tween),
                          child: child,
                        );
                      },
                    ),
                  );*/

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => rooms(dark_theme, kitchen)));
                }),
                SizedBox(width: 20),
                //living room decorated button
                buttonStyle(living, dark_theme, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => rooms(dark_theme, living)));
                }),
                SizedBox(width: 20),
                //Guest room decorated button
                buttonStyle(guest, dark_theme, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => rooms(dark_theme, guest)));
                }),
                SizedBox(width: 20),
                //Fence decorated Button
                buttonStyle(fence, dark_theme, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => rooms(dark_theme, fence)));
                }),
                SizedBox(width: 20),
                //Hall decorated Button
                /* buttonStyle(hall, dark_theme, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => rooms(dark_theme, hall)));
                }),*/
                //Out decoration button
                buttonStyle(out, dark_theme, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => rooms(dark_theme, out)));
                }),
                SizedBox(width: 20),
              ],
            ),
          ),
        ),
        Positioned(
          top: 45,
          left: 130,
          child: progress(),

          /*Container(
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
          ),*/
        ),
        Positioned(
          bottom: 5,
          left: 1,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 250, top: 220),
                child: DropdownButton<String>(
                  value: plotype,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(
                      color: dark_theme ? Colors.grey : Colors.black,
                      fontSize: 16),
                  underline: Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  onChanged: (String? newValue) {
                    switch (newValue) {
                      case 'daily':
                        updatePlotName('daily');
                        break;
                      case 'monthly':
                        updatePlotName('monthly');
                        break;
                      case 'weekly':
                        updatePlotName('weekly');
                        break;
                      default:
                        // Handle unexpected options (optional)
                        break;
                    }
                  },
                  items: <String>['daily', 'weekly', 'monthly']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: bills(plotype),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
