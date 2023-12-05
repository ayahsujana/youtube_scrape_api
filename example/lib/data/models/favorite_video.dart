import 'basic_video_list.dart';

class FavoriteVideos extends BasicVideoList {
  FavoriteVideos();
  FavoriteVideos.fromJson(super.json) : super.fromJson();

  @override
  String getName() => 'videoId';
}
