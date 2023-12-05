import 'package:skibidiwartube/utils/constants/constants.dart';
import 'package:skibidiwartube/views/screens/FollowHistory/following_channel.dart';
import 'package:skibidiwartube/views/screens/history/history.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FollowingScreen extends StatefulWidget {
  const FollowingScreen({super.key});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 16),
            child: Row(
              children: [
                Icon(
                  Icons.history,
                  color: Color(defaultColor),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  'History',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(defaultColor)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 145,
            width: MediaQuery.of(context).size.width,
            child: const HistoryScreen(),
          ),
          const Divider(
            thickness: 2,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, bottom: 16),
            child: Row(
              children: [
                Icon(
                  MdiIcons.account,
                  color: Color(defaultColor),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Channels',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(defaultColor),
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: FollowingChannel(),
          ),
        ],
      ),
    );
  }
}
