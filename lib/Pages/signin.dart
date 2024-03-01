import 'dart:ui';
import 'package:esp/main.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: signin(),
    );
  }
}

class signin extends StatefulWidget {
  const signin({Key? key}) : super(key: key);

  @override
  State<signin> createState() => _signinState();
}

class _signinState extends State<signin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Stack(children: <Widget>[
      Container(
        height: 850,
        width: 2000,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/home2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //child: Image(image: AssetImage("images/avatar/home.jpeg")),
      ),
      /*   Container(
                alignment: Alignment(0.1, -1.9),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ) */
      SizedBox(height: 85),
      Positioned(
          right: 50,
          bottom: 110,
          child: Column(children: [
            /* Container(
              alignment: Alignment(0.2, 0.4),
              padding: EdgeInsets.only(left: 10),
              child: Text(
                "Sign in to continue",
                style: TextStyle(
                  color: Color.fromRGBO(235, 251, 251, 0.75),
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(height: 55),
            Container(
                width: 380,
                child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        filled: true, //<-- SEE HERE
                        fillColor: Color.fromARGB(255, 242, 241, 245),
                        hintText: 'Email or phone number',
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(18))))),
            SizedBox(height: 45),*/
            /*Container(
              width: 380,
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  filled: true, //<-- SEE HERE
                  fillColor: Color.fromARGB(255, 242, 241, 245),
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 0.0),
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
            ),
            SizedBox(height: 30),*/
            /* Container(
              padding: EdgeInsets.only(right: 210),
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Color.fromARGB(255, 226, 241, 241),
                      fontSize: 20,
                    ),
                  )),
            ),
            SizedBox(height: 75),*/
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage2()));
              },
              child: Container(
                padding: EdgeInsets.only(left: 30),
                width: 250,
                height: 70,
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
                          Colors.black,
                          Colors.black,
                        ])),
                child: Center(
                  child: Text(
                    "",
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ), /*ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage2()));
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18), // <-- Radius
                        ),
                      ),
                      child: Text(
                        'Let me in',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          // fontWeight: FontWeight.bold,
                        ),
                      ))*/
              ),
            ),
            /* SizedBox(height: 80),
            Row(children: [
              Container(
                padding: EdgeInsets.only(left: 66),
                child: Text(
                  'Already have an account?',
                  style: TextStyle(
                    color: Color.fromARGB(184, 22, 185, 207),
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage2()));
                  },
                  child: Text(
                    "Sign in",
                    style: TextStyle(
                      color: Color.fromARGB(255, 191, 67, 30),
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ))
            ])*/
          ]))
    ])));
  }
}
