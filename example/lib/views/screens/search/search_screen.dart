import 'package:skibidiwartube/utils/resources/suggestion.dart';
import 'package:skibidiwartube/views/screens/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:youtube_scrape_api/youtube_scrape_api.dart';

class DataSearch extends SearchDelegate<String> {
  final YoutubeDataApi youtubeDataApi = YoutubeDataApi();
  final list = SuggestionHistory.suggestions;

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return SearchPage(query: query);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      List<String> suggestions = list.reversed.toList();
      return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              query = suggestions[index];
              showResults(context);
            },
            child: ListTile(
              leading: const Icon(Icons.north_west),
              title: Text(suggestions[index]),
              trailing: const Icon(Icons.history_outlined),
            ),
          );
        },
        itemCount: suggestions.length,
      );
    }
    return FutureBuilder(
      future: youtubeDataApi.fetchSuggestions(query),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          var snapshots = snapshot.data;
          List<String> suggestions = query.isEmpty ? list : snapshots;
          return ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  list.add(query);
                  query = suggestions[index];
                  showResults(context);
                },
                child: ListTile(
                  leading: const Icon(Icons.north_west),
                  title: Text(suggestions[index]),
                ),
              );
            },
            itemCount: suggestions.length,
          );
        }
        return Container();
      },
    );
  }
}
