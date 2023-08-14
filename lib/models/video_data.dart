import 'package:youtube_scrape_api/models/video.dart';
import 'package:youtube_scrape_api/models/video_page.dart';

class VideoData {
  VideoPage? video;
  List<Video> videosList;

  VideoData({this.video, required this.videosList});
}
