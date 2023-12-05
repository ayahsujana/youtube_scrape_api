# YouTube Scrape API

Forked from https://github.com/modwedar/YoutubeDataApi

A Flutter package for fetching complete data from YouTube. Supports Search, Trending, Channels, Playlists and Video Data.

## Features

- Search Video, Playlist, Channel on YouTube with (Unlimited Videos With Loading More) feature.
- Get Video Data, Id, Thumbnail, Channel Name, Views, Likes, Description
- Get Related Videos with a video
- Get Playlist Videos with (Loading More) feature
- Get Channel complete data (Name, Id, Banner, Avatar, Videos Count, Subscribers Count, Videos with (Loading More) feature)
- Search Suggestions
- Get Trending Videos based on your ip country (Trending, Music, Gaming, Movies).

## Usage

To use this plugin, add `youtube_scrape_api` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

### Example

[<img src="https://ayahsujana.my.id/uploads/1.jpeg" width=280>](https://ayahsujana.my.id/uploads/1.jpeg)
[<img src="https://ayahsujana.my.id/uploads/2.jpeg" width=280>](https://ayahsujana.my.id/uploads/2.jpeg)
[<img src="https://ayahsujana.my.id/uploads/3.jpeg" width=280>](https://ayahsujana.my.id/uploads/3.jpeg)
[<img src="https://ayahsujana.my.id/uploads/4.jpeg" width=280>](https://ayahsujana.my.id/uploads/4.jpeg)
[<img src="https://ayahsujana.my.id/uploads/5.jpeg" width=280>](https://ayahsujana.my.id/uploads/5.jpeg)

To search for videos or channels or playlists
```dart
String query = "Wegz";
YoutubeDataApi youtubeDataApi = YoutubeDataApi();
List videoResult = await youtubeDataApi.fetchSearchVideo(query);
videoResult.forEach((element){
    if(element is Video){
      Video video = element;
    } else if(element is Channel){
      Channel channel = element;
    } else if(element is PlayList){
      PlayList playList = element;
    }
});
```

To get trending videos
```dart
YoutubeDataApi youtubeDataApi = YoutubeDataApi();
List<Video> videos = await youtubeDataApi.fetchTrendingVideo();
```

To get gaming, music, movies videos on trend
```dart
List<Video> trendingMusicVideos = await youtubeDataApi.fetchTrendingMusic();
List<Video> trendingGamingVideos = await youtubeDataApi.fetchTrendingGaming();
List<Video> trendingMoviesVideos = await youtubeDataApi.fetchTrendingMovies();
```

To get suggestion search queries
```dart
String query = "El Joker";
List<String> suggestions = await youtubeDataApi.fetchSuggestions(query);
```

To get video data
```dart
VideoData? videoData = await youtubeDataApi.fetchVideoData(videoId);
String? videoTitle = videoData?.video?.title;
String? videoChannelName = videoData?.video?.username;
String? viewsCount = videoData?.video?.viewCount;
String? likeCount = videoData?.video?.likeCount;
String? channelThumbnail = videoData?.video?.channelThumb;
String? channelId = videoData?.video?.channelId;
String? subscribeCount = videoData?.video?.subscribeCount;
List<Video?>? relatedVideos = videoData?.videosList;
```



