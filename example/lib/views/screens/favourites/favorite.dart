import 'package:skibidiwartube/views/screens/details/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:skibidiwartube/cubit/favorite/favorite_videos.dart';
import 'package:skibidiwartube/data/models/video_model.dart';
import 'package:skibidiwartube/utils/constants/constants.dart';
import 'package:skibidiwartube/widget/cache_network_image.dart';
import 'package:line_icons/line_icons.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<FavoriteVideoCubit>()..fetchFavorite(),
      child: BlocBuilder<FavoriteVideoCubit, List<VideoModel?>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return SizedBox(
              height: Get.height,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/favorite_banner.png',
                    width: 200,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Your favorites list is empty',
                  ),
                  const Text(
                    'Add some video to find them later',
                  ),
                ],
              )),
            );
          } else {
            return ListView.builder(
              itemCount: state.length,
              itemBuilder: (context, index) {
                final video = state[index];
                return ContentFavorite(
                  video: video!,
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ContentFavorite extends StatelessWidget {
  const ContentFavorite({
    Key? key,
    required this.video,
  }) : super(key: key);
  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(
        DetailScreen(
          videoId: video.videoId,
          duration: video.duration,
          viewer: video.date.isEmpty,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 5,
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  coverTrending(video.videoId),
                  Positioned(
                    bottom: 8.0,
                    right: 10.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                          color: video.duration == 'LIVE'
                              ? Colors.red
                              : Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(6)),
                      child: Center(
                        child: Text(
                          video.duration,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    right: 0.0,
                    child: BlocBuilder<FavoriteVideoCubit, List<VideoModel?>>(
                      builder: (context, state) => InkWell(
                        onTap: () => context
                            .read<FavoriteVideoCubit>()
                            .toggleFavorite(video),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(defaultColor),
                              borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(10))),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              LineIcons.trash,
                              color: Colors.white,
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  video.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, bottom: 5),
                child: RowListContentFavorite(video: video),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RowListContentFavorite extends StatelessWidget {
  const RowListContentFavorite({
    Key? key,
    required this.video,
  }) : super(key: key);
  final VideoModel video;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          video.channelName,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 12),
        ),
        const Text(' • '),
        Flexible(
          child: Text(
            video.date.replaceAll('Telah tayang perdana pada ', ''),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        )
      ],
    );
  }
}
