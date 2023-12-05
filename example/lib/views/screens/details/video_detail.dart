// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:skibidiwartube/cubit/favorite/favorite_videos.dart';
import 'package:skibidiwartube/cubit/history/history_videos.dart';
import 'package:skibidiwartube/data/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_scrape_api/models/video_page.dart';

class VideoDetail extends StatelessWidget {
  const VideoDetail({
    Key? key,
    required this.video,
    required this.duration,
  }) : super(key: key);
  final VideoPage video;
  final String duration;

  @override
  Widget build(BuildContext context) {
    final vm = VideoModel(
        title: video.title!,
        channelId: video.channelId!,
        channelName: video.channelName!,
        channelThumb: video.channelThumb!,
        videoId: video.videoId!,
        date: video.date!,
        duration: duration,
        description: video.description ?? 'No description found!',
        likeCount: video.likeCount!,
        subscribeCount: video.subscribeCount!,
        viewCount: video.viewCount ?? '',
        unLikeCount: video.unlikeCount!);
    context.read<HistoryVideoCubit>().addToHistory(vm);
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: Get.width - 60,
                child: Text(
                  video.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3, right: 3),
                child: GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                        StatefulBuilder(builder: (context, setState) {
                      return Container(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.black87
                            : Colors.white,
                        height: 500,
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [
                                  const Text(
                                    'Description',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () => Get.back(),
                                      icon: const Icon(
                                        Icons.close,
                                        size: 30,
                                      ))
                                ],
                              ),
                            ),
                            const Divider(
                              height: 2,
                            ),
                            Expanded(
                                child: ListView(
                              physics: const BouncingScrollPhysics(),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    video.description ??
                                        'No description found!',
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ),
                      );
                    }));
                  },
                  child: const Icon(
                    LineIcons.angleDoubleDown,
                    size: 20,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                video.viewCount!,
                style: const TextStyle(fontSize: 12),
              ),
              const Text(
                ' • ',
              ),
              Flexible(
                child: Text(
                  video.date!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white12
                        : Colors.black12,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Icon(
                          LineIcons.thumbsUp,
                          size: 22,
                        ),
                        const VerticalDivider(
                          indent: 7,
                          endIndent: 7,
                        ),
                        Text(video.likeCount!,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Share.share(
                        '${video.title!}\n\nhttps://www.youtube.com/watch?v=${video.videoId}');
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white12
                          : Colors.black12,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            LineIcons.share,
                            size: 22,
                          ),
                          VerticalDivider(
                            indent: 7,
                            endIndent: 7,
                          ),
                          Text("Share",
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                  ),
                ),
                BlocBuilder<FavoriteVideoCubit, List<VideoModel?>>(
                    builder: (context, state) {
                  return InkWell(
                    onTap: () => duration == 'LIVE'
                        ? ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Cannot add to favourite in LIVE video')))
                        : context.read<FavoriteVideoCubit>().toggleFavorite(vm),
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white12
                            : Colors.black12,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            context.watch<FavoriteVideoCubit>().isFavourite(vm)
                                ? const Icon(
                                    Icons.favorite_rounded,
                                    color: Colors.pink,
                                    size: 22,
                                  )
                                : const Icon(
                                    Icons.favorite_border_rounded,
                                    size: 22,
                                  ),
                            const VerticalDivider(
                              indent: 7,
                              endIndent: 7,
                            ),
                            const Text("Favorite",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
