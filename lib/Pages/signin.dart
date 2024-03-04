import 'dart:ui';
import 'package:esp/main.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/foundation.dart';

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
      body: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'HomeTronic',

              body: 'A Modern smart Home with Voice assistant integration',
              image: buildImage("images/ht.jpg"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            /*PageViewModel(
              title: 'HomeTronic',
              body:
                  'Seameless control of house appliances via smartphone and voice assistant',
              image: buildImage("images/home.jpeg"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),*/
            PageViewModel(
              title: 'AI powered smart meter',
              body:
                  'Energy consumption optimization solutions with a modern smart meter',
              image: buildImage("images/sm.png"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: 'Enhanced Security',
              body: 'Instant access to CCTV Cameras and sensors',
              image: buildImage("images/sec.jpg"),
              //getPageDecoration, a method to customise the page style
              decoration: getPageDecoration(),
            ),
          ],
          onDone: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyHomePage2()));
            if (kDebugMode) {
              print("Done clicked");
            }
          },
          //ClampingScrollPhysics prevent the scroll offset from exceeding the bounds of the content.
          scrollPhysics: const ClampingScrollPhysics(),
          showDoneButton: true,
          showNextButton: true,
          showSkipButton: true,
          //isBottomSafeArea: true,
          skip:
              const Text("Skip", style: TextStyle(fontWeight: FontWeight.w600)),
          next: const Icon(Icons.forward),
          done:
              const Text("Done", style: TextStyle(fontWeight: FontWeight.w600)),
          dotsDecorator: getDotsDecorator()),
    );
  }

  //widget to add the image on screen
  Widget buildImage(String imagePath) {
    return Container(
        color: Colors.white,
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 80,
          child: Image.asset(
            imagePath,
            width: 650,
            height: 900,
          ),
        ));
  }

  //method to customise the page style
  PageDecoration getPageDecoration() {
    return const PageDecoration(
      imagePadding: EdgeInsets.only(top: 120),
      pageColor: Colors.white,
      bodyPadding: EdgeInsets.only(top: 30, left: 20, right: 20),
      titlePadding: EdgeInsets.only(top: 30),
      bodyTextStyle: TextStyle(color: Colors.black54, fontSize: 15),
    );
  }

  //method to customize the dots style
  DotsDecorator getDotsDecorator() {
    return const DotsDecorator(
      spacing: EdgeInsets.symmetric(horizontal: 2),
      activeColor: Colors.indigo,
      color: Colors.grey,
      activeSize: Size(12, 5),
      activeShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );

    /*SingleChildScrollView(
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
    ])));*/
  }
}
