/*
Widget that return the states of all the appliances from the database 
and receive toogle command from buttons,afer receiving every toogle command ,
the function will toggle the database state of the appliance, 

*/
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signin.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'rooms.dart';
import 'package:flutter_tts/flutter_tts.dart';

class appliances extends StatefulWidget {
  //Receive the boolean value(toggle_led) to toggle the appliance
  appliances(this.toogle_led, {super.key});
  bool toogle_led = false;
  @override
  State<appliances> createState() => _appliancesState();
}

class _appliancesState extends State<appliances> {
  /*
  Database references of appliances states
  */
  DatabaseReference ledStatusRef =
      FirebaseDatabase.instance.reference().child('LED_STATUS');
  DatabaseReference TempStatusRef =
      FirebaseDatabase.instance.reference().child('Temperature');
  DatabaseReference HumRef =
      FirebaseDatabase.instance.reference().child('Humidity');
  /*Initialization of appliances states variables*/
  String currentStatus = 'Loading...';
  double TempStatus = 0.0;
  int HumStatus = 0;
  bool my_led = false;

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
      //led_stat represents the boolean status of the led retrieved from the database
      bool? led_stat = bool.tryParse(event.snapshot.value.toString());
      setState(() {
        /*Everytime the function is called,assign the toogle  command recieved
         to the database state*/
        led_stat != led_stat!;
        currentStatus = event.snapshot.value.toString();
        print('The new state $led_stat');
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
    return const Placeholder();
  }
}
