import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VideoModel {
  int? id;
  String title;
  String channelId;
  String channelName;
  String channelThumb;
  String videoId;
  String date;
  String duration;
  String description;
  String likeCount;
  String subscribeCount;
  String viewCount;
  String unLikeCount;
  VideoModel({
    this.id,
    required this.title,
    required this.channelId,
    required this.channelName,
    required this.channelThumb,
    required this.videoId,
    required this.date,
    required this.duration,
    required this.description,
    required this.likeCount,
    required this.subscribeCount,
    required this.viewCount,
    required this.unLikeCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'channelId': channelId,
      'channelName': channelName,
      'channelThumb': channelThumb,
      'videoId': videoId,
      'date': date,
      'duration': duration,
      'description': description,
      'likeCount': likeCount,
      'subscribeCount': subscribeCount,
      'viewCount': viewCount,
      'unLikeCount': unLikeCount,
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      id: map['id'] != null ? map['id'] as int : null,
      title: map['title'] as String,
      channelId: map['channelId'] as String,
      channelName: map['channelName'] as String,
      channelThumb: map['channelThumb'] as String,
      videoId: map['videoId'] as String,
      date: map['date'] as String,
      duration: map['duration'] as String,
      description: map['description'] as String,
      likeCount: map['likeCount'] as String,
      subscribeCount: map['subscribeCount'] as String,
      viewCount: map['viewCount'] as String,
      unLikeCount: map['unLikeCount'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory VideoModel.fromJson(String source) => VideoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  VideoModel copyWith({
    int? id,
    String? title,
    String? channelId,
    String? channelName,
    String? channelThumb,
    String? videoId,
    String? date, 
    String? duration, 
    String? description,
    String? likeCount,
    String? subscribeCount,
    String? viewCount,
    String? unLikeCount,
  }) {
    return VideoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      channelId: channelId ?? this.channelId,
      channelName: channelName ?? this.channelName,
      channelThumb: channelThumb ?? this.channelThumb,
      videoId: videoId ?? this.videoId,
      date: date ?? this.date,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      likeCount: likeCount ?? this.likeCount,
      subscribeCount: subscribeCount ?? this.subscribeCount,
      viewCount: viewCount ?? this.viewCount,
      unLikeCount: unLikeCount ?? this.unLikeCount,
    );
  }

  @override
  String toString() {
    return 'VideoModel(id: $id, title: $title, channelId: $channelId, channelName: $channelName, channelThumb: $channelThumb, videoId: $videoId, date: $date, duration: $duration, description: $description, likeCount: $likeCount, subscribeCount: $subscribeCount, viewCount: $viewCount, unLikeCount: $unLikeCount)';
  }
}
