import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signin.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp2());
}

//JR G
class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: signin(),
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
  String currentStatus = 'Loading...';

  @override
  void initState() {
    super.initState();
    _loadLEDStatus();
  }

  _loadLEDStatus() async {
    DatabaseEvent event = await ledStatusRef.once();
    if (event.snapshot.value != null) {
      setState(() {
        currentStatus = event.snapshot.value.toString();
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
      backgroundColor: Colors.grey[300],
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
        ),
        Positioned(
            top: 50,
            right: 20,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.menu_outlined,
                  size: 55,
                  color: const Color.fromARGB(183, 255, 255, 255),
                ))),
        Positioned(
          top: 50,
          left: 20,
          child: Column(
            children: [
              Container(
                height: 75,
                width: 75,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  //borderRadius: BorderRadius.only(topLeft: Radius.circular(0)),
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                    child: ClipOval(
                  child: SizedBox(
                      width: 80,
                      height: 80,
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
            left: 23,
            top: 127,
            child: Column(
              children: [
                Text(
                  "Hi Jimmy!",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
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
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ])),
        Positioned(
            top: 175,
            left: 20,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    color: Color.fromARGB(160, 25, 83, 102),
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(width: 30),
                  Container(
                    color: Color.fromARGB(160, 25, 83, 102),
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(width: 30),
                  Container(
                    color: Color.fromARGB(160, 25, 83, 102),
                    height: 60,
                    width: 60,
                  ),
                  SizedBox(width: 30),
                  Neumorphic(
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
                  ),
                ],
              ),
            ))
      ]),
    );
  }
}
