// To parse this JSON data, do
//
//     final adsModel = adsModelFromJson(jsonString);

import 'dart:convert';

AdsModel adsModelFromJson(String? str) => AdsModel.fromJson(json.decode(str!));

String adsModelToJson(AdsModel data) => json.encode(data.toJson());

class AdsModel {
    AdsModel({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    bool success;
    int code;
    String message;
    List<Datum> data;

    factory AdsModel.fromJson(Map<String, dynamic> json) => AdsModel(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    Datum({
        required this.app,
    });

    App app;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        app: App.fromJson(json["app"]),
    );

    Map<String, dynamic> toJson() => {
        "app": app.toJson(),
    };
}

class App {
    App({
        required this.player,
        required this.admob,
        required this.isNew,
        required this.package,
    });

    String player;
    Admob admob;
    bool isNew;
    dynamic package;

    factory App.fromJson(Map<String, dynamic> json) => App(
        player: json["player"],
        admob: Admob.fromJson(json["admob"]),
        isNew: json["is_new"],
        package: json["package"],
    );

    Map<String, dynamic> toJson() => {
        "player": player,
        "admob": admob.toJson(),
        "is_new": isNew,
        "package": package,
    };
}

class Admob {
    Admob({
        required this.id,
        required this.appId,
        required this.banner,
        required this.interstitial,
        required this.native,
        required this.reward,
        required this.open,
        required this.app,
        required this.createdAt,
        required this.updatedAt,
    });

    int id;
    String appId;
    int banner;
    String interstitial;
    String native;
    String reward;
    String open;
    int app;
    DateTime createdAt;
    DateTime updatedAt;

    factory Admob.fromJson(Map<String, dynamic> json) => Admob(
        id: json["id"],
        appId: json["app_id"],
        banner: json["banner"],
        interstitial: json["interstitial"],
        native: json["native"],
        reward: json["reward"],
        open: json["open"],
        app: json["app"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Admob.fromMap(Map map)
      : id = map["id"],
        appId = map["app_id"],
        banner = map["banner"],
        interstitial = map["interstitial"],
        native = map["native"],
        reward = map["reward"],
        open = map["open"],
        app = map["app"],
        createdAt = DateTime.parse(map["created_at"]),
        updatedAt = DateTime.parse(map["updated_at"]);

    Map<String, dynamic> toJson() => {
        "id": id,
        "app_id": appId,
        "banner": banner,
        "interstitial": interstitial,
        "native": native,
        "reward": reward,
        "open": open,
        "app": app,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };

    Map<String, dynamic> clonToJson() => {
        "id": 0,
        "app_id": "admob",
        "banner": "ca-app-pub-3940256099942544/1033173712",
        "interstitial": "ca-app-pub-3940256099942544/1033173712",
        "native": "ca-app-pub-3940256099942544/2247696110",
        "reward": "ca-app-pub-3940256099942544/5224354917",
        "open": "ca-app-pub-3940256099942544/3419835294",
        "app": 0,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
