import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:media_player/data_sources.dart';
import 'package:media_player/media_player.dart';
import 'package:media_player/ui.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  MediaPlayer player;
  MediaFile song1 = MediaFile(
    title: "Song 1",
    type: "video",
    //source: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8",
    source: "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    desc: "Note from Apple",
  );

  @override
  void initState() {
    // first argument for isBackground next for showNotification.
    player = MediaPlayerPlugin.create(isBackground: true, showNotification: true);
    initVideo();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  void initVideo() async {
    await player.initialize();
    await player.setSource(song1);
    player.play();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      VideoPlayerView(player),
      VideoProgressIndicator(
        player,
        allowScrubbing: true,
        padding: EdgeInsets.symmetric(vertical:5.0),
      ),
      SizedBox(height:20.0),
      buildButtons()
    ]);
  }

  Row buildButtons() {
    return Row(
      children: <Widget>[
        FlatButton(
          child: Text("Prev"),
          onPressed: () {
            player.playPrev();
          },
        ),
        FlatButton(
          child: Text("Play"),
          onPressed: () {
            player.play();
          },
        ),
        FlatButton(
          child: Text("Pause"),
          onPressed: () {
            player.pause();
          },
        ),
        FlatButton(
          child: Text("Next"),
          onPressed: () {
            player.playNext();
          },
        ),
      ],
    );
  }

  void alert(String text){
    Toast.show("$text", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}
