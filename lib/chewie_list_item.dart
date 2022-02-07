// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:video_player/video_player.dart';

// class ChewieListItem extends StatefulWidget {
//   final VideoPlayerController? videoPlayerController;

//   final bool? loop;

//   ChewieListItem({
//     @required this.videoPlayerController,
//     this.loop,
//   });

//   @override
//   _ChewieListItemState createState() => _ChewieListItemState();
// }

// class _ChewieListItemState extends State<ChewieListItem> {
//   ChewieController? _chewieController;

//   bool isPlaying = false;
//   Widget? image = Image.asset(
//     'assets/hubla_img.jpeg',
//     height: double.infinity,
//     width: double.infinity,
//     fit: BoxFit.fill,
//   );

//   @override
//   void initState() {
//     super.initState();
//     _chewieController = ChewieController(
//       showControls: true,
//       aspectRatio: 1 / 1,
//       autoInitialize: true,
//       looping: widget.loop!,
//       overlay: getOverlay(),
//       showControlsOnInitialize: false,
//       videoPlayerController: widget.videoPlayerController!,
//       deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
//       deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeLeft],
//       errorBuilder: (context, errorMessage) {
//         return Center(
//           child: Text(
//             errorMessage,
//             style: const TextStyle(
//               color: Colors.white,
//             ),
//           ),
//         );
//       },
//     );
//     videoListener();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;
//     var height = MediaQuery.of(context).size.height;
//     var prop = height / width;

//     return Column(
//       children: [
//         Container(
//           color: Colors.black,
//           padding: EdgeInsets.symmetric(vertical: 8 * prop),
//           height: height * 0.3,
//           child: Chewie(
//             controller: _chewieController!,
//           ),
//         ),
//       ],
//     );
//   }

//   void videoListener() {
//     widget.videoPlayerController!.addListener(checkVideo);
//   }

//   void checkVideo() {
//     // Implement your calls inside these conditions' bodies :

//     int? secondsPosition = widget.videoPlayerController?.value.position.inSeconds;
//     int? secondsDuration = widget.videoPlayerController!.value.duration.inSeconds;
//     int? minutesPosition = widget.videoPlayerController!.value.position.inMinutes;
//     Duration? actualPosition = widget.videoPlayerController?.value.position;
//     Duration? videoDuration = widget.videoPlayerController?.value.duration;

//     if (actualPosition == const Duration(seconds: 0, minutes: 0, hours: 0)) {
//       print('video Started');
//     }
//     if (widget.videoPlayerController!.value.isPlaying) {
//       setState(() {
//         print('playing setState');

//         isPlaying = true;
//       });
//     }
//     if (secondsPosition! <= secondsDuration) {
//       print('minutes:$minutesPosition, seconds:$secondsPosition');
//     }
//     if (actualPosition == videoDuration) {
//       print('video Ended');
//     }
//   }

//   Widget? getOverlay() {
//     if (isPlaying) {
//       print('playing');
//       return Container();
//     } else {
//       return image;
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _chewieController?.dispose();
//     widget.videoPlayerController?.dispose();
//     widget.videoPlayerController!.removeListener(checkVideo);
//   }
// }
