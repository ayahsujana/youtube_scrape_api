import 'dart:convert';

AppAdsUpdate appAdsUpdateFromJson(String str) => AppAdsUpdate.fromJson(json.decode(str));

String appAdsUpdateToJson(AppAdsUpdate data) => json.encode(data.toJson());

class AppAdsUpdate {
    App app;
    List<Ad> ads;

    AppAdsUpdate({
        required this.app,
        required this.ads,
    });

    factory AppAdsUpdate.fromJson(Map<String, dynamic> json) => AppAdsUpdate(
        app: App.fromJson(json["app"]),
        ads: List<Ad>.from(json["ads"].map((x) => Ad.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "app": app.toJson(),
        "ads": List<dynamic>.from(ads.map((x) => x.toJson())),
    };
}

class Ad {
    String nameAds;
    String typeAds;
    String unitAds;

    Ad({
        required this.nameAds,
        required this.typeAds,
        required this.unitAds,
    });

    factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        nameAds: json["name_ads"],
        typeAds: json["type_ads"],
        unitAds: json["unit_ads"],
    );

    Map<String, dynamic> toJson() => {
        "name_ads": nameAds,
        "type_ads": typeAds,
        "unit_ads": unitAds,
    };
}

class App {
    String id;
    String name;
    String package;
    String status;

    App({
        required this.id,
        required this.name,
        required this.package,
        required this.status,
    });

    factory App.fromJson(Map<String, dynamic> json) => App(
        id: json["id"],
        name: json["name"],
        package: json["package"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "package": package,
        "status": status,
    };
}
