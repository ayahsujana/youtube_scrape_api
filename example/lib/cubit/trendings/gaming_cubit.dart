import 'package:skibidiwartube/cubit/trendings/trendings_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:youtube_scrape_api/models/video.dart';
import 'package:youtube_scrape_api/youtube_scrape_api.dart';

class GamingCubit extends Cubit<TrendingsState> {
  GamingCubit() : super(TrendingsInitial());
  List<Video> video = [];
  YoutubeDataApi youtubeDataApi = YoutubeDataApi();

  Future<List<Video>?> getGamingYoutube() async {
    final videos = await youtubeDataApi.fetchTrendingGaming();
    try {
      video.addAll(videos);
      emit(TrendingsSuccess(video: video));
    } catch (e) {
      emit(TrendingsFailure(message: e.toString()));
    }

    return video;
  }
}
