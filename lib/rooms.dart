import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'speechTotext.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'appliances.dart';

/*
Global variables declaration: Database path reference for appliances
*/
DatabaseReference acStatusRef =
    FirebaseDatabase.instance.reference().child('AC_STATUS');
DatabaseReference fanStatusRef =
    FirebaseDatabase.instance.reference().child('FAN_STATUS');
DatabaseReference ledStatusRef =
    FirebaseDatabase.instance.reference().child('LED_STATUS');
DatabaseReference TempStatusRef =
    FirebaseDatabase.instance.reference().child('Temperature');
DatabaseReference HumRef =
    FirebaseDatabase.instance.reference().child('Humidity');
double TempStatus = 0.0;
int HumStatus = 0;

//Rooms widget: Takes as parameter the main theme and the image of the room
class rooms extends StatefulWidget {
  rooms(this.dark_theme, this.img, {super.key});
  bool dark_theme; //main theme,dark or light
  var img; //Room image
  @override
  State<rooms> createState() => _roomsState();
}

class _roomsState extends State<rooms> {
  /*Initialization of appliances states variables*/

  //Flutter text to speech object creation
  final FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText? _speech;
  String _text = "";
  bool _isListening = false;
  //Initialize boolean variables associated to appliances states
  bool led = false;
  bool fan = false;
  bool ac = false;
  bool socket = false;
  bool shutter = false;
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _listen();
    _led();
    _ac();
    _fan();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech!.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;

            if (_text == "Jimmy") {
              flutterTts.speak(
                  'Welcome to HomeTronik,a new SmartHome experience.To switch on a device(For example Light,Fan,AC,Socket,Smart tv) say SWITCH ON Device name or click on the corresponding button...To switch it off ,say SWITCH OFF Device name or click on the corresponding Button.For example: Switch on Light.Switch off Light. To know the temperature of the room,say TEMPERATURE...Let me know if you need to know something else');
            } else if (_text == "Switch on light") {
              flutterTts.speak(
                  'Welcome to HomeTronik,a  SmartHome experience.To switch on a device(For example Light,Fan,AC,Socket,Smart tv) say SWITCH ON Device name...To switch it off ,say SWITCH OFF Device name.For example: Switch on Light.Switch off Light. To know the temperature of the room,say TEMPERATURE...Let me know if you need to know something else');
            }
            _isListening = true;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech!.stop();
    }
  }

// Functions that toggle the appliances states
  void _led() {
    setState(() {
      led = !led;
      ledStatusRef.set(led);
    });
  }

  void _ac() {
    setState(() {
      ac = !ac;
      acStatusRef.set(ac);
    });
  }

  void _fan() {
    setState(() {
      fan = !fan;
      fanStatusRef.set(fan);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.dark_theme ? Colors.black : Colors.blueGrey[300],
      // // Colors.blueGrey[300],
      body: Stack(children: <Widget>[
        Positioned(
          top: 0,
          // left: 10,
          child: Container(
            child: Column(
              children: [],
            ),
            height: 400,
            width: 410,
            decoration: BoxDecoration(

                //borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 0, 0, 0),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(45),
                  bottomRight: Radius.circular(120),
                ),
                image: DecorationImage(
                  image: AssetImage(widget.img),
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
            top: 40,
            //  left: 50,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      size: 20,
                      color: Colors.white,
                    )),
                SizedBox(width: 50),
                IconButton(
                  onPressed: _listen,
                  icon: Icon(_isListening! ? Icons.mic : Icons.mic_none),
                ),
              ],
            )),
        Positioned(
            top: 90,
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
                            color: widget.dark_theme
                                ? Colors.blueGrey.shade700
                                : Colors.grey,
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
                              widget.dark_theme
                                  ? Colors.black
                                  : Colors.blueGrey.shade200,
                              widget.dark_theme
                                  ? Colors.black
                                  : Colors.blueGrey.shade400,
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
                        "fence",
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
                        "hall",
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
            top: 330,
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                //  color: const Color.fromARGB(86, 158, 158, 158),
                height: 50,
                width: 340,
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
                            color: Colors.white,
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
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Speechtotext()));
                                },
                                icon: Icon(
                                  ac
                                      ? Icons.toggle_on_outlined
                                      : Icons.toggle_off_outlined,
                                  color: ac ? Colors.blue : Colors.white,
                                  size: 30,
                                ))),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: Color.fromARGB(170, 135, 134, 134).withOpacity(0.9),
                    borderRadius: BorderRadius.all(
                      Radius.circular(90),
                    )),
              ),
            )),
        Positioned(
            bottom: 30,
            left: 20,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(width: 10),
                              IconButton(
                                  onPressed: () {
                                    //Send the toogle command to the appliance widget
                                    //appliances(led);
                                    ();
                                  },
                                  icon: Icon(
                                    Icons.lightbulb_rounded,
                                    size: led ? 30 : 20,
                                    color: led ? Colors.yellow : Colors.white,
                                  )),
                              SizedBox(width: 20),
                              IconButton(
                                  onPressed: () {
                                    flutterTts.speak('Light switched  on');
                                    setState(() {
                                      _led();
                                      //_loadLEDStatus();
                                    });
                                  },
                                  icon: Icon(
                                    led
                                        ? Icons.toggle_on_outlined
                                        : Icons.toggle_off_outlined,
                                    color: led ? Colors.yellow : Colors.white,
                                    size: 30,
                                  ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 60,
                            ),
                            child: Row(children: [
                              Padding(padding: EdgeInsets.only(left: 35)),
                              Text(
                                "Light Bulbs",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      height: 140,
                      width: 150,
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
                                widget.dark_theme
                                    ? Colors.black
                                    : Colors.blueGrey.shade200,
                                widget.dark_theme
                                    ? Colors.black
                                    : Colors.blueGrey.shade400,
                                //Colors.blueGrey.shade200,
                                //Colors.blueGrey.shade400,
                              ])),
                    ),
                    SizedBox(width: 25),
                    Container(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.mode_fan_off_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  )),
                              SizedBox(width: 40),
                              IconButton(
                                  onPressed: () {
                                    _fan();
                                  },
                                  icon: Icon(
                                    fan
                                        ? Icons.toggle_on_outlined
                                        : Icons.toggle_off_outlined,
                                    color: fan ? Colors.blue : Colors.white,
                                    size: 25,
                                  ))
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 60,
                            ),
                            child: Text(
                              "Fans",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      height: 140,
                      width: 150,
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
                                widget.dark_theme
                                    ? Colors.black
                                    : Colors.blueGrey.shade200,
                                widget.dark_theme
                                    ? Colors.black
                                    : Colors.blueGrey.shade400,
                              ])),
                    ),
                  ],
                ),
                SizedBox(height: 20),
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
                              child: Row(
                                children: [
                                  SizedBox(width: 15),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.electrical_services_sharp,
                                        size: 35,
                                        color: Colors.white,
                                      )),
                                  SizedBox(width: 20),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.toggle_off_outlined,
                                        size: 25,
                                        color: Colors.white,
                                      )),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 55,
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
                      height: 140,
                      width: 150,
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
                                widget.dark_theme
                                    ? Colors.black
                                    : Colors.blueGrey.shade200,
                                widget.dark_theme
                                    ? Colors.black
                                    : Colors.blueGrey.shade400,
                              ])),
                    ),
                    SizedBox(width: 30),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                top: 8,
                                right: 15,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: 10),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.window_outlined,
                                        size: 35,
                                        color: Colors.white,
                                      )),
                                  SizedBox(width: 15),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.toggle_off_outlined,
                                        size: 25,
                                        color: Colors.white,
                                      )),
                                ],
                              )),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 2,
                            ),
                            child: Row(children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                left: 45,
                                top: 80,
                              )),
                              Text(
                                "Shutter",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ]),
                          )
                        ],
                      ),
                      height: 140,
                      width: 150,
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
                                widget.dark_theme
                                    ? Colors.black
                                    : Colors.blueGrey.shade200,
                                widget.dark_theme
                                    ? Colors.black
                                    : Colors.blueGrey.shade400,
                                //Colors.blueGrey.shade200,
                                //Colors.blueGrey.shade400,
                              ])),
                    ),
                  ],
                ),
              ],
            )),
      ]),
    );
  }
}
