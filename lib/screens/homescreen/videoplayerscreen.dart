import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoPath; 
  final bool isNetwork; 

  const VideoPlayerScreen({Key? key, required this.videoPath, this.isNetwork = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      isNetwork ? BetterPlayerDataSourceType.network : BetterPlayerDataSourceType.file,
      videoPath,
    );

    BetterPlayerController betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true,
        looping: false,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enablePlayPause: true,
          enableMute: true,
          enableQualities: true,
          enableSubtitles: true,
        ),
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BetterPlayer(
                controller: betterPlayerController,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
