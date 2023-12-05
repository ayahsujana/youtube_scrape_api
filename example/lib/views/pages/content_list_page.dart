import 'package:skibidiwartube/views/screens/details/detail_screen.dart';
import 'package:skibidiwartube/widget/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:youtube_scrape_api/models/video.dart';

class ContentListPage extends StatelessWidget {
  const ContentListPage({
    Key? key,
    required this.video,
  }) : super(key: key);
  final List<Video> video;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: video.length,
      itemBuilder: (context, index) {
        Video videos = video[index];
        return InkWell(
          onTap: () => Get.to(
            DetailScreen(
              videoId: videos.videoId!,
              duration: videos.duration!,
              viewer: videos.uploadDate!.isEmpty,
            ),
          ),
          child: ContentVideos(videos: videos),
        );
      },
    );
  }
}

class ContentVideos extends StatelessWidget {
  const ContentVideos({
    super.key,
    required this.videos,
  });

  final dynamic videos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Card(
        elevation: 5,
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                coverTrending(videos.videoId!),
                Positioned(
                  bottom: 8.0,
                  right: 10.0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: videos.duration == 'LIVE'
                            ? Colors.red
                            : videos.views == null
                                ? Colors.black.withOpacity(0.7)
                                : Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(6)),
                    child: Center(
                      child: Text(
                        videos.duration ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                videos.title ?? '',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 5),
              child: RowListContent(videos: videos),
            ),
          ],
        ),
      ),
    );
  }
}

class RowListContent extends StatelessWidget {
  const RowListContent({
    super.key,
    required this.videos,
  });

  final dynamic videos;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          videos.channelName ?? '',
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 12),
        ),
        const Text(' • '),
        Text(
          videos.views ?? '',
          maxLines: 1,
          style: const TextStyle(fontSize: 12),
        ),
        videos.duration != 'LIVE' ? const Text(' • ') : const SizedBox(),
        Flexible(
          child: Text(
            videos.uploadDate ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }
}
