import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyVersionDevice extends StatefulWidget {
  const MyVersionDevice({Key? key}) : super(key: key);
  final String title = 'Android Version';
  @override
  State<MyVersionDevice> createState() => _MyVersionDeviceState();
}

class _MyVersionDeviceState extends State<MyVersionDevice> {
  static const channelAndroidVersion = MethodChannel('com.example/android_version');

  String _androidVersion = 'Unknown Android Version.';

  Future<void> _getAndroidVersion() async {
    String androidVersion;
    try {
      final String result = await channelAndroidVersion.invokeMethod('getAndroidVersion');
      androidVersion = 'Android Version: $result';
    } on PlatformException catch (e) {
      androidVersion = "Failed to get android version: '${e.message}'.";
    }

    setState(() {
      _androidVersion = androidVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Android Version Home Page"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_androidVersion),
            ElevatedButton(
              onPressed: _getAndroidVersion,
              child: const Text('Get Android Version'),
            ),
          ],
        ),
      ),
    );
  }
}
