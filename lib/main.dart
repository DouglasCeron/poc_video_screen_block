import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:ios_insecure_screen_detector/ios_insecure_screen_detector.dart';
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

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isSecureMode = false;

  bool _isCaptured = false;

  final screenDetector = IosInsecureScreenDetector();

  @override
  void initState() {
    super.initState();
    screenDetector.initialize();
    screenDetector.addListener(() {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return Center(
            child: Text(
              'screenshot taken',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      );
    }, (isCaptured) {
      setState(() {
        _isCaptured = isCaptured;
      });
    });

    /// Check if current screen is captured.
    isCaptured();
  }

  isCaptured() async {
    _isCaptured = await screenDetector.isCaptured();
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    screenDetector.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 290,
            child: ChewieClass(),
          ),
          SizedBox(height: 50),
          Center(
            child: Text('Captured: ${_isCaptured ? 'YES' : 'NO '}'),
          )
        ],
      ),
    );
  }
}
