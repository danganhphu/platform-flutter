import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class MyBattery extends StatefulWidget {
  const MyBattery({Key? key}) : super(key: key);
  final String title = 'Battery Level';
  @override
  State<MyBattery> createState() => _MyBatteryState();
}

class _MyBatteryState extends State<MyBattery> {
  static const platformBattery = MethodChannel('com.example/battery');

  String _batteryLevel = 'Unknown battery level.';

  Future<void> _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platformBattery.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  // Future<void> _getBatteryLevel2() async {
  //   String batteryLevel2;
  //   try {
  //     final int result = await platformBattery2.invokeMethod('getBatteryLevel2');
  //     batteryLevel2 = 'Pin hiện tại là $result % .';
  //   } on PlatformException catch (e) {
  //     batteryLevel2 = "Lấy pin thất bại: '${e.message}'.";
  //   }
  //
  //   setState(() {
  //     _batteryLevel2 = batteryLevel2;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Battery Level Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_batteryLevel),
            ElevatedButton(
              onPressed: _getBatteryLevel,
              child: const Text('Get Battery Level'),
            ),
          ],
        ),
      ),
    );
  }
}
