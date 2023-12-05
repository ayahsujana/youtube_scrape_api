import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:youtube_scrape_api/models/channel_data.dart';
import 'package:youtube_scrape_api/youtube_scrape_api.dart';

part 'channels_state.dart';

class ChannelsCubit extends Cubit<ChannelsState> {
  ChannelsCubit() : super(ChannelsInitial());

  YoutubeDataApi youtubeDataApi = YoutubeDataApi();
  ChannelData? channel;

  Future<ChannelData?> getChannelVideos({required String channelId}) async {
    emit(ChannelsLoading());
    final channelData = await youtubeDataApi.fetchChannelData(channelId);
    try {
      channel = channelData;
      emit(ChannelsSuccess(channel: channel));
    } catch (e) {
      emit(ChannelsFailure(message: e.toString()));
    }
    return channel;
  }
}
