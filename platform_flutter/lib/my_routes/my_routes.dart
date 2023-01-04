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
        title: const Text("Demo MethodChannel"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            buildPadding(),
            builButton(context, title: "Battery", description: const MyBattery()),
            buildPadding(),
            builButton(context, title: "Device Info", description: const MyDeviceInfo()),
            buildPadding(),
            builButton(context, title: "Android Version", description: const MyVersionDevice()),
            buildPadding(),
            builButton(context, title: "Platfrom Views", description: const NativeView()),
            buildPadding(),
            builButton(context, title: "Show Toast", description: const MyShowToast()),
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
