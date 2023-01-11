import 'package:flutter/material.dart';
import 'package:platform_flutter/channel/channels.dart';
import 'package:platform_flutter/platform_views/platform_views.dart';

class MyHomepage extends StatelessWidget {
  const MyHomepage({Key? key}) : super(key: key);

  Widget builButton(BuildContext context, {required String title, required Widget description}) =>  SizedBox(
    width: 250,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 6.0),
          backgroundColor: Colors.teal,
          textStyle: const TextStyle(fontSize: 24)
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => description));
      }, child: Text(title),
    ),

  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Demo Platform"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            buildPadding(),
            builButton(context, title: "Battery", description: const MyBattery()),
            buildPadding(),
            builButton(context, title: "Device Info", description: const MyDeviceInfo()),
            buildPadding(),
            builButton(context, title: "Android Version", description: const MyVersionDevice()),
            buildPadding(),
            builButton(context, title: "Calculate", description: const MyCalculate()),
            buildPadding(),
            builButton(context, title: "Text Views", description: const NativeView()),
            buildPadding(),
            builButton(context, title: "Show Toast", description: const MyShowToast()),
            buildPadding(),
            builButton(context, title: "Login Page", description: const LoginPage()),
            buildPadding()
          ],
        ),
      ),
    );
  }

  Padding buildPadding() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
    );
  }
}
