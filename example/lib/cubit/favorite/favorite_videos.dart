import 'dart:convert';

import 'package:skibidiwartube/data/models/favorite_video.dart';
import 'package:skibidiwartube/data/models/video_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const favouriteVideo = 'saveGo:FavouriteVideo';

class FavoriteVideoCubit extends Cubit<List<VideoModel?>> {
  FavoriteVideoCubit() : super(<VideoModel?>[]);

  FavoriteVideos favourite = FavoriteVideos();
  bool isFavourite(VideoModel? video) => favourite.contains(video);

  void fetchFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    String? favouriteString = prefs.getString(favouriteVideo);
    if (favouriteString != null) {
      favourite = FavoriteVideos.fromJson(jsonDecode(favouriteString));
    }
    emit(favourite.list);
  }

  void toggleFavorite(VideoModel video) {
    if (isFavourite(video)) {
      favourite.remove(video);
      FavoriteVideoService().setFavorite(favourite);
      emit(favourite.list);
      fetchFavorite();
    } else {
      favourite.add(video);
      FavoriteVideoService().setFavorite(favourite);
      emit(favourite.list);
      fetchFavorite();
    }
  }

  void clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(favouriteVideo);
  }
}

class FavoriteVideoService {
  Future<void> setFavorite(FavoriteVideos favs) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString(favouriteVideo, jsonEncode(favs.toJson()));
    } catch (e) {
      rethrow;
    }
  }
}
