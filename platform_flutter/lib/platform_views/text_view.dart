import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeView extends StatefulWidget {
  const NativeView({Key? key}) : super(key: key);

  @override
  State<NativeView> createState() => _NativeViewState();
}

class _NativeViewState extends State<NativeView> {
  static const String viewType = '<platform-textview-type>';
  // Pass parameters to the platform side.
  final Map<String, dynamic> creationParams = <String, dynamic>{};
  @override
  Widget build(BuildContext context) {
    // This is used in the platform side to register the view.

    return Scaffold(
      appBar: AppBar(
        title: const Text("Platform Text Views"),
        centerTitle: true,
      ),
      body: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: SizedBox(
          height: 200,
          child: buildWidgets()
        ),
      ),
    );
  }

  Widget buildWidgets() {
    if (!(defaultTargetPlatform == TargetPlatform.android)) {
      return const Text('iOS not implemented yet.');
    }
    return AndroidView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      creationParamsCodec: const StandardMessageCodec(),
    );
  }
}
