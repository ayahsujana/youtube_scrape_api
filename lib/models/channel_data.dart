import 'package:youtube_scrape_api/helpers/helpers_extention.dart';
import 'package:youtube_scrape_api/models/channel_page.dart';
import 'package:youtube_scrape_api/models/video.dart';

class ChannelData {
  ChannelPage channel;
  List<Video> videosList;

  ChannelData({required this.channel, required this.videosList});

  factory ChannelData.fromMap(Map<String, dynamic> map) {
    var headers = map.get('header');
    var metaSubs = headers
        ?.get('pageHeaderRenderer')
        ?.get('content')
        ?.get('pageHeaderViewModel')
        ?.get('metadata')
        ?.get('contentMetadataViewModel')
        ?.getList('metadataRows')?[1];
        
    String? subscribers =
        metaSubs?.getList('metadataParts')?[0].get('text')?['content'];

    String? videoCounts =
        metaSubs?.getList('metadataParts')?[1].get('text')?['content'];

    String channelName = headers?.get('pageHeaderRenderer')?['pageTitle'];

    String avatar = headers
        ?.get('pageHeaderRenderer')
        ?.get('content')
        ?.get('pageHeaderViewModel')
        ?.get('image')
        ?.get('decoratedAvatarViewModel')
        ?.get('avatar')
        ?.get('avatarViewModel')
        ?.get('image')
        ?.getList('sources')?.first['url'];

    String? banner = headers
        ?.get('pageHeaderRenderer')
        ?.get('content')
        ?.get('pageHeaderViewModel')
        ?.get('banner')
        ?.get('imageBannerViewModel')
        ?.get('image')
        ?.getList('sources')
        ?.first['url'];

    var contents = map
        .get('contents')
        ?.get('twoColumnBrowseResultsRenderer')
        ?.getList('tabs')?[1]
        .get('tabRenderer')
        ?.get('content')
        ?.get('richGridRenderer')
        ?.getList('contents');
    var contentList = contents!.toList();
    List<Video> videoList = [];
    for (var element in contentList) {
      Video video = Video.fromMap(element);
      videoList.add(video);
    }

    return ChannelData(
        videosList: videoList,
        channel: ChannelPage(
            // ignore: unnecessary_null_comparison
            channelName: (channelName != null) ? channelName : " ",
            subscribers: (subscribers != null) ? subscribers : " ",
            videoCounts: (videoCounts != null) ? videoCounts : " ",
            // ignore: unnecessary_null_comparison
            avatar: (avatar != null) ? avatar : " ",	
            banner: (banner != null) ? banner : " "));
  }
}
