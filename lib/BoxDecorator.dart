import 'package:flutter/material.dart';

class BoxDecorator extends StatelessWidget {
  BoxDecorator(this.theme, {super.key});
  bool theme;
  @override
  Widget build(BuildContext context) {
    return Container();
    /* return BoxDecoration(

                        //borderRadius: BorderRadius.circular(30),
                       // color: Colors.blueGrey[300],
                        //borderRadius: BorderRadius.only(
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
                                  : Colors.blueGrey.shade200,
                              dark_theme
                                  ? Colors.black
                                  : Colors.blueGrey.shade400,
                            ])),();
  }*/
  }
}
