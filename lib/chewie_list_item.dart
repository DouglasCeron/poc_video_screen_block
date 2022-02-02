import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class ChewieListItem extends StatefulWidget {
  final VideoPlayerController? videoPlayerController;
  String url = 'https://stream.mux.com/Zub00MY8X01YIMm9UEf4Oe8R6Wd4wGsZu2fU7B7qx3iD4.m3u8';

  final bool? loop;

  ChewieListItem({
    @required this.videoPlayerController,
    this.loop,
  });

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  ChewieController? _chewieController;
  late VideoPlayerController _videoPlayerController1;

  bool isPlaying = false;
  Widget? image = Image.asset(
    'assets/hubla_img.jpeg',
    height: double.infinity,
    width: double.infinity,
    fit: BoxFit.fill,
  );

  @override
  void initState() {
    super.initState();
    videoListener();
    initializePlayer();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var prop = height / width;

    return Column(
      children: [
        Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 8 * prop),
          height: height * 0.3,
          child: Chewie(
            controller: chewieController(),
          ),
        ),
      ],
    );
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network(widget.url);

    await Future.wait([
      _videoPlayerController1.initialize(),
    ]);
    int currPlayIndex = 0;

    Future<void> toggleVideo() async {
      await _videoPlayerController1.pause();
      currPlayIndex = currPlayIndex == 0 ? 1 : 0;
      await initializePlayer();
    }
  }

  ChewieController chewieController() {
    return _chewieController = ChewieController(
      showControls: true,
      aspectRatio: 1 / 1,
      autoInitialize: true,
      looping: widget.loop!,
      overlay: getOverlay(),
      showControlsOnInitialize: false,
      videoPlayerController: widget.videoPlayerController!,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft],
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  void videoListener() {
    widget.videoPlayerController!.addListener(checkVideo);
  }

  void checkVideo() {
    // Implement your calls inside these conditions' bodies :

    int? secondsPosition = widget.videoPlayerController?.value.position.inSeconds;
    int? secondsDuration = widget.videoPlayerController!.value.duration.inSeconds;
    int? minutesPosition = widget.videoPlayerController!.value.position.inMinutes;
    Duration? actualPosition = widget.videoPlayerController?.value.position;
    Duration? videoDuration = widget.videoPlayerController?.value.duration;

    if (actualPosition == const Duration(seconds: 0, minutes: 0, hours: 0)) {
      print('video Started');
    }
    if (widget.videoPlayerController!.value.isPlaying) {
      setState(() {
        print('playing setState');

        isPlaying = true;
      });
    }
    if (secondsPosition! <= secondsDuration) {
      print('minutes:$minutesPosition, seconds:$secondsPosition');
    }
    if (actualPosition == videoDuration) {
      print('video Ended');
    }
  }

  Widget? getOverlay() {
    if (isPlaying) {
      print('playing');
      return Container();
    } else {
      return image;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController?.dispose();
    widget.videoPlayerController?.dispose();
    widget.videoPlayerController!.removeListener(checkVideo);
  }
}
