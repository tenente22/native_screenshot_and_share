import 'package:flutter/material.dart';
import 'package:native_screenshot_and_share/native_screenshot_and_share.dart';
import 'package:video_player/video_player.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Take screenshot and share'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _controller;
  final String videoUrl =
      "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";

  @override
  void initState() {
    //initialize the video controlller
    _controller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) => setState(() {}));
    super.initState();
  }

  Widget _playPauseButton() {
    final bool isPlaying = _controller.value.isPlaying;
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: FloatingActionButton(
        child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
        onPressed: () {
          setState(() {
            isPlaying ? _controller.pause() : _controller.play();
          });
        },
      ),
    );
  }

  Widget _screenshotAndShareButton() {
    return FloatingActionButton(
      onPressed: () async {
        await Screenshot(context).shareScreenShot();
      },
      child: Stack(
        children: const [
          Icon(
            Icons.camera,
            size: 50,
          ),
          Icon(
            Icons.share,
            color: Colors.blueGrey,
            size: 50,
          )
        ],
      ),
    );
  }

  Widget _floatingActionButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _playPauseButton(),
        _screenshotAndShareButton(),
      ],
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Text('Video from web'),
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: _body(),
        floatingActionButton: _floatingActionButton(),
      ),
    );
  }
}
