import 'package:cowis/debug_files/debug_firestore_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
      child: Center(
        child: MaterialButton(
          color: Colors.red,
          onPressed: () {
            DebugFirestoreService.instance.cloneService();
          },
        ),
      ),
    ));
  }
}
