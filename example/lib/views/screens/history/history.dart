import 'package:skibidiwartube/cubit/history/history_videos.dart';
import 'package:skibidiwartube/data/models/video_model.dart';
import 'package:skibidiwartube/utils/constants/constants.dart';
import 'package:skibidiwartube/views/screens/details/detail_screen.dart';
import 'package:skibidiwartube/widget/cache_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<HistoryVideoCubit>()..fetchHistory(),
      child: BlocBuilder<HistoryVideoCubit, List<VideoModel?>>(
        builder: (context, state) {
          if (state.isEmpty) {
            return const Center(
              child: Text(
                'Your history watched\nwill be show in here',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
            );
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: state.length,
            itemBuilder: (context, index) {
              final video = state[index]!;
              return InkWell(
                onTap: () => Get.to(DetailScreen(
                  videoId: video.videoId,
                  duration: video.duration,
                  viewer: video.date.isEmpty,
                )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: <Widget>[
                          coverImage(video.videoId),
                          Positioned(
                            bottom: 6,
                            right: 8,
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
                                  style: const TextStyle(
                                      fontSize: 13, color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  video.channelName,
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  style: TextStyle(
                                      color: Color(defaultColor),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: SizedBox(
                            width: 180,
                            child: Center(
                              child: Text(
                                video.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
