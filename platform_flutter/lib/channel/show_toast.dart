import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyShowToast extends StatefulWidget {
  const MyShowToast({Key? key}) : super(key: key);
  final String title = 'Show Toast';
  @override
  State<MyShowToast> createState() => _MyShowToastState();
}

class _MyShowToastState extends State<MyShowToast> {
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

  Future<void> _showToast() async {
    Fluttertoast.showToast(
        msg: "method channel show toast",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
