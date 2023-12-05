// ignore: file_names
import 'dart:convert';

HomeModel homeModelFromJson(String? str) => HomeModel.fromJson(json.decode(str!));

class HomeModel {
  HomeModel({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  bool success;
  int code;
  String message;
  List<Datum> data;

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );
}

class Datum {
  Datum({
    required this.banner,
    required this.most,
    required this.latest,
  });

  List<ItemVideos> banner;
  List<ItemVideos> most;
  List<ItemVideos> latest;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        banner: List<ItemVideos>.from(
            json["banner"].map((x) => ItemVideos.fromJson(x))),
        most: List<ItemVideos>.from(
            json["most"].map((x) => ItemVideos.fromJson(x))),
        latest: List<ItemVideos>.from(
            json["latest"].map((x) => ItemVideos.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "banner": List<dynamic>.from(banner.map((x) => x.toJson())),
        "most": List<dynamic>.from(most.map((x) => x.toJson())),
        "latest": List<dynamic>.from(latest.map((x) => x.toJson())),
      };
}



class ItemVideos {
  ItemVideos({
    required this.id,
    required this.ids,
    required this.published,
    required this.channelId,
    required this.title,
    required this.description,
    required this.thumb,
    required this.channelTitle,
    required this.duration,
    required this.tags,
    required this.category,
    required this.app,
    required this.createdAt,
    required this.updatedAt,
    required this.favorite,
  });

  int id;
  String ids;
  DateTime published;
  String channelId;
  String title;
  String description;
  String thumb;
  String channelTitle;
  dynamic duration;
  dynamic tags;
  dynamic category;
  int app;
  dynamic createdAt;
  dynamic updatedAt;
  bool favorite;

  factory ItemVideos.fromJson(Map<String, dynamic> json) => ItemVideos(
      id: json["id"],
      ids: json["ids"],
      published: DateTime.parse(json["published"]),
      channelId: json["channel_id"],
      title: json["title"],
      description: json["description"],
      thumb: json["thumb"],
      channelTitle: json["channel_title"],
      duration: json["duration"],
      tags: json["tags"],
      category: json["category"],
      app: json["app"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
      favorite: false);

  factory ItemVideos.fromMap(Map<String, dynamic> json) => ItemVideos(
      id: json["id"],
      ids: json["ids"],
      published: DateTime.parse(json["published"]),
      channelId: json["channel_id"],
      title: json["title"],
      description: json["description"],
      thumb: json["thumb"],
      channelTitle: json["channel_title"],
      favorite: json["fav"] == 1 ? true : false, 
      app: json["app"], 
      category: json["category"], 
      createdAt: json["created_at"], 
      duration: json["duration"], 
      tags: json["tags"], 
      updatedAt: json["updated_at"]);

  Map<String, dynamic> toMap() => {
        "id": id,
        "ids": ids,
        "published": published.toIso8601String(),
        "channel_id": channelId,
        "title": title,
        "description": description,
        "thumb": thumb,
        "channel_title": channelTitle,
        "fav": favorite,
        "app": app,
        "category": category,
        "created_at": createdAt,
        "duration": duration,
        "tags": tags,
        "updated_at": updatedAt
      };

  Map<String, dynamic> toJson() => {
        "id": id,
        "ids": ids,
        "published": published.toIso8601String(),
        "channel_id": channelId,
        "title": title,
        "description": description,
        "thumb": thumb,
        "channel_title": channelTitle,
        "duration": duration,
        "tags": tags,
        "category": category,
        "app": app,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
