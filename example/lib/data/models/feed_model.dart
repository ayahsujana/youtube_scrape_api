import 'dart:convert';

import 'home_model.dart';

FeedsModel feedsModelFromJson(String? str) => FeedsModel.fromJson(json.decode(str!));


class FeedsModel {
    FeedsModel({
        required this.data,
    });

    List<DaFeeds> data;

    factory FeedsModel.fromJson(Map<String, dynamic> json) => FeedsModel(
        data: List<DaFeeds>.from(json["data"].map((x) => DaFeeds.fromJson(x))),
    );

}

class DaFeeds {
    DaFeeds({
        required this.feeds,
    });

    List<ItemVideos> feeds;

    factory DaFeeds.fromJson(Map<String, dynamic> json) => DaFeeds(
        feeds: List<ItemVideos>.from(json["feeds"].map((x) => ItemVideos.fromJson(x))),
    );

   
}
