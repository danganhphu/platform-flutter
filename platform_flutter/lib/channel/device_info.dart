import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';

class MyDeviceInfo extends StatefulWidget {
  const MyDeviceInfo({Key? key}) : super(key: key);
  final String title = 'Device Information';

  @override
  State<MyDeviceInfo> createState() => _MyDeviceInfoState();
}

class _MyDeviceInfoState extends State<MyDeviceInfo> {
  static const platformDeviceInfo = MethodChannel('com.example/deviceinfo');
  static const platformDeviceInfo2 = MethodChannel('com.example/deviceinfo2', JSONMethodCodec());

  String _deviceInfo = 'Unknown device info .';
  String _deviceInfo2 = 'device info 2.';

  Future<void> _getDeviceInfo() async {
    String deviceInfo;
    try {
      final String result = await platformDeviceInfo.invokeMethod('getDeviceInfo');
      deviceInfo = "Device information is: $result";
    } on PlatformException catch (error) {
      deviceInfo = "Failed to get device information: ${error.message}...";
    }

    setState(() {
      _deviceInfo = deviceInfo;
    });
  }

  Future<void> _jSONMethodCodec(String model) async {
    String deviceInfo2;
    try {
      var result = await platformDeviceInfo2.invokeMethod('getDeviceInfo2', {
        "type": "MODEL",
      });

      if (result != null) {
        deviceInfo2 = 'Device Info là ${result['result']}.';
      } else {
        deviceInfo2 = 'Không thể lấy device info';
      }
    } on PlatformException catch (e) {
      deviceInfo2 = "Lấy device info: '${e.message}'.";
    }

    setState(() {
      _deviceInfo2 = deviceInfo2;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Information Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_deviceInfo),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.red, // foreground
              ),
              onPressed: _getDeviceInfo,
              child: const Text('Get device info'),
            ),

            const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
            Text(_deviceInfo2),
            ElevatedButton(
              onPressed: () {
                _jSONMethodCodec("model");
              },
              child: const Text('Get device info 2'),
            ),
          ],
        ),
      ),
    );
  }
}
