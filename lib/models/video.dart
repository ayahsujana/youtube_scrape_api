import 'package:youtube_scrape_api/models/thumbnail.dart';

class Video {
  ///Youtube video id
  String? videoId;

  ///Youtube video duration
  String? duration;

  ///Youtube video title
  String? title;

  ///Youtube video channel name
  String? channelName;

  ///Youtube video views
  String? views;

  ///Youtube video upload date
  String? uploadDate;

  ///Youtube video thumbnail
  List<Thumbnail>? thumbnails;

  Video(
      {this.videoId,
      this.duration,
      this.title,
      this.channelName,
      this.views,
      this.uploadDate,
      this.thumbnails});

  factory Video.fromMap(Map<String, dynamic>? map) {
    List<Thumbnail>? thumbnails;
    if (map?.containsKey("richItemRenderer") ?? false) {
      //video channel
      var uploadDate = map?['richItemRenderer']['content']['videoRenderer']
          ['publishedTimeText']['simpleText'];
      var lengthText =
          map?['richItemRenderer']['content']['videoRenderer']?['lengthText'];
      thumbnails = [];
      map?['richItemRenderer']['content']['videoRenderer']['thumbnail']
              ['thumbnails']
          .forEach((thumbnail) {
        thumbnails!.add(Thumbnail(
            url: thumbnail['url'],
            width: thumbnail['width'],
            height: thumbnail['height']));
      });
      // var viewtext = map?['richItemRenderer']?['content']?['videoRenderer']?['shortViewCountText']['runs'];
      String? uploadDates;
      if (uploadDate != null) {
        uploadDates = uploadDate;
      } else {
        uploadDates = '';
      }
      return Video(
          videoId: map?['richItemRenderer']['content']['videoRenderer']
              ?['videoId'],
          duration: lengthText?['simpleText'],
          title: map?['richItemRenderer']['content']['videoRenderer']?['title']
              ?['runs']?[0]?['text'],
          channelName: '',
          thumbnails: thumbnails,
          views: map?['richItemRenderer']?['content']?['videoRenderer']
              ?['shortViewCountText']?['simpleText'],
          uploadDate: uploadDates);
    } else if (map?.containsKey("videoRenderer") ?? false) {
      //Trending and search videos
      var uploadDate = map?['videoRenderer']?['publishedTimeText'];
      var lengthText = map?['videoRenderer']?['lengthText'];
      var simpleText =
          map?['videoRenderer']?['shortViewCountText']?['simpleText'];
      thumbnails = [];
      map?['videoRenderer']['thumbnail']['thumbnails'].forEach((thumbnail) {
        thumbnails!.add(Thumbnail(
            url: thumbnail['url'],
            width: thumbnail['width'],
            height: thumbnail['height']));
      });
      String? uploadDates;
      if (uploadDate != null) {
        uploadDates = uploadDate?['simpleText'];
      } else {
        uploadDates = '';
      }
      return Video(
          videoId: map?['videoRenderer']?['videoId'],
          duration: (lengthText == null) ? 'LIVE' : lengthText?['simpleText'],
          title: map?['videoRenderer']?['title']?['runs']?[0]?['text'],
          channelName: map?['videoRenderer']['longBylineText']['runs'][0]
              ['text'],
          thumbnails: thumbnails,
          views: (lengthText == null)
              ? "Views ${map!['videoRenderer']['viewCountText']['runs'][0]['text']}"
              : simpleText,
          uploadDate: uploadDates);
    } else if (map?.containsKey("compactVideoRenderer") ?? false) {
      //Related videos
      var uploadDate = map?['compactVideoRenderer']['publishedTimeText'];
      thumbnails = [];
      map?['compactVideoRenderer']['thumbnail']['thumbnails']
          .forEach((thumbnail) {
        thumbnails!.add(Thumbnail(
            url: thumbnail['url'],
            width: thumbnail['width'],
            height: thumbnail['height']));
      });
      var lengthText = map?['compactVideoRenderer']?['lengthText'];
      var viewtext =
          map?['compactVideoRenderer']?['shortViewCountText']['runs'];
      String? viewers;
      String? uploadDates;
      if (uploadDate != null) {
        uploadDates = uploadDate?['simpleText'];
        print('PUBLISH OK ==>> $uploadDates');
      } else {
        uploadDates = '';
        print('PUBLISH NO ===>> $uploadDates');
      }
      if (viewtext != null) {
        viewers = viewtext?[0]['text'];
      } else {
        viewers =
            map?['compactVideoRenderer']?['shortViewCountText']?['simpleText'];
      }
      return Video(
          videoId: map?['compactVideoRenderer']['videoId'],
          title: map?['compactVideoRenderer']?['title']?['simpleText'],
          duration: (lengthText == null) ? 'LIVE' : lengthText?['simpleText'],
          thumbnails: thumbnails,
          channelName: map?['compactVideoRenderer']?['shortBylineText']?['runs']
              ?[0]?['text'],
          views: viewers,
          uploadDate: uploadDates);
    } else if (map?.containsKey("gridVideoRenderer") ?? false) {
      String? simpleText =
          map?['gridVideoRenderer']['shortViewCountText']?['simpleText'];
      thumbnails = [];
      map?['gridVideoRenderer']['thumbnail']['thumbnails'].forEach((thumbnail) {
        thumbnails!.add(Thumbnail(
            url: thumbnail['url'],
            width: thumbnail['width'],
            height: thumbnail['height']));
      });
      return Video(
          videoId: map?['gridVideoRenderer']['videoId'],
          title: map?['gridVideoRenderer']['title']['runs'][0]['text'],
          duration: map?['gridVideoRenderer']['thumbnailOverlays'][0]
              ['thumbnailOverlayTimeStatusRenderer']['text']['simpleText'],
          thumbnails: thumbnails,
          views: (simpleText != null) ? simpleText : "???");
    }
    return Video();
  }

  Map<String, dynamic> toJson() {
    return {
      "videoId": videoId,
      "duration": duration,
      "title": title,
      "channelName": channelName,
      "views": views
    };
  }
}
