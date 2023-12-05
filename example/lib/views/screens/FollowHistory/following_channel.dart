import 'package:skibidiwartube/cubit/following/following_channel.dart';
import 'package:skibidiwartube/data/models/subscribed.dart';
import 'package:skibidiwartube/utils/constants/constants.dart';
import 'package:skibidiwartube/views/screens/channel/channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class FollowingChannel extends StatelessWidget {
  const FollowingChannel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FollowingCubit, List<Subscribed?>>(
      builder: (context, state) {
        if (state.isEmpty) {
          return SizedBox(
            height: Get.height,
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/follow.png',
                  width: 250,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Your channel favourite not found',
                ),
                const Text(
                  'your follow channels will be show in here.',
                ),
              ],
            )),
          );
        } else {
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
            itemCount: state.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Get.to(ChannelScreen(
                  channelId: state[index]!.channelId,
                )),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Color(defaultColor))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(defaultColor),
                        ),
                        child: Container(
                            height: 85,
                            width: 85,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(state[index]!.avatar),
                                    fit: BoxFit.cover))),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Text(
                        state[index]!.username,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
