import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_scrape_api/models/video_data.dart';
import 'package:youtube_scrape_api/youtube_scrape_api.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailInitial());

  YoutubeDataApi youtubeDataApi = YoutubeDataApi();
  VideoData? video;

  Future<VideoData?> getVideoDetail({required String videoId}) async {
    emit(DetailLoading());
    final data = await youtubeDataApi.fetchVideoData(videoId);
    try {
      video = data;
      emit(DetailSuccess(video: video));
    } catch (e) {
      emit(DetailFailure(message: e.toString()));
    }
    return video;
  }
}
