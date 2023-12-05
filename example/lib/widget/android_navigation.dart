import 'package:skibidiwartube/cubit/favorite/favorite_videos.dart';
import 'package:skibidiwartube/data/models/video_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AndroidNavigation extends StatelessWidget {
  const AndroidNavigation(
      {super.key, required this.currentIndex, required this.updateIndex});
  final int currentIndex;
  final Function updateIndex;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
      child: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) => updateIndex(index),
        destinations: [
          const NavigationDestination(
            label: 'Trending',
            icon: Icon(Icons.trending_up),
            selectedIcon: Icon(Icons.trending_up_outlined),
          ),
          NavigationDestination(
            label: 'Favourite',
            icon: Stack(
              children: [
                const Icon(Icons.bookmark_add),
                Positioned(
                    child: BlocBuilder<FavoriteVideoCubit, List<VideoModel?>>(
                  builder: (context, state) => state.isEmpty
                      ? const SizedBox()
                      : Badge(
                          backgroundColor: Colors.red,
                          label: Text(
                            '${state.length}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          child: const Icon(Icons.bookmark_add),
                        ),
                ))
              ],
            ),
            //selectedIcon: Icon(Icons.bookmark_add_outlined),
          ),
          const NavigationDestination(
            label: 'Followistory',
            icon: Icon(Icons.subscriptions),
            selectedIcon: Icon(Icons.subscriptions_outlined),
          ),
          // NavigationDestination(
          //   label: 'Library',
          //   icon: Icon(FluentIcons.library_16_regular),
          //   selectedIcon: Icon(FluentIcons.library_16_filled),
          // ),
        ],
      ),
    );
  }
}
