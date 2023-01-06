import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyCalculate extends StatefulWidget {
  const MyCalculate({Key? key}) : super(key: key);
  final String title = 'Calculate';
  @override
  State<MyCalculate> createState() => _MyCalculateState();
}

class _MyCalculateState extends State<MyCalculate> {
  static const caculateChannel = MethodChannel('com.example/calculate_channel', JSONMethodCodec());

  String _resultMessage = 'Unknown result.';

  
  _getRootMessage(int num1, int num2, int num3) async {
    var listNumb = <String, dynamic>{
      "numberOne": num1,
      "numberTwo": num2,
      "numberThree": num3,
    };
    String resultMessage;
    try {
      var result = await caculateChannel.invokeMethod('getCaculate', listNumb);
      if (result != null) {
        resultMessage = result;
      } else {
        resultMessage = 'Không thể lấy nghiệm';
      }
    } on PlatformException catch (e) {
      resultMessage = "Lấy message failed: '${e.message}'.";
    }

    setState(() {
      _resultMessage = resultMessage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculate Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_resultMessage),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.pinkAccent,
                backgroundColor: Colors.white70, // foreground
              ),
              onPressed: () {
                _getRootMessage(1, -5, 6);
              },
              child: const Text('Giải pt!!'),
            ),
          ],
        ),
      ),
    );
  }

}
