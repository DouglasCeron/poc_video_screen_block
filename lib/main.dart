import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poc_video_player/cast.dart';
import 'package:poc_video_player/chewie_demo.dart';
import 'package:poc_video_player/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  ChewieListItem chewieListItem = ChewieListItem();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Video Player'),
        ),
        body: ChewieDemo());
  }
}
