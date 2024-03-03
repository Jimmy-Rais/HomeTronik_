import 'package:flutter/material.dart';
import 'package:esp/Pages/rooms.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//Custome styled buttons that recieved button name and OnPress Function as argument
class buttonStyle extends StatelessWidget {
  buttonStyle(this.img, this.darktheme, this.OnTap, {super.key});
  var img;
  final bool darktheme;
  final void Function() OnTap;
  @override
  Widget build(context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                rooms(darktheme, img),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = 0.0;
              var end = 1.0;
              var curve = Curves.ease;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return ScaleTransition(
                scale: animation.drive(tween),
                child: child,
              );
            },
          ),
        );

        /*Navigator.push(context,
            MaterialPageRoute(builder: (context) => rooms(darktheme, img)));*/
      },
      child: Container(
          height: 250,
          width: 150,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: darktheme ? Colors.white : Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: darktheme ? Colors.black : Colors.white,
                  // Color of the shadow
                  spreadRadius: 1, // Spread radius of the shadow
                  blurRadius: 3, // Blur radius of the shadow
                  offset: Offset(
                      1, 1), // Offset of the shadow (horizontal, vertical)
                ),
                BoxShadow(
                  color: darktheme ? Colors.black : Colors.white,
                  // Color of the shadow
                  spreadRadius: 1, // Spread radius of the shadow
                  blurRadius: 8, // Blur radius of the shadow
                  offset: Offset(
                      -1, -1), // Offset of the shadow (horizontal, vertical)
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
                  image: AssetImage(img),
                  fit: BoxFit.cover,
                )),
          )),
    );
  }
}

class buttonStyle2 extends StatelessWidget {
  buttonStyle2(this.icn, this.darktheme, this.title, this.OnTap, {super.key});
  var icn;
  final String title;
  final bool darktheme;
  final void Function() OnTap;
  @override
  Widget build(context) {
    return Container(
      child: Column(
        children: [
          Padding(
              padding: EdgeInsets.only(
                top: 0,
                left: 3,
              ),
              child: IconButton(
                  onPressed: OnTap,
                  icon: Icon(
                    icn,
                    size: 20,
                    color: darktheme ? Colors.white : Colors.black,
                  ))),
          Padding(
            padding: EdgeInsets.only(top: 0),
            child: Text(
              "$title",
              style: TextStyle(
                color: darktheme ? Colors.white : Colors.black,
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
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: darktheme
                  ? Color.fromARGB(255, 18, 158, 60)
                  : Color.fromARGB(57, 0, 0, 0),
              // Color of the shadow
              spreadRadius: 1, // Spread radius of the shadow
              blurRadius: 1, // Blur radius of the shadow
              offset:
                  Offset(-2, -2), // Offset of the shadow (horizontal, vertical)
            ),
            BoxShadow(
              color: Color.fromARGB(70, 141, 139, 139),
              // Color of the shadow
              spreadRadius: 1, // Spread radius of the shadow
              blurRadius: 2, // Blur radius of the shadow
              offset:
                  Offset(1, 1), // Offset of the shadow (horizontal, vertical)
            ),
          ],
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                darktheme ? Colors.black : Colors.white,
                darktheme ? Colors.black : Colors.white,
              ])),
      height: 75,
      width: 65,
    );
  }
}

class buttonStyle3 extends StatefulWidget {
  buttonStyle3(this.isroom, this.name, this.darktheme, this.img, this._roomname,
      {super.key});
  final bool darktheme;
  final bool isroom;
  final String name;
  final void Function() _roomname;
  var img;
  @override
  State<buttonStyle3> createState() => _buttonStyle3State();
}

class _buttonStyle3State extends State<buttonStyle3> {
  @override
  Widget build(BuildContext context) {
    String Name = widget.name;
    return InkWell(
      onTap: () {
        setState(() {
          widget.img = living;
          widget._roomname();
        });
      },
      child: Container(
        height: 30,
        width: 90,
        decoration: widget.isroom
            ? BoxDecoration(
                color: Colors.blueGrey[300],
                boxShadow: [
                  BoxShadow(
                    color: widget.darktheme ? Colors.white : Colors.grey,
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
                      widget.darktheme ? Colors.black : Colors.white,
                      widget.darktheme ? Colors.black : Colors.white,
                    ]))
            : BoxDecoration(
                color: Colors.grey.withOpacity(0.9),
              ),
        child: Center(
          child: Text(
            "$Name",
            style: TextStyle(
              color: widget.darktheme ? Colors.white : Colors.black,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
