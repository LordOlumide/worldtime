import "package:flutter/material.dart";
import "package:world_time/services/world_time.dart";
import "package:world_time/pages/choose_location.dart";
import "package:world_time/services/get_location.dart";

// to work with the getLocation function
Map searchMap = {...LocationGetter.searchMap};
List<String> locations = [...searchMap.keys];
List<String> urls = [...searchMap.values];

class CustomSearchDelegate extends SearchDelegate {
  // List<String> searchTerms = [...locations];
  // List<String> searchUrls = [...urls];

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {query = "";},
        icon: Icon(Icons.clear),
      ),
    ];
  }
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (String location in locations) {
      if (location.toLowerCase().contains(query.toLowerCase()))
        {matchQuery.add(location);}
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        String result = matchQuery[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Card(
            child: ListTile(
              onTap: () async {
                // get the worldtime object and pop screen
                WorldTime choice = WorldTime(location: result, url: searchMap[result]!, flag: "flag.png");
                await choice.getTime();
                popScreen(context: context, instance: choice);
              },
              title: Text(
                result,
                style: const TextStyle(
                  fontSize: 24,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (String location in locations) {
      if (location.toLowerCase().contains(query.toLowerCase()))
        matchQuery.add(location);
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          onTap: () async {
            // get the worldtime object and pop screen
            WorldTime choice = WorldTime(location: result, url: searchMap[result]!, flag: "flag.png");
            await choice.getTime();
            popScreen(context: context, instance: choice);
          },
          title: Text(result),
        );
      },
    );
  }
}


// class SearchPlaces extends StatefulWidget {
//   const SearchPlaces({Key? key}) : super(key: key);
//   @override
//   _SearchPlacesState createState() => _SearchPlacesState();
// }
// class _SearchPlacesState extends State<SearchPlaces> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () {
//               showSearch(
//                 context: context,
//                 delegate: CustomSearchDelegate(),
//               );
//             },
//             icon: Icon(Icons.search_outlined),
//           ),
//         ],
//       ),
//     );
//   }
// }