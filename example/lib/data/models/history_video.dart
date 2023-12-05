import 'package:skibidiwartube/data/models/video_model.dart';

import 'basic_video_list.dart';

class WatchHistory extends BasicVideoList {
  WatchHistory();
  WatchHistory.fromJson(
    Map<String, dynamic> json,
  ) : super.fromJson(json);

  @override
  bool contains(VideoModel? anime) {
    return list.any((e) => e?.videoId == anime!.videoId);
  }

  @override
  String getName() => 'history';
}
