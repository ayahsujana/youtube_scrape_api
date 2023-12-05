import 'dart:convert';

import 'package:skibidiwartube/data/models/history_video.dart';
import 'package:skibidiwartube/data/models/video_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

const videohHistory = 'videoHistory';

class HistoryVideoCubit extends Cubit<List<VideoModel?>> {
  HistoryVideoCubit() : super(<VideoModel?>[]);

  WatchHistory history = WatchHistory();
  bool hasWatched(VideoModel? anime) => history.contains(anime);

  void fetchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    String? historyString = prefs.getString(videohHistory);
    if (historyString != null) {
      history = WatchHistory.fromJson(jsonDecode(historyString));
    }
    emit(history.list);
  }

  void addToHistory(VideoModel anime) async {
    final prefs = await SharedPreferences.getInstance();
    history.add(anime);
    prefs.setString(videohHistory, jsonEncode(history.toJson()));
    fetchHistory();
    emit(history.list);
  }

  void clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(videohHistory);
  }
}
