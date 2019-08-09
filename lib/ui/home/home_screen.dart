import 'package:flutter/material.dart';
import 'package:reprodutor_de_videos/ui/player/video_player_screen.dart';

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
        child: VideoPlayerScreen(),
      ),
    );
  }
}
