import 'dart:convert';

import 'package:skibidiwartube/data/models/following.dart';
import 'package:skibidiwartube/data/models/subscribed.dart';
import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const followingChannel = 'followingChannel';

class FollowingCubit extends Cubit<List<Subscribed?>> {
  FollowingCubit() : super(<Subscribed?>[]);

  Following following = Following();
  bool isFollowing(Subscribed subscribed) => following.contains(subscribed);

  void getAllFollowing() async {
    final pref = await SharedPreferences.getInstance();
    String? follow = pref.getString(followingChannel);
    if (follow != null) {
      following = Following.fromJson(jsonDecode(follow));
    }
    emit(following.list);
  }

  void toggleFollowing(Subscribed subscribed) {
    if (isFollowing(subscribed)) {
      following.remove(subscribed);
      FollowingServices().setFollowing(following);
      emit(following.list);
      getAllFollowing();
    } else {
      following.add(subscribed);
      FollowingServices().setFollowing(following);
      emit(following.list);
      getAllFollowing();
    }
  }
}

class FollowingServices {
  Future<void> setFollowing(Following following) async {
    final pref = await SharedPreferences.getInstance();
    try {
      pref.setString(followingChannel, jsonEncode(following.toJson()));
    } catch (e) {
      rethrow;
    }
  }
}
