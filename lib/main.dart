import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:ios_insecure_screen_detector/ios_insecure_screen_detector.dart';
import 'package:poc_video_player/chewie_class.dart';
import 'package:video_player/video_player.dart';

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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  ChewieController? chewieController;
  String? url = "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4";
  late final videoPlayerController = VideoPlayerController.network(url!);
  bool isSecureMode = false;

  bool isRecoring = false;

  final screenDetector = IosInsecureScreenDetector();
  final screenAndroid = FlutterWindowManager();
  @override
  void initState() {
    super.initState();

    chewieController = ChewieController(
      deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft],
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      allowedScreenSleep: false,
      autoInitialize: true,
    );

    if (Platform.isAndroid) {
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    } else {
      screenDetector.initialize();
      screenDetector.addListener(
        () {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return Text(
                'Tentativa de print',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              );
            },
          );
          setState(() {});
        },
        (isCaptured) {
          setState(
            () {
              isRecoring = isCaptured;
            },
          );
        },
      );
      isCaptured();
    }

    /// Check if current screen is captured.
  }

  isCaptured() async {
    isRecoring = await screenDetector.isCaptured();
    setState(() {});
  }

  showDialogScreen() {
    showDialog(
      barrierColor: Colors.black.withOpacity(0.8),
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Container();
      },
    );
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
            child: ChewieClass(
              chewieController: chewieController,
              videoPlayerController: videoPlayerController,
              url: url,
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              chewieController!.pause();
              showDialogScreen();
            },
            child: Text('Record'),
          ),
          Center(
            child: Text(
              'Recording: ${isRecoring ? 'YES' : 'NO '}',
            ),
          ),
        ],
      ),
    );
  }
}
