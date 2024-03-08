import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';
import 'package:esp/Pages/rooms.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

const talk = "images/tk.gif";
const sleep = "images/sleep.gif";
const listen = "images/listen.gif";
const talk_d = "images/talk_d.gif";
const sleep_d = "images/sleep_d.gif";
const listen_d = "images/listen_d.gif";

class voiceassist2 extends StatefulWidget {
  voiceassist2(this.theme, this.img, {super.key});
  final theme;

  var img;
  @override
  State<voiceassist2> createState() => voiceassist2State();
}

class voiceassist2State extends State<voiceassist2> {
  //Flutter text to speech object creation
  final FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText? _speech;
  String _text = "";
  bool _isListening = false;

  var img = sleep_d;
  @override
  void initState() {
    _listen3();
    super.initState();
    _speech = stt.SpeechToText();

    //Retrieve the actual room state
  }

  _listen3() async {
    print("hoh");
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() {
          img = widget.theme ? listen_d : listen;
        });

        setState(() {
          _isListening = true;
        });
        _speech!.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;

            // appliances controlled by voice commands
            if (_text == "Jimmy") {
              setState(() {
                img = widget.theme ? talk_d : talk;
              });

              flutterTts.speak(
                  'Yes....Welcome to HomeTronik,a new SmartHome experience.How can I assist you');
              flutterTts.setCompletionHandler(() {
                setState(() {
                  img = widget.theme ? sleep_d : sleep;
                });
              });
              /*setState(() {
                img = widget.theme ? sleep_d : sleep;
              });*/
            } else if (_text == "room") {
              setState(() {});
              flutterTts.speak("Alright....there you are");

              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => rooms(widget.theme, living)),
              );
            }
            /*setState(() {
              img = widget.theme ? sleep_d : sleep;
            });*/

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

  @override
  Widget build(BuildContext context) {
    var th = widget.theme;
    print("haha $th");
    return InkWell(
      onTap: () {
        _listen3();
      },
      child: CircleAvatar(
        backgroundColor: widget.theme ? Colors.black : Colors.white,
        radius: 50,
        backgroundImage: AssetImage(img),
      ),
    );
  }
}
