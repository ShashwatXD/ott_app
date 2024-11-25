import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String videoUrl; 

  const VideoPlayerScreen({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      videoUrl,
    );

    BetterPlayerController betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        autoPlay: true, 
        looping: false, 
        fullScreenByDefault: false, 
        controlsConfiguration: BetterPlayerControlsConfiguration(
          enablePlayPause: true,
          enableMute: true,
          enableQualities: true,
          enableSubtitles: true, 
          showControlsOnInitialize: true,
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
