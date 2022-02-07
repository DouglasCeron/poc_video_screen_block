import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BetterPlayClass extends StatefulWidget {
  const BetterPlayClass({Key? key}) : super(key: key);

  @override
  _BetterPlayClassState createState() => _BetterPlayClassState();
}

class _BetterPlayClassState extends State<BetterPlayClass> {
  BetterPlayerController? _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
    );

    _betterPlayerController = BetterPlayerController(
      BetterPlayerConfiguration(
        fit: BoxFit.contain,
        aspectRatio: 16 / 9,
        autoPlay: false,
        looping: false,
        deviceOrientationsAfterFullScreen: [
          DeviceOrientation.portraitDown,
          DeviceOrientation.portraitUp,
        ],
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BetterPlayer(controller: _betterPlayerController!),
    );
  }
}
