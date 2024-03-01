import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
/*import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';*/

class Speechtotext extends StatefulWidget {
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
}
