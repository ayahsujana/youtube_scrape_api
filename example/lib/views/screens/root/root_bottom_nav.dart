import 'package:flutter/cupertino.dart';
import 'package:skibidiwartube/cubit/favorite/favorite_videos.dart';
import 'package:skibidiwartube/cubit/following/following_channel.dart';
import 'package:skibidiwartube/utils/constants/app_info.dart';
import 'package:skibidiwartube/utils/ext/build_context_extension.dart';
import 'package:skibidiwartube/views/screens/FollowHistory/followistory.dart';
import 'package:skibidiwartube/views/screens/favourites/favorite.dart';
import 'package:skibidiwartube/views/screens/search/search_screen.dart';
import 'package:skibidiwartube/views/screens/trendings/trendings.dart';
import 'package:skibidiwartube/widget/android_navigation.dart';
import 'package:skibidiwartube/widget/annotate.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:skibidiwartube/widget/screen_custom.dart';

import '../settings/settings.dart';

class RootBottomNav extends StatefulWidget {
  const RootBottomNav({super.key});

  @override
  State<RootBottomNav> createState() => _RootBottomNavState();
}

class _RootBottomNavState extends State<RootBottomNav> {
  int selectedIndex = 0;
  bool isPaused = false;

  updateIndex(int newIndex) {
    selectedIndex = newIndex;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    context.read<FavoriteVideoCubit>().fetchFavorite();
    context.read<FollowingCubit>().getAllFollowing();
    Screen.setPortrait();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showExitDialog(),
      child: KhmertracksAnnotatedRegionWidget(
        child: ScreenTypeLayout.builder(
          mobile: (context) => DefaultTabController(
            length: 3,
            initialIndex: selectedIndex,
            child: Scaffold(
              appBar: context.materialYouAppBar(appName,
                  actions: [
                    IconButton(
                      onPressed: () =>
                          showSearch(context: context, delegate: DataSearch()),
                      icon: const Icon(FluentIcons.search_24_regular),
                    ),
                    IconButton(
                      onPressed: () => Get.to(Settings()),
                      icon: const Icon(FluentIcons.settings_24_regular),
                    ),
                  ],
                  leadingWidget: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset('assets/icons/logo.png')),
                  )),
              body: IndexedStack(
                index: selectedIndex,
                children: [
                  TrendingsScreen(),
                  FavoriteScreen(),
                  FollowingScreen(),
                ],
              ),
              bottomNavigationBar: AndroidNavigation(
                currentIndex: selectedIndex,
                updateIndex: updateIndex,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitDialog() async {
    final shouldPop = await showDialog(
      barrierDismissible: false,
      context: context,
      barrierColor: Colors.black26,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            'Rate our App',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          content: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                'If you love our app, please take a moment to rate it in the Play Store.',
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(
                "RATE",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                "CANCEL",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                "EXIT",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
    return shouldPop;
  }
}
