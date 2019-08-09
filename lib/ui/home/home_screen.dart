import 'package:flutter/material.dart';
import 'package:reprodutor_de_videos/ui/player/video_player_screen.dart';
import 'package:video_player/video_player.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Player de Videos"),
      ),
      body: Container(
        child: VideoPlayerScreen(videoPlayerController: VideoPlayerController.network(
          'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
        ),),
      ),
    );
  }
}
