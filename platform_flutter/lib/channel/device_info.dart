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
  static const platformDeviceInfo2 = MethodChannel('com.example/deviceinfo', JSONMethodCodec());
  String _deviceInfo = 'device info.';


  Future<void> _jSONMethodCodec() async {
    String deviceInfo;
    try {
      var result = await platformDeviceInfo2.invokeMethod('getDeviceInfo', {
        "type": "MODEL",
      });

      if (result != null) {
        deviceInfo = 'Device Info là ${result['result']}.';
      } else {
        deviceInfo = 'Không thể lấy device info';
      }
    } on PlatformException catch (e) {
      deviceInfo = "Lấy device info: '${e.message}'.";
    }

    setState(() {
      _deviceInfo = deviceInfo;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Device Information"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_deviceInfo),
            ElevatedButton(
              onPressed: _jSONMethodCodec,
              child: const Text('Get device info'),
            ),
          ],
        ),
      ),
    );
  }
}
