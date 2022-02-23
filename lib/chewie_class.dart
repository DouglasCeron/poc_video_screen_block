import 'dart:io';
import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ChewieClass extends StatefulWidget {
  ChewieController? chewieController;
  VideoPlayerController? videoPlayerController;
  final String? url;

  ChewieClass({
    required this.chewieController,
    required this.videoPlayerController,
    required this.url,
  });
  @override
  ChewieClassState createState() => ChewieClassState();
}

class ChewieClassState extends State<ChewieClass> {
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
                child:
                    widget.chewieController != null && widget.chewieController!.videoPlayerController.value.isInitialized && widget.chewieController!.isPlaying
                        ? Chewie(
                            controller: widget.chewieController!,
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
                              widget.chewieController != null
                                  ? Align(
                                      alignment: Alignment.center,
                                      child: ClipOval(
                                        child: Material(
                                          color: Colors.white, // Button color
                                          child: InkWell(
                                            splashColor: Colors.white, // Splash color
                                            onTap: () {
                                              widget.chewieController!.play();
                                              setState(() {});
                                            },
                                            child: SizedBox(
                                              width: 56,
                                              height: 56,
                                              child: Icon(Icons.play_arrow),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Align(
                                      alignment: Alignment.center,
                                      child: CircularProgressIndicator(),
                                    )
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
    widget.chewieController = widget.chewieController;
    _generateThumbnail();
  }

  @override
  void dispose() {
    widget.videoPlayerController!.dispose();
    widget.chewieController!.dispose();
    super.dispose();
  }

  _generateThumbnail() async {
    String? fileName = await VideoThumbnail.thumbnailFile(
      video: widget.url!,
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
}
