import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:toast/toast.dart';

class VideoPlayerScreen extends StatefulWidget {
  VideoPlayerScreen({Key key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  bool isShow = false;
  @override
  void initState() {

    initVideo("https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4");

    super.initState();
  }

  void initVideo(String videoUrl){
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.network(
      videoUrl,
    );

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(false);
    _controller.play();
    _controller.addListener(acao);
  }

  VoidCallback acao() {
    //if (_controller.value.duration.inSeconds == _controller.value.position.inSeconds) {
    if (_controller.value.initialized && !_controller.value.isPlaying) {
      setState(() {
        isShow = true;
      });
        print("FINALO");
      initVideo("https://www.w3schools.com/html/mov_bbb.mp4");
      //initVideo("http://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4");
    }
    //print(player.valueNotifier.value.position.inSeconds);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    alert("FINALIZOU");
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Butterfly Video'),
//      ),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
//          if(_controller.value.initialized && !_controller.value.isPlaying){
//            print("FIM");
//          }
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: Container(
                child: Stack(
                  children: <Widget>[
                    VideoPlayer(_controller),
                    Align(
                      alignment: Alignment.center,
                      child: InkWell(
                          onTap: _playPause,
                          child: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            size: 80,
                            color: Colors.white,
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: isShow ? Text("FINALIZANDO") : Text("..."),
                    )
                  ],
                ),
              ),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  void _playPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        // If the video is paused, play it.
        _controller.play();
      }
    });
  }

  void alert(String text){
    Toast.show("$text", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
  }
}
