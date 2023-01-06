import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyShowToast extends StatefulWidget {
  const MyShowToast({Key? key}) : super(key: key);
  final String title = 'Show Toast';
  @override
  State<MyShowToast> createState() => _MyShowToastState();
}

class _MyShowToastState extends State<MyShowToast> {
  static const toastChannel = MethodChannel('com.example/toast_channel', JSONMethodCodec());

  String _toastMessage = 'Unknown Message.';

  _getToastMessage() async {
    String toastMessage;
    try {
      var result = await toastChannel.invokeMethod('getToastMessage', {
        "type": "msg",
      });
      if (result != null) {
        toastMessage = 'Message: xin chào ${result['result']}.';
      } else {
        toastMessage = 'Không thể lấy message';
      }
    } on PlatformException catch (e) {
      toastMessage = "Lấy message failed: '${e.message}'.";
    }

    setState(() {
      _toastMessage = toastMessage;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show Toast Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child:  ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.pinkAccent,
            backgroundColor: Colors.white70, // foreground
          ),
          onPressed: _showToast,
          child: const Text('Show toast!!'),
        ),
      ),
    );
  }

  _showToast() async {
    await _getToastMessage();
    Fluttertoast.showToast(
        msg: _toastMessage,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
