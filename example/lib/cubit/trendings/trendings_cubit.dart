import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_scrape_api/models/video.dart';
import 'package:youtube_scrape_api/youtube_scrape_api.dart';

part 'trendings_state.dart';

class TrendingsCubit extends Cubit<TrendingsState> {
  TrendingsCubit() : super(TrendingsInitial());
  List<Video> video = [];
  YoutubeDataApi youtubeDataApi = YoutubeDataApi();

  Future<List<Video>?> getTrendingYoutube() async {
    final videos = await youtubeDataApi.fetchTrendingVideo();
    try {
      video.addAll(videos);
      emit(TrendingsSuccess(video: video));
    } catch (e) {
      emit(TrendingsFailure(message: e.toString()));
    }

    return video;
  }
}
