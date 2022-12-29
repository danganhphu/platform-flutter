import 'package:flutter/material.dart';

import 'package:platform_flutter/my_routes/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Method Channel Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomepage(),
    );
  }
}

//
// class MyMethodChannel  extends StatefulWidget {
//   const MyMethodChannel({Key? key}) : super(key: key);
//
//   @override
//   State<MyMethodChannel> createState() => _MyMethodChannelState();
// }
//
// class _MyMethodChannelState extends State<MyMethodChannel> {
//
//   static const platformBattery = MethodChannel('com.example/battery');
//   static const platformDeviceInfo = MethodChannel('com.example/deviceinfo');
//   // lay thong tin pin
//   String _batteryLevel = 'Unknown battery level.';
//   //Lay thong tin thiet bi
//   String _deviceInfo = 'Unknown device info .';
//
//
//   Future<void> _getBatteryLevel() async {
//     String batteryLevel;
//     try {
//       final int result = await platformBattery.invokeMethod('getBatteryLevel');
//       batteryLevel = 'Battery level at $result % .';
//     } on PlatformException catch (e) {
//       batteryLevel = "Failed to get battery level: '${e.message}'.";
//     }
//
//     setState(() {
//       _batteryLevel = batteryLevel;
//     });
//   }
//
//   Future<void> _getDeviceInfo() async {
//     String deviceInfo;
//     try {
//       final String result = await platformDeviceInfo.invokeMethod('getDeviceInfo');
//       deviceInfo = "Device information is: $result";
//     } on PlatformException catch (error) {
//       deviceInfo = "Failed to get device information: ${error.message}...";
//     }
//
//     setState(() {
//       _deviceInfo = deviceInfo;
//     });
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Deme Methodchannel'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(_batteryLevel),
//             ElevatedButton(
//               onPressed: _getBatteryLevel,
//               child: const Text('Get Battery Level'),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 20),
//             ),
//             Text(_deviceInfo),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: Colors.white, backgroundColor: Colors.red, // foreground
//               ),
//               onPressed: _getDeviceInfo,
//               child: const Text('Get device info'),
//             )
//           ],
//         ),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
