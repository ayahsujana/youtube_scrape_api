// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:last_pod_player/last_pod_player.dart';
import 'package:skibidiwartube/cubit/following/following_channel.dart';
import 'package:skibidiwartube/data/models/subscribed.dart';
import 'package:skibidiwartube/views/screens/channel/channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youtube_scrape_api/models/video_page.dart';

class ChannelDetail extends StatelessWidget {
  const ChannelDetail({
    Key? key,
    required this.video,
    required this.controller,
  }) : super(key: key);
  final VideoPage video;
  final PodPlayerController controller;

  @override
  Widget build(BuildContext context) {
    final follow = Subscribed(
        username: video.channelName!,
        channelId: video.channelId!,
        avatar: video.channelThumb!,
        videosCount: '');
    return ListView(
      shrinkWrap: true,
      children: [
        // Divider(
        //   color: kWhiteColor.withOpacity(0.7),
        // ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                onTap: () {
                  controller.pause();
                  Get.to(ChannelScreen(
                    channelId: video.channelId!,
                  ));
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(video.channelThumb!),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: (MediaQuery.of(context).size.width - 190),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            video.channelName!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, height: 1.3),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: <Widget>[
                              Text(video.subscribeCount ?? '',
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<FollowingCubit, List<Subscribed?>>(
                builder: (context, state) {
                  bool followState =
                      context.watch<FollowingCubit>().isFollowing(follow);
                  return Expanded(
                    child: InkWell(
                      onTap: () => context
                          .read<FollowingCubit>()
                          .toggleFollowing(follow),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: followState
                              ? Colors.grey
                              : const Color.fromARGB(255, 247, 19, 3),
                        ),
                        child: followState
                            ? const Text(
                                "Unfollow",
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )
                            : const Text(
                                "Follow",
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        // Divider(
        //   color: kWhiteColor.withOpacity(0.7),
        // ),
      ],
    );
  }
}
