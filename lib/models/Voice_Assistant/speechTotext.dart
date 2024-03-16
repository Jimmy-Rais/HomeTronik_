import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';
import 'package:esp/Pages/rooms.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';
/*import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';*/

/*class Speechtotext extends StatefulWidget {
  const Speechtotext({super.key});

  @override
  State<Speechtotext> createState() => _SpeechtotextState();
}

class _SpeechtotextState extends State<Speechtotext> {
  stt.SpeechToText? _speech;
  String _text = "Press the button and start speaking";
  bool _isListening = false;
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Speech To Text Demo"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listen,
        child: Icon(_isListening! ? Icons.mic : Icons.mic_none),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          child: /*Positioned(
            bottom: 10,
            child: Container(
              child: SfCartesianChart(
                title: ChartTitle(text: "Power Consumption"),
                series: [
                  LineSeries<bills, String>(
                    dataSource: chartData,
                    xValueMapper: (bills power, _) => power.time,
                    yValueMapper: (bills power, _) => power.power,
                  )
                ],
              ),
            ),
          ),*/
              Text('$_text'),
        ),
      ),
    );
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
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech!.stop();
    }
  }
}*/
const kitchen = "images/kitchen.jpg";
const guest = "images/guest.jpg";
const living = "images/living.jpg";
const hall = "images/hall.jpg";
const out = "images/out.jpg";
const fence = "images/fence.jpg";

class voiceassist extends StatefulWidget {
  voiceassist(this.theme, this.img, this._led, this._fan, this._ac,
      this._loadTempStatus, this._roomname,
      {super.key});
  var img;
  final theme;
  final Function() _roomname;
  final Function() _fan;
  final Function() _led;
  final Function() _ac;
  final Function() _loadTempStatus;
  @override
  State<voiceassist> createState() => voiceassistState();
}

class voiceassistState extends State<voiceassist> {
  //Flutter text to speech object creation
  final FlutterTts flutterTts = FlutterTts();
  stt.SpeechToText? _speech;
  String _text = "";
  bool _isListening = false;
  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    _listen2();
    widget._roomname;
    //Retrieve the actual room state
  }

  _listen2() async {
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
              widget._led();
            } else if (_text == "switch off light") {
              flutterTts.speak("Light switched off ");
              widget._led();
            } else if (_text == "switch on fan") {
              flutterTts.speak("Fan switched on ");
              widget._fan();
            } else if (_text == "switch off fan") {
              flutterTts.speak("Fan switched switched off ");
              widget._fan();
            } else if (_text == "switch on AC") {
              flutterTts.speak("AC switched on ");
              widget._ac();
            } else if (_text == "switch off AC") {
              flutterTts.speak("AC switched off ");
              widget._ac();
            } else if (_text == "temperature") {
              widget._loadTempStatus();
              flutterTts.speak("The room temperature is  Degrees Celsius");
            } else if (_text == "living room") {
              flutterTts.speak("Welcome to the Living room screen");
              setState(() {
                widget.img = living;
                widget._roomname();
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => rooms(widget.theme, living)));
            } else if (_text == "fence") {
              flutterTts.speak("Welcome to the fence screen");
              setState(() {
                widget.img = fence;
                widget._roomname();
              });
            } else if (_text == "balcony") {
              flutterTts.speak("Welcome to the balcony screen");
              setState(() {
                widget.img = out;
                widget._roomname();
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => rooms(widget.theme, out)));
            } else if (_text == "kitchen") {
              setState(() {
                widget.img = kitchen;
                widget._roomname();
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => rooms(widget.theme, kitchen)),
              );
              flutterTts.speak("Welcome to the kitchen screen");
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _listen2,
      child: CircleAvatar(
        backgroundColor: widget.theme ? Colors.black : Colors.white,
        radius: 70,
        backgroundImage: AssetImage("images/sleep_d.gif"),
      ),
    );
  }
}
