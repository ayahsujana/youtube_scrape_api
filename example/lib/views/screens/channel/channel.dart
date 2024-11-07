import 'package:get/get.dart';
import 'package:skibidiwartube/data/models/subscribed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_scrape_api/models/channel_data.dart';
import 'package:youtube_scrape_api/models/video.dart';

import 'package:skibidiwartube/cubit/channels/channels_cubit.dart';
import 'package:skibidiwartube/cubit/following/following_channel.dart';
import 'package:skibidiwartube/utils/constants/constants.dart';
import 'package:skibidiwartube/views/screens/details/detail_screen.dart';
import 'package:skibidiwartube/widget/cache_network_image.dart';
import 'package:skibidiwartube/widget/loading.dart';

class ChannelScreen extends StatefulWidget {
  const ChannelScreen({
    Key? key,
    required this.channelId,
  }) : super(key: key);
  final String channelId;

  @override
  State<ChannelScreen> createState() => _ChannelScreenState();
}

class _ChannelScreenState extends State<ChannelScreen> {
  final channelsCubit = ChannelsCubit();

  @override
  void dispose() {
    super.dispose();
    channelsCubit.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider.value(
          value: channelsCubit..getChannelVideos(channelId: widget.channelId),
          child: BlocBuilder<ChannelsCubit, ChannelsState>(
            builder: (context, state) {
              if (state is ChannelsSuccess) {
                return ChannelContentPage(
                  channelData: state.channel!,
                  channelId: widget.channelId,
                );
              }
              return const Center(
                child: Loading(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class ChannelContentPage extends StatefulWidget {
  const ChannelContentPage({
    Key? key,
    required this.channelData,
    required this.channelId,
  }) : super(key: key);
  final ChannelData channelData;
  final String channelId;

  @override
  State<ChannelContentPage> createState() => _ChannelContentPageState();
}

class _ChannelContentPageState extends State<ChannelContentPage> {
  late List<Video> contentList;

  @override
  void initState() {
    super.initState();
    contentList = widget.channelData.videosList;
  }

  @override
  Widget build(BuildContext context) {
    final follow = Subscribed(
        username: widget.channelData.channel.channelName!,
        channelId: widget.channelId,
        avatar: widget.channelData.channel.avatar!,
        videosCount: '');
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // widget.channelData.channel.banner != null
            //     ? Container(
            //         height: 100,
            //         width: double.infinity,
            //         decoration: BoxDecoration(
            //             image: DecorationImage(
            //                 image: Image.network(
            //                         widget.channelData.channel.banner!)
            //                     .image,
            //                 fit: BoxFit.cover)),
            //       )
            //     : Container(),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.network(widget.channelData.channel.banner!)
                          .image,
                      fit: BoxFit.cover)),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [Colors.black, Colors.black38],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Container(
                            height: 53,
                            width: 53,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: Image.network(
                                            widget.channelData.channel.avatar!)
                                        .image,
                                    fit: BoxFit.cover))),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.channelData.channel.channelName!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                widget.channelData.channel.subscribers!,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                widget.channelData.channel.videoCounts!+'s',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<FollowingCubit, List<Subscribed?>>(
                        builder: (context, state) {
                          bool followState = context
                              .watch<FollowingCubit>()
                              .isFollowing(follow);
                          return InkWell(
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
                                      "UnFollow",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : const Text(
                                      "Follow",
                                      maxLines: 1,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: contentList.length >= 30
                    ? contentList.length - 1
                    : contentList.length,
                itemBuilder: (context, index) {
                  Video video = contentList[index];
                  return InkWell(
                    onTap: () => Get.to(DetailScreen(
                      videoId: video.videoId!,
                      duration: video.duration!,
                      viewer: video.uploadDate!.isEmpty,
                    )),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        height: 105,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Row(
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
                                coverImage(video.videoId!),
                                Positioned(
                                  bottom: 6,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: video.duration == 'LIVE'
                                            ? Colors.red
                                            : video.views == null
                                                ? Colors.black.withOpacity(0.7)
                                                : Colors.black.withOpacity(0.7),
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Center(
                                      child: Text(
                                        video.uploadDate!.isNotEmpty
                                            ? video.duration!
                                            : video.views == null
                                                ? 'MENDATANG'
                                                : 'PREMIERE',
                                        style: const TextStyle(
                                            fontSize: 13, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Expanded(
                                child: Container(
                              padding: const EdgeInsets.only(left: 12),
                              height: 105,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    video.title!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(
                                    video.uploadDate ?? '',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${video.views}',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
