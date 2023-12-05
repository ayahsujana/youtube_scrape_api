import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_scrape_api/models/video.dart';
import 'package:youtube_scrape_api/youtube_scrape_api.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  YoutubeDataApi youtubeDataApi = YoutubeDataApi();

  Future<List<Video>> getYoutubeSearch({required String query}) async {
    List<Video> video = [];
    emit(SearchLoading());
    final videos = await youtubeDataApi.fetchSearchVideo(query);
    try {
      video.addAll(videos);
      emit(SearchSuccess(video: video));
    } catch (e) {
      emit(SearchFailure(message: e.toString()));
    }
    return video;
  }
}
