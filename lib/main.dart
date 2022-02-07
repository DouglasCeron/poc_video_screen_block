import 'package:flutter/material.dart';
import 'package:poc_video_player/cast.dart';
import 'package:poc_video_player/chewie_class.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Column(
        children: [
          Cast(),
          Container(
            width: double.infinity,
            height: 290,
            child: ChewieClass(),
          ),
        ],
      ),
    );
  }
}
