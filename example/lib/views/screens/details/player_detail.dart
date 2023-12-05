import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class PodPlayerVideos extends StatefulWidget {
  const PodPlayerVideos({
    Key? key,
    required this.controller,
    required this.videoId,
  }) : super(key: key);
  final PodPlayerController controller;
  final String videoId;

  @override
  State<PodPlayerVideos> createState() => _PodPlayerVideosState();
}

class _PodPlayerVideosState extends State<PodPlayerVideos> {
  @override
  Widget build(BuildContext context) {
    return PodVideoPlayer(
      controller: widget.controller,
      onVideoError: () {
        return SizedBox(
          height: 220,
          width: double.infinity,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sorry, something wrong please click reload!',
              ),
              const SizedBox(
                height: 10.0,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  widget.controller.changeVideo(
                      playVideoFrom: PlayVideoFrom.youtube(
                          "https://www.youtube.com/watch?v=${widget.videoId}"));
                  setState(() {});
                },
                child: const Text("Reload"),
              ),
            ],
          )),
        );
      },
    );
  }
}
