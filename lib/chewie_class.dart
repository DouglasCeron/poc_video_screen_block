import 'dart:io';
import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ChewieClass extends StatefulWidget {
  final VideoPlayerController? videoPlayerController;
  final bool? loop;
  static int buildCount = 0;
  static int initStateCount = 0;

  ChewieClass({
    @required this.videoPlayerController,
    this.loop,
  });

  @override
  _ChewieClassState createState() => _ChewieClassState();
}

class _ChewieClassState extends State<ChewieClass> {
  ChewieController? _chewieController;

  VideoPlayerController? videoPlayerController1;
  ChewieController? _chewieController1;
  String? url = "https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4";
  Uint8List? imageBytes;
  bool isPlaying = false;

  Widget? image = Image.asset(
    'assets/hubla_img.jpeg',
    height: double.infinity,
    width: double.infinity,
    fit: BoxFit.fill,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: false,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: 350.0,
        padding: const EdgeInsets.all(12.0),
        color: Colors.lightBlue[50],
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: _chewieController1 != null && _chewieController1!.videoPlayerController.value.isInitialized && _chewieController1!.isPlaying
                    ? Chewie(
                        controller: _chewieController1!,
                      )
                    : Stack(
                        children: [
                          image != null
                              ? Container(
                                  height: 350,
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.asset(
                                    'assets/hubla_img.jpeg',
                                    height: 350,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),
                          _chewieController1 != null
                              ? Align(
                                  alignment: Alignment.center,
                                  child: ClipOval(
                                    child: Material(
                                      color: Colors.white, // Button color
                                      child: InkWell(
                                        splashColor: Colors.white, // Splash color
                                        onTap: () {
                                          _chewieController1!.play();
                                          setState(() {});
                                        },
                                        child: SizedBox(width: 56, height: 56, child: Icon(Icons.play_arrow)),
                                      ),
                                    ),
                                  ),
                                )
                              : Align(alignment: Alignment.center, child: CircularProgressIndicator())
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
    initializePlayer();
  }

  @override
  void dispose() {
    videoPlayerController1!.dispose();
    _chewieController1!.dispose();
    super.dispose();
  }

  _generateThumbnail() async {
    String? fileName = await VideoThumbnail.thumbnailFile(
      video: url!,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight: 350, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    final file = File(fileName!);
    imageBytes = file.readAsBytesSync();
    print('----image--->>>$fileName');
    setState(() {});
  }

  Future<void> initializePlayer() async {
    if (mounted) {
      videoPlayerController1 = VideoPlayerController.network(url!);
      await videoPlayerController1!.initialize();
      _createChewieController();
      setState(() {});
    }
  }

  _createChewieController() {
    _chewieController1 = ChewieController(
      deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft],
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      videoPlayerController: videoPlayerController1!,
      aspectRatio: videoPlayerController1!.value.aspectRatio,
      autoPlay: false,
      looping: false,
      allowFullScreen: true,
      allowedScreenSleep: false,
      autoInitialize: true,
    );
  }
}
