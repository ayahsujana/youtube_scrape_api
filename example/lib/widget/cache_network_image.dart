import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget coverSlider(String id) {
  return Padding(
    padding: const EdgeInsets.all(0.0),
    child: Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          image: DecorationImage(
              image:
                  NetworkImage('https://img.youtube.com/vi/$id/0.jpg'),
              fit: BoxFit.cover)),
    ),
  );
}

Widget coverImage(String id) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10.0),
    child: CachedNetworkImage(
        height: 95,
        width: 180,
        fit: BoxFit.cover,
        color: Colors.black87,
        colorBlendMode: BlendMode.difference,
        imageUrl: 'https://img.youtube.com/vi/$id/0.jpg',
        placeholder: (context, url) => Center(
              child: Image.asset(
                'assets/images/loading.gif',
                height: 95,
                width: 180,
                fit: BoxFit.cover,
              ),
            ),
        errorWidget: (context, url, error) {
          return Center(
            child: Image.network(
              'assets/images/img_not_found.jpg',
              height: 95,
              width: 180,
              fit: BoxFit.cover,
            ),
          );
        }),
  );
}

Widget coverTrending(String id) {
  return ClipRRect(
    borderRadius: const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
    child: CachedNetworkImage(
        width: double.infinity,
        height: 175,
        fit: BoxFit.cover,
        color: Colors.black87,
        colorBlendMode: BlendMode.difference,
        imageUrl: 'https://img.youtube.com/vi/$id/0.jpg',
        placeholder: (context, url) => Center(
              child: Image.asset(
                'assets/images/loading.gif',
                width: double.infinity,
                height: 175,
                fit: BoxFit.cover,
              ),
            ),
        errorWidget: (context, url, error) {
          return Center(
            child: Image.network(
              'assets/images/img_not_found.jpg',
              width: double.infinity,
              height: 175,
              fit: BoxFit.cover,
            ),
          );
        }),
  );
}
