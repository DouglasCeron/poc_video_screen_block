import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:poc_video_player/cast.dart';
import 'package:poc_video_player/chewie_list_item.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  String url = 'https://stream.mux.com/Zub00MY8X01YIMm9UEf4Oe8R6Wd4wGsZu2fU7B7qx3iD4.m3u8';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Player'),
      ),
      body: Column(
        children: [
          const Cast(),
          ChewieListItem(
            videoPlayerController: VideoPlayerController.asset('assets/vd_teste_yt.mp4'),
            loop: true,
          ),
          ChewieListItem(
            videoPlayerController: VideoPlayerController.network(url),
            loop: true,
          ),
        ],
      ),
    );
  }
}
