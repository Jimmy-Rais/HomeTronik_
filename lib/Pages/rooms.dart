import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../Voice_Assistant/speechTotext.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:knob_widget/knob_widget.dart';
import 'dart:async';

//Images
const kitchen = "images/kitchen.jpg";
const guest = "images/guest.jpg";
const living = "images/living.jpg";
const hall = "images/hall.jpg";
const out = "images/out.jpg";
const fence = "images/fence.jpg";
bool isKitchen = false;
bool isGuest = false;
bool isFence = false;
bool isHall = false;
bool isLiving = false;
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

//Rooms widget: Takes as parameter the main theme and the image of the room
//assign to the boolean variable _isRoomname true if the image of the room is displayed
class rooms extends StatefulWidget {
  rooms(this.dark_theme, this.img, {super.key});
  bool dark_theme; //main theme,dark or light
  var img; //Room image

  @override
  State<rooms> createState() => _roomsState();
}

class _roomsState extends State<rooms> {
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  /*Initialization of appliances states variables*/
  double TempStatus = 0.0;
  int HumStatus = 0;
  //Flutter text to speech object creation
  final FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText? _speech;
  String _text = "";
  bool _isListening = false;
  //Initialize boolean variables associated to appliances states
  _loadLEDStatus() async {
    DatabaseEvent event = await ledStatusRef.once();
    bool? parsedValue = bool.tryParse(event.snapshot.value.toString());
    if (event.snapshot.value != null) {
      setState(() {
        bool led = parsedValue!;
      });
    }
  }

  bool led = false;
  bool fan = false;
  bool ac = false;
  bool socket = false;
  bool shutter = false;
  KnobController _controller = KnobController(
    initial: 2,
    minimum: 1,
    maximum: 5,
    startAngle: 0,
    endAngle: 180,
  );
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _listen();
    _led(); //Toggle the led state
    _ac(); //Toggle the ac state
    _fan(); //Toggle the fan state
    _roomname();
    _loadTempStatus(); //Retrieve the actual room state
  }

  void _roomname() {
    if (widget.img == kitchen) {
      setState(() {
        isKitchen = true;
        isGuest = false;
        isFence = false;
        isHall = false;
        isLiving = false;
      });
    } else if (widget.img == hall) {
      setState(() {
        isHall = true;
        isGuest = false;
        isFence = false;
        isLiving = false;
        isKitchen = false;
      });
    } else if (widget.img == living) {
      setState(() {
        isLiving = true;
        isHall = false;
        isGuest = false;
        isFence = false;
        isKitchen = false;
      });
    } else if (widget.img == fence) {
      setState(() {
        isFence = true;
        isHall = false;
        isGuest = false;
        isLiving = false;
        isKitchen = false;
      });
    }
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
            // appliances controlled by voice commands
            if (_text == "Jimmy") {
              flutterTts.speak(
                  'Yes....Welcome to HomeTronik,a new SmartHome experience.How can I assist you');
            } else if (_text == "switch on light") {
              flutterTts.speak("Light switched on");
              _led();
            } else if (_text == "switch off light") {
              flutterTts.speak("Light switched off ");
              _led();
            } else if (_text == "switch on fan") {
              flutterTts.speak("Fan switched on ");
              _fan();
            } else if (_text == "switch off fan") {
              flutterTts.speak("Fan switched switched off ");
              _fan();
            } else if (_text == "switch on AC") {
              flutterTts.speak("AC switched on ");
              _ac();
            } else if (_text == "switch off AC") {
              flutterTts.speak("AC switched off ");
              _ac();
            } else if (_text == "temperature") {
              _loadTempStatus();
              flutterTts
                  .speak("The room temperature is$TempStatus Degrees Celsius");
            } else if (_text == "living room") {
              flutterTts.speak("Welcome to the Living room screen");
              setState(() {
                widget.img = living;
                _roomname();
              });
            } else if (_text == "fence") {
              flutterTts.speak("Welcome to the fence screen");
              setState(() {
                widget.img = fence;
                _roomname();
              });
            } else if (_text == "balcony") {
              flutterTts.speak("Welcome to the balcony screen");
              setState(() {
                widget.img = out;
                _roomname();
              });
            } else if (_text == "kitchen") {
              flutterTts.speak("Welcome to the kitchen screen");
              setState(() {
                widget.img = kitchen;
                _roomname();
              });
            } else if (_text == "main screen") {
              flutterTts.speak("Welcome to the main screen");
              Navigator.pop(context);
            }
            _isListening = true;
            //_listen();
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech!.stop();
    }
  }

//Function to retrieve Temperature and Humidity of the room
  _loadTempStatus() async {
    DatabaseEvent event = await TempStatusRef.once();
    if (event.snapshot.value != null) {
      double? parsedValue = double.tryParse(event.snapshot.value.toString());
      setState(() {
        TempStatus = parsedValue!;
      });
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
      backgroundColor: widget.dark_theme ? Colors.black : Colors.white,
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
                  onPressed: () {
                    _timer?.cancel();
                    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
                      _listen();
                    });
                  }, // _listen,
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
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.img = living;
                        _roomname();
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 90,
                      decoration: isLiving
                          ? BoxDecoration(
                              color: Colors.blueGrey[300],
                              boxShadow: [
                                BoxShadow(
                                  color: widget.dark_theme
                                      ? Colors.white
                                      : Colors.grey,
                                  // Color of the shadow
                                  spreadRadius:
                                      1, // Spread radius of the shadow
                                  blurRadius: 10, // Blur radius of the shadow
                                  offset: Offset(3,
                                      3), // Offset of the shadow (horizontal, vertical)
                                ),
                                BoxShadow(
                                  color: Colors.blueGrey.shade200,
                                  // Color of the shadow
                                  spreadRadius:
                                      1, // Spread radius of the shadow
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
                                        : Colors.white,
                                    widget.dark_theme
                                        ? Colors.black
                                        : Colors.white,
                                  ]))
                          : BoxDecoration(
                              color: Colors.grey.withOpacity(0.9),
                            ),
                      child: Center(
                        child: Text(
                          "Living room",
                          style: TextStyle(
                            color:
                                widget.dark_theme ? Colors.white : Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.img = kitchen;
                        _roomname();
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 90,
                      decoration: isKitchen
                          ? BoxDecoration(
                              color: Colors.blueGrey[300],
                              boxShadow: [
                                BoxShadow(
                                  color: widget.dark_theme
                                      ? Colors.blueGrey.shade700
                                      : Colors.grey,
                                  // Color of the shadow
                                  spreadRadius:
                                      1, // Spread radius of the shadow
                                  blurRadius: 10, // Blur radius of the shadow
                                  offset: Offset(3,
                                      3), // Offset of the shadow (horizontal, vertical)
                                ),
                                BoxShadow(
                                  color: Colors.blueGrey.shade200,
                                  // Color of the shadow
                                  spreadRadius:
                                      1, // Spread radius of the shadow
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
                                        : Colors.white,
                                    widget.dark_theme
                                        ? Colors.black
                                        : Colors.white,
                                  ]))
                          : BoxDecoration(
                              color: Colors.grey.withOpacity(0.9),
                            ),
                      child: Center(
                        child: Text(
                          "Kitchen",
                          style: TextStyle(
                            color:
                                widget.dark_theme ? Colors.white : Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.img = fence;
                        _roomname();
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 90,
                      decoration: isFence
                          ? BoxDecoration(
                              color: Colors.blueGrey[300],
                              boxShadow: [
                                BoxShadow(
                                  color: widget.dark_theme
                                      ? Colors.blueGrey.shade700
                                      : Colors.grey,
                                  // Color of the shadow
                                  spreadRadius:
                                      1, // Spread radius of the shadow
                                  blurRadius: 10, // Blur radius of the shadow
                                  offset: Offset(3,
                                      3), // Offset of the shadow (horizontal, vertical)
                                ),
                                BoxShadow(
                                  color: Colors.blueGrey.shade200,
                                  // Color of the shadow
                                  spreadRadius:
                                      1, // Spread radius of the shadow
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
                                        : Colors.white,
                                    widget.dark_theme
                                        ? Colors.black
                                        : Colors.white,
                                  ]))
                          : BoxDecoration(
                              color: Colors.grey.withOpacity(0.9),
                            ),
                      child: Center(
                        child: Text(
                          "fence",
                          style: TextStyle(
                            color:
                                widget.dark_theme ? Colors.white : Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.img = out;
                        _roomname();
                      });
                    },
                    child: Container(
                      height: 30,
                      width: 90,
                      decoration: isHall
                          ? BoxDecoration(
                              color: Colors.blueGrey[300],
                              boxShadow: [
                                BoxShadow(
                                  color: widget.dark_theme
                                      ? Colors.blueGrey.shade700
                                      : Colors.grey,
                                  // Color of the shadow
                                  spreadRadius:
                                      1, // Spread radius of the shadow
                                  blurRadius: 10, // Blur radius of the shadow
                                  offset: Offset(3,
                                      3), // Offset of the shadow (horizontal, vertical)
                                ),
                                BoxShadow(
                                  color: Colors.blueGrey.shade200,
                                  // Color of the shadow
                                  spreadRadius:
                                      1, // Spread radius of the shadow
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
                                        : Colors.white,
                                    widget.dark_theme
                                        ? Colors.black
                                        : Colors.white,
                                  ]))
                          : BoxDecoration(
                              color: Colors.grey.withOpacity(0.9),
                            ),
                      child: Center(
                        child: Text(
                          "hall",
                          style: TextStyle(
                            color:
                                widget.dark_theme ? Colors.white : Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
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
                                color: widget.dark_theme
                                    ? Colors.white
                                    : Colors.black,
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
                                color: widget.dark_theme
                                    ? Colors.white
                                    : Colors.black,
                                size: 20,
                              ),
                              Text(
                                ':',
                                style: TextStyle(
                                  color: widget.dark_theme
                                      ? Colors.white
                                      : Colors.black,
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
                                      '$TempStatus',
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
                            color:
                                widget.dark_theme ? Colors.white : Colors.black,
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
                                  !ac
                                      ? flutterTts.speak('on')
                                      : flutterTts.speak('off');
                                  _ac();
                                },
                                icon: Icon(
                                  ac
                                      ? Icons.toggle_on_outlined
                                      : Icons.toggle_off_outlined,
                                  color: widget.dark_theme
                                      ? ac
                                          ? Colors.yellow
                                          : Colors.white
                                      : ac
                                          ? Color.fromARGB(125, 49, 135, 206)
                                          : Colors.black,
                                  size: 30,
                                ))),
                      ],
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    color: widget.dark_theme
                        ? Color.fromARGB(170, 135, 134, 134).withOpacity(0.9)
                        : Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(90),
                    )),
              ),
            )),
        Positioned(
            bottom: 30,
            left: 15,
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
                                  },
                                  icon: Icon(
                                    Icons.lightbulb_rounded,
                                    size: led ? 30 : 20,
                                    color: widget.dark_theme
                                        ? led
                                            ? Colors.yellow
                                            : Colors.white
                                        : led
                                            ? Colors.blue
                                            : Colors.black,
                                  )),
                              SizedBox(width: 20),
                              IconButton(
                                  onPressed: () {
                                    !led
                                        ? flutterTts.speak('on')
                                        : flutterTts.speak('off');
                                    setState(() {
                                      _led();
                                      //_loadLEDStatus();
                                    });
                                  },
                                  icon: Icon(
                                    led
                                        ? Icons.toggle_on_outlined
                                        : Icons.toggle_off_outlined,
                                    color: widget.dark_theme
                                        ? led
                                            ? Colors.yellow
                                            : Colors.white
                                        : led
                                            ? Colors.blue
                                            : Colors.black,
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
                                  color: widget.dark_theme
                                      ? Colors.white
                                      : Colors.black,
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
                                widget.dark_theme ? Colors.black : Colors.white,
                                widget.dark_theme ? Colors.black : Colors.white,
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
                                    fan
                                        ? Icons.mode_fan_off_sharp
                                        : Icons.mode_fan_off_outlined,
                                    size: fan ? 30 : 25,
                                    color: widget.dark_theme
                                        ? fan
                                            ? Colors.yellow
                                            : Colors.white
                                        : fan
                                            ? Colors.blue
                                            : Colors.black,
                                  )),
                              SizedBox(width: 50),
                              IconButton(
                                  onPressed: () {
                                    _fan();
                                    fan
                                        ? flutterTts.speak('on')
                                        : flutterTts.speak('off');
                                  },
                                  icon: Icon(
                                    fan
                                        ? Icons.toggle_on_outlined
                                        : Icons.toggle_off_outlined,
                                    color: widget.dark_theme
                                        ? fan
                                            ? Colors.yellow
                                            : Colors.white
                                        : fan
                                            ? Colors.blue
                                            : Colors.black,
                                    size: 30,
                                  )),
                            ],
                          ),
                          Knob(
                            controller: _controller,
                            height: 50,
                            width: 80,
                            style: KnobStyle(
                              labelStyle: TextStyle(fontSize: 10),
                              tickOffset: -5,
                              labelOffset: -15,
                              minorTicksPerInterval: 6,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 20,
                            ),
                            child: Text(
                              "Fans",
                              style: TextStyle(
                                color: widget.dark_theme
                                    ? Colors.white
                                    : Colors.black,
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
                                widget.dark_theme ? Colors.black : Colors.white,
                                widget.dark_theme ? Colors.black : Colors.white,
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
                                        color: widget.dark_theme
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                                  SizedBox(width: 20),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Speechtotext()));
                                      },
                                      icon: Icon(
                                        Icons.toggle_off_outlined,
                                        size: 25,
                                        color: widget.dark_theme
                                            ? Colors.white
                                            : Colors.black,
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
                                color: widget.dark_theme
                                    ? Colors.white
                                    : Colors.black,
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
                                widget.dark_theme ? Colors.black : Colors.white,
                                widget.dark_theme ? Colors.black : Colors.white,
                              ])),
                    ),
                    SizedBox(width: 30),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(
                                top: 10,
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
                                        color: widget.dark_theme
                                            ? Colors.white
                                            : Colors.black,
                                      )),
                                  SizedBox(width: 15),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.toggle_off_outlined,
                                        size: 25,
                                        color: widget.dark_theme
                                            ? Colors.white
                                            : Colors.black,
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
                                  color: widget.dark_theme
                                      ? Colors.white
                                      : Colors.black,
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
                                widget.dark_theme ? Colors.black : Colors.white,
                                widget.dark_theme ? Colors.black : Colors.white,
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
