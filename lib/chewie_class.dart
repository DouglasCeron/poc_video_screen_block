import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

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
    _chewieController = chewieController();
    videoListener();

    print('####### Contador InitState ${++ChewieClass.initStateCount} #########');
  }

  chewieController() {
    return ChewieController(
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
      print('Video is playing');
      return Container();
    } else {
      return image;
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController!.dispose();
    _chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var prop = height / width;

    print('####### Contador build ${++ChewieClass.buildCount} #########');
    return Column(
      children: [
        Container(
          color: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 8 * prop),
          height: height * 0.3,
          child: Chewie(
            controller: _chewieController!,
          ),
        ),
      ],
    );
  }
}
