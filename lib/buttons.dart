import 'package:flutter/material.dart';

//Custome styled buttons that recieved button name and OnPress Function as argument
class buttonStyle extends StatelessWidget {
  buttonStyle(this.name, this.OnTap, {super.key});
  final String name;
  final void Function() OnTap;
  @override
  Widget build(context) {
    return Container();
  }
}
