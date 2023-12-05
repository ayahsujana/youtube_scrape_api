// To parse this JSON data, do
//
//     final channelModel = channelModelFromJson(jsonString);

import 'dart:convert';

ChannelModel channelModelFromJson(String? str) => ChannelModel.fromJson(json.decode(str!));


class ChannelModel {
    ChannelModel({
        required this.data,
    });

    List<Datums> data;

    factory ChannelModel.fromJson(Map<String, dynamic> json) => ChannelModel(
        data: List<Datums>.from(json["data"].map((x) => Datums.fromJson(x))),
    );


}

class Datums {
    Datums({
        required this.channels,
    });

    List<Chennels> channels;

    factory Datums.fromJson(Map<String, dynamic> json) => Datums(
        channels: List<Chennels>.from(json["channels"].map((x) => Chennels.fromJson(x))),
    );

}

class Chennels {
    Chennels({
        required this.id,
        required this.ids,
        required this.title,
        required this.description,
        required this.customUrl,
        required this.thumb,
        required this.app,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String ids;
    String title;
    String description;
    String customUrl;
    String thumb;
    int app;
    dynamic createdAt;
    dynamic updatedAt;

    factory Chennels.fromJson(Map<String, dynamic> json) => Chennels(
        id: json["id"],
        ids: json["ids"],
        title: json["title"],
        description: json["description"],
        customUrl: json["custom_url"],
        thumb: json["thumb"],
        app: json["app"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ids": ids,
        "title": title,
        "description": description,
        "custom_url": customUrl,
        "thumb": thumb,
        "app": app,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
