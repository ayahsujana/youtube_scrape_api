import 'package:skibidiwartube/cubit/detail/detail_cubit.dart';
import 'package:skibidiwartube/cubit/favorite/favorite_videos.dart';
import 'package:skibidiwartube/cubit/following/following_channel.dart';
import 'package:skibidiwartube/views/pages/content_list_page.dart';
import 'package:skibidiwartube/views/screens/details/channel_detail.dart';
import 'package:skibidiwartube/views/screens/details/player_detail.dart';
import 'package:skibidiwartube/views/screens/details/video_detail.dart';
import 'package:skibidiwartube/widget/annotate.dart';
import 'package:skibidiwartube/widget/custom_route.dart';
import 'package:skibidiwartube/widget/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:skibidiwartube/widget/screen_custom.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({
    super.key,
    required this.videoId,
    required this.duration,
    required this.viewer,
  });
  final String videoId;
  final String duration;
  bool viewer;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late PodPlayerController _controller;
  bool isLive = false;
  bool isSwitched = true;
  var isNextVideo;

  @override
  void initState() {
    super.initState();
    context.read<FavoriteVideoCubit>().fetchFavorite();
    context.read<FollowingCubit>().getAllFollowing();
    context.read<DetailCubit>().getVideoDetail(videoId: widget.videoId);
    if (widget.duration == 'LIVE' || widget.viewer) {
      setState(() {
        isLive = true;
      });
    }
    Screen.setPortrait();
    _controller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.youtube(
          'https://www.youtube.com/watch?v=${widget.videoId}',
          live: isLive),
    )
      ..initialise()
      ..addListener(() {
        if (isSwitched) {
          if (_controller.currentVideoPosition.inSeconds
              .isEqual(_controller.totalVideoLength.inSeconds)) {
            Navigator.of(context).pushReplacement(CustomRoute(
              builder: (context) => DetailScreen(
                videoId: isNextVideo[0].videoId,
                duration: isNextVideo[0].duration,
                viewer: isNextVideo[0].views.isEmpty,
              ),
            ));
          }
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    Screen.setPortrait();
  }

  @override
  Widget build(BuildContext context) {
    return KhmertracksAnnotatedRegionWidget(
        child: ScreenTypeLayout.builder(
            mobile: (context) => Scaffold(
                  body: SafeArea(
                    child: Column(
                      children: [
                        PodPlayerVideos(
                          controller: _controller,
                          videoId: widget.videoId,
                        ),
                        
                        BlocBuilder<DetailCubit, DetailState>(
                          builder: (context, state) {
                            if (state is DetailSuccess) {
                              return Expanded(
                                child: ListView(
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  children: [
                                    VideoDetail(
                                      video: state.video!.video!,
                                      duration: widget.duration,
                                    ),
                                    ChannelDetail(
                                      video: state.video!.video!,
                                      controller: _controller,
                                    ),
                                    const SizedBox(
                                      height: 16.0,
                                    ),
                                    upnext(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: SingleChildScrollView(
                                        physics: const ScrollPhysics(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              height: 10.0,
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount: state
                                                  .video!.videosList.length,
                                              itemBuilder: (context, index) {
                                                isNextVideo =
                                                    state.video!.videosList;
                                                final videos = state
                                                    .video!.videosList[index];
                                                return InkWell(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                              CustomRoute(
                                                        builder: (context) =>
                                                            DetailScreen(
                                                          videoId:
                                                              videos.videoId!,
                                                          duration:
                                                              videos.duration!,
                                                          viewer: videos
                                                              .uploadDate!
                                                              .isEmpty,
                                                        ),
                                                      ));
                                                    },
                                                    child: ContentVideos(
                                                        videos: videos));
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                            return const Center(
                              child: Loading(),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                )));
  }

  upnext() {
    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            "Up next",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          Row(
            children: <Widget>[
              const Text(
                "Autoplay",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  })
            ],
          )
        ],
      ),
    );
  }
}
