import 'video_model.dart';

abstract class BasicVideoList {
  List<VideoModel?> list = [];
  bool contains(VideoModel? video) {
    return list.any((e) {
      return e?.videoId == video?.videoId;
    });
  }

  void add(VideoModel? video) {
    if (contains(video)) return;
    list.insert(0, video);
  }

  void remove(VideoModel? video) {
    list.removeWhere((e) {
      return e?.videoId == video?.videoId;
    });
  }

  BasicVideoList();
  BasicVideoList.fromJson(Map<String, dynamic> json) {
    final temp = json[getName()] as List;
    list = temp.map((e) => VideoModel.fromMap(e)).toList();
  }

  Map<String, dynamic> toJson() =>
      {getName(): list.map((e) => e?.toMap()).toList(growable: false)};

  String getName();
}