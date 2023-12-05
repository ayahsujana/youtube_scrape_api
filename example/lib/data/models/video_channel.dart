import 'dart:convert';
import 'home_model.dart';

VideosChannelModel videosChannelModelFromJson(String? str) => VideosChannelModel.fromJson(json.decode(str!));

class VideosChannelModel {
    VideosChannelModel({
        required this.data,
    });

    List<VideosChannelModelDatum> data;

    factory VideosChannelModel.fromJson(Map<String, dynamic> json) => VideosChannelModel(
        data: List<VideosChannelModelDatum>.from(json["data"].map((x) => VideosChannelModelDatum.fromJson(x))),
    );

  
}

VideosChannelModelDatum mdatumChannelModelFromJson(String? str) => VideosChannelModelDatum.fromJson(json.decode(str!));

class VideosChannelModelDatum {
    VideosChannelModelDatum({
        required this.currentPage,
        required this.data,
        required this.nextPageUrl,
        required this.path,
        required this.perPage,
        required this.prevPageUrl,
        required this.to,
        required this.total,
    });

    int currentPage;
    List<ItemVideos> data;
    String nextPageUrl;
    String path;
    int perPage;
    dynamic prevPageUrl;
    int to;
    int total;

    factory VideosChannelModelDatum.fromJson(Map<String, dynamic> json) => VideosChannelModelDatum(
        currentPage: json["current_page"],
        data: List<ItemVideos>.from(json["data"].map((x) => ItemVideos.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
    };
}