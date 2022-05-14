import 'package:flutter/material.dart';
import "package:world_time/services/get_location.dart";
import "package:world_time/services/world_time.dart";


void popScreen ({required context, required instance}) {
  Navigator.pop(context, {
    "location": instance.location,
    "time": instance.time,
    "url": instance.url,
    "flag": instance.flag,
    "isDay": instance.isDay,
    "date": instance.date,
  });
}

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({Key? key}) : super(key: key);

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  @override
  Widget build(BuildContext context) {

    // to work with the getLocation function
    List<String> locations = LocationGetter.locations;
    List<String> urls = LocationGetter.urlEndpoints;

    Future<WorldTime> getLocation (index) async {
      WorldTime instance = WorldTime(location: locations[index], url: urls[index], flag: "flag.png");
      await instance.getTime();
      return instance;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Choose your Location",
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[900],
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
            icon: Icon(Icons.search_outlined),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: Card(
              child: ListTile(
                onTap: () async {
                  // get location and pop screen
                  WorldTime result = await getLocation(index);
                  popScreen(context: context, instance: result);
                },
                title: Text(
                  locations[index],
                  style: const TextStyle(
                    fontSize: 24,
                    letterSpacing: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Incomplete: should show country flags
                // leading: CircleAvatar(
                //   backgroundImage: AssetImage("assets/"), // flags
                // ),

              ),
            ),
          );
        },
      ),
    );
  }
}



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
    List<String> matchQuery = locations.where(
      (location) => location.toLowerCase().startsWith(query.toLowerCase())).toList();
    // for (String location in locations) {
    //   if (location.toLowerCase().contains(query.toLowerCase()))
    //   {matchQuery.add(location);}
    // }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        String result = matchQuery[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Card(
            child: ListTile(
              onTap: () {
                // get the worldtime object and pop screen
                WorldTime choice = WorldTime(location: result, url: searchMap[result]!, flag: "flag.png");
                close(context, choice);
              },
              title: Card(
                child: Text(
                  matchQuery[index],
                ),
                color: Colors.lightBlueAccent,
              )
            ),
          ),
        );
      },
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = locations.where(
            (location) => location.toLowerCase().startsWith(query.toLowerCase())).toList();
    // for (String location in locations) {
    //   if (location.toLowerCase().contains(query.toLowerCase()))
    //   {matchQuery.add(location);}
    // }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        String result = matchQuery[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: ListTile(
            onTap: () {
              // get the worldtime object and pop screen
              WorldTime choice = WorldTime(location: result, url: searchMap[result]!, flag: "flag.png");
              close(context, choice);
            },
            title: RichText(
              text: TextSpan(
                text: matchQuery[index].substring(0, query.length),
                style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: matchQuery[index].substring(query.length),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
