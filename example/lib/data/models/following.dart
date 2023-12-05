import 'package:skibidiwartube/data/models/subscribed.dart';

abstract class BasicSubscribed {
  List<Subscribed> list = [];
  bool contains(Subscribed subscribed) {
    return list.any((e) {
      return e.channelId == subscribed.channelId;
    });
  }

  void add(Subscribed subscribed) {
    if (contains(subscribed)) return;
    list.insert(0, subscribed);
  }

  void remove(Subscribed subscribed) {
    list.removeWhere((e) {
      return e.channelId == subscribed.channelId;
    });
  }

  BasicSubscribed();
  BasicSubscribed.fromJson(Map<String, dynamic> json) {
    final temp = json[getChannelId()] as List;
    list = temp.map((e) => Subscribed.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() =>
      {getChannelId(): list.map((e) => e.toJson()).toList(growable: false)};

  String getChannelId();
}

class Following extends BasicSubscribed {
  Following();
  Following.fromJson(super.json) : super.fromJson();

  @override
  String getChannelId() => 'channelId';
}
