import 'package:skibidiwartube/cubit/trendings/gaming_cubit.dart';
import 'package:skibidiwartube/cubit/trendings/movies_cubit.dart';
import 'package:skibidiwartube/cubit/trendings/music_cubit.dart';
import 'package:skibidiwartube/cubit/trendings/trendings_cubit.dart';
import 'package:skibidiwartube/views/screens/trendings/content_page.dart';
import 'package:skibidiwartube/widget/loading.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class TrendingsScreen extends StatelessWidget {
  const TrendingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocProvider.value(
              value: context.read<TrendingsCubit>()..getTrendingYoutube(),
              child:
                  const TrendingsContentsVideos(category: '::Trending Today')),
          BlocProvider.value(
              value: context.read<MusicCubit>()..getMusicYoutube(),
              child: const MusicContentsVideos(category: '::Music')),
          BlocProvider.value(
              value: context.read<MoviesCubit>()..getMoviesYoutube(),
              child: const MoviesContentsVideos(category: '::Movies Thrailer')),
          BlocProvider.value(
              value: context.read<GamingCubit>()..getGamingYoutube(),
              child: const GamingContentsVideos(category: '::Gaming')),
        ],
      ),
    );
  }
}

class TrendingsContentsVideos extends StatelessWidget {
  const TrendingsContentsVideos({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              category,
              style: const TextStyle(
                  fontSize: 22,
                  decorationStyle: TextDecorationStyle.solid,
                  fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<TrendingsCubit, TrendingsState>(
            builder: (context, state) {
              if (state is TrendingsSuccess) {
                return SizedBox(
                  height: 175,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.video.length,
                    itemBuilder: (context, index) {
                      final videos = state.video[index];
                      return ContentTrendings(video: videos);
                    },
                  ),
                );
              } else if (state is TrendingsFailure) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const Center(
                child: Loading(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MusicContentsVideos extends StatelessWidget {
  const MusicContentsVideos({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              category,
              style: const TextStyle(
                  fontSize: 22,
                  decorationStyle: TextDecorationStyle.solid,
                  fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<MusicCubit, TrendingsState>(
            builder: (context, state) {
              if (state is TrendingsSuccess) {
                return SizedBox(
                  height: 175,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.video.length,
                    itemBuilder: (context, index) {
                      final videos = state.video[index];
                      return ContentTrendings(video: videos);
                    },
                  ),
                );
              } else if (state is TrendingsFailure) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const Center(
                child: Loading(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MoviesContentsVideos extends StatelessWidget {
  const MoviesContentsVideos({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              category,
              style: const TextStyle(
                  fontSize: 22,
                  decorationStyle: TextDecorationStyle.solid,
                  fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<MoviesCubit, TrendingsState>(
            builder: (context, state) {
              if (state is TrendingsSuccess) {
                return SizedBox(
                  height: 175,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.video.length,
                    itemBuilder: (context, index) {
                      final videos = state.video[index];
                      return ContentTrendings(video: videos);
                    },
                  ),
                );
              } else if (state is TrendingsFailure) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const Center(
                child: Loading(),
              );
            },
          ),
        ],
      ),
    );
  }
}

class GamingContentsVideos extends StatelessWidget {
  const GamingContentsVideos({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              category,
              style: const TextStyle(
                  fontSize: 22,
                  decorationStyle: TextDecorationStyle.solid,
                  fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<GamingCubit, TrendingsState>(
            builder: (context, state) {
              if (state is TrendingsSuccess) {
                return SizedBox(
                  height: 175,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.video.length,
                    itemBuilder: (context, index) {
                      final videos = state.video[index];
                      return ContentTrendings(video: videos);
                    },
                  ),
                );
              } else if (state is TrendingsFailure) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const Center(
                child: Loading(),
              );
            },
          ),
        ],
      ),
    );
  }
}
