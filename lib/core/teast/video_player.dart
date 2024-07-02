import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';



/// Stateful widget to fetch and then display video content.
class VideoApp extends StatefulWidget {
  final String videoUrl;
  final String title;
  const VideoApp({super.key, required this.videoUrl, required this.title});
  @override
  _VideoAppState createState() => _VideoAppState(videoUrl ,title);

}

class _VideoAppState extends State<VideoApp> {
  final String videoUrl;
  final String title;
  late VideoPlayerController _controller;
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  _VideoAppState(this.videoUrl, this.title);
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(
        videoUrl))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: _controller.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: [
                    VideoPlayer(_controller),
                    // Add a Slider for video navigation
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Slider(
                        value: _controller.value.position.inSeconds.toDouble(),
                        min: 0,
                        max: _controller.value.duration.inSeconds.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            _controller.seekTo(Duration(seconds: value.toInt()));
                          });

                        },
                      ),
                    ),
                    // Display current time
                    Positioned(
                      bottom: 0,
                      right: 16,
                      child: Text(
                        '${_controller.value.position.inHours}:${_controller.value.position.inMinutes.remainder(60)}:${_controller.value.position.inSeconds.remainder(60)}',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              )
                  : Container(),
            ),
          ),
          // ... (existing code)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// Inside your _VideoAppState class:
// class _VideoAppState extends State<VideoApp> {
//   // ... (existing code)
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(title),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Center(
//               child: _controller.value.isInitialized
//                   ? AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: Stack(
//                   children: [
//                     VideoPlayer(_controller),
//                     // Add a Slider for video navigation
//                     Positioned(
//                       bottom: 0,
//                       left: 0,
//                       right: 0,
//                       child: Slider(
//                         value: _controller.value.position.inSeconds.toDouble(),
//                         min: 0,
//                         max: _controller.value.duration.inSeconds.toDouble(),
//                         onChanged: (value) {
//                           _controller.seekTo(Duration(seconds: value.toInt()));
//                         },
//                       ),
//                     ),
//                     // Display current time
//                     Positioned(
//                       bottom: 0,
//                       right: 16,
//                       child: Text(
//                         '${_controller.value.position.inHours}:${_controller.value.position.inMinutes.remainder(60)}:${_controller.value.position.inSeconds.remainder(60)}',
//                         style: TextStyle(fontSize: 16),
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//                   : Container(),
//             ),
//           ),
//           // ... (existing code)
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           setState(() {
//             _controller.value.isPlaying
//                 ? _controller.pause()
//                 : _controller.play();
//           });
//         },
//         child: Icon(
//           _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//         ),
//       ),
//     );
//   }
//
// // ... (existing code)
// }

