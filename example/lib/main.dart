import 'package:skibidiwartube/app.dart';
import 'package:skibidiwartube/cubit/category/category_cubit.dart';
import 'package:skibidiwartube/cubit/channels/channels_cubit.dart';
import 'package:skibidiwartube/cubit/detail/detail_cubit.dart';
import 'package:skibidiwartube/cubit/favorite/favorite_videos.dart';
import 'package:skibidiwartube/cubit/following/following_channel.dart';
import 'package:skibidiwartube/cubit/history/history_videos.dart';
import 'package:skibidiwartube/cubit/search/search_cubit.dart';
import 'package:skibidiwartube/cubit/trendings/gaming_cubit.dart';
import 'package:skibidiwartube/cubit/trendings/movies_cubit.dart';
import 'package:skibidiwartube/cubit/trendings/music_cubit.dart';
import 'package:skibidiwartube/cubit/trendings/trendings_cubit.dart';
import 'package:skibidiwartube/utils/locator/setup_locator.dart';
import 'package:flutter/material.dart';

import 'package:skibidiwartube/data/enum/box_types.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

final getIt = GetIt.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  final Box<dynamic> settings =
      getIt.get<Box<dynamic>>(instanceName: BoxType.settings.name);
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => FavoriteVideoCubit()),
      BlocProvider(create: (context) => FollowingCubit()),
      BlocProvider(create: (context) => HistoryVideoCubit()),
      BlocProvider(create: (context) => TrendingsCubit()),
      BlocProvider(create: (context) => MusicCubit()),
      BlocProvider(create: (context) => MoviesCubit()),
      BlocProvider(create: (context) => GamingCubit()),
      BlocProvider(create: (context) => ChannelsCubit()),
      BlocProvider(create: (context) => SearchCubit()),
      BlocProvider(create: (context) => DetailCubit()),
      BlocProvider(create: (context) => CategoryCubit()),
    ],
    child: MyApp(settings: settings),
  ));
}
