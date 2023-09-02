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
            image: AssetImage("images/home.jpeg"),
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
          right: 10,
          top: 200,
          child: Column(children: [
            Container(
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
            SizedBox(height: 45),
            Container(
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
            SizedBox(height: 30),
            Container(
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
            SizedBox(height: 75),
            Container(
                padding: EdgeInsets.only(left: 30),
                width: 280,
                height: 50,
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 69, 172, 201),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18), // <-- Radius
                      ),
                    ),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        // fontWeight: FontWeight.bold,
                      ),
                    ))),
            SizedBox(height: 80),
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
            ])
          ]))
    ])));
  }
}
