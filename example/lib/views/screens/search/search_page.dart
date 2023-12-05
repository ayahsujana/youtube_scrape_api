// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youtube_scrape_api/models/video.dart';

import 'package:skibidiwartube/cubit/search/search_cubit.dart';
import 'package:skibidiwartube/utils/resources/suggestion.dart';
import 'package:skibidiwartube/views/pages/content_list_page.dart';
import 'package:skibidiwartube/views/screens/details/detail_screen.dart';
import 'package:skibidiwartube/widget/loading.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
    required this.query,
  }) : super(key: key);
  final String query;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Video> videos = [];
  bool isLoading = false;
  bool firstLoad = true;
  final searchCubit = SearchCubit();
  //String API_KEY = "AIzaSyCLLLyifMf-xaDD6P9bBIF5hO2HK3nZw7k";
  String query = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      query = widget.query.replaceAll(' ', '+');
    });
    context.read<SearchCubit>().getYoutubeSearch(query: query);
    SuggestionHistory.init();
    SuggestionHistory.store(widget.query);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchSuccess) {
                return ListView.builder(
                  itemCount: state.video.length,
                  itemBuilder: (context, index) {
                    videos = state.video;
                    return video(videos[index]);
                  },
                );
              } else if (state is SearchFailure) {
                return const Center(
                  child: Text(
                      "We're sorry, we can't find anything\nthat matches your search",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15)),
                );
              } else if (state is SearchLoading) {
                return const Center(
                  child: Loading(),
                );
              }
              return const Center(
                child: Loading(),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget video(Video videos) {
    return InkWell(
      onTap: () => Get.to(
        DetailScreen(
          videoId: videos.videoId!,
          duration: videos.duration!,
          viewer: videos.uploadDate!.isEmpty,
        ),
      ),
      child: ContentVideos(videos: videos),
    );
  }
}
