import 'package:flutter/material.dart';

class BlackScreenPage extends StatelessWidget {
  const BlackScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BlackScreen',
        ),
      ),
      body: Container(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.black,
        ),
      ),
    );
  }
}
