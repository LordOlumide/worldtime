import 'package:flutter/material.dart';
import "package:world_time/services/world_time.dart";

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // basic display data map
  Map data = {};

  @override
  Widget build(BuildContext context) {

    // catching arguments thrown from other pages
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;

    // preparations for day/night background changing
    String bgImage = data["isDay"] ? "day.png" : "night.png";
    Color bgColor = data["isDay"] ? Colors.blue : Colors.indigo[700] as Color;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/$bgImage"),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () async {
                    Map results = await Navigator.pushNamed(context, "/chooseLocation") as Map;
                    setState(() {
                      data = {
                        "location": results["location"],
                        "time": results["time"],
                        "url": results["url"],
                        "flag": results["flag"],
                        "isDay": results["isDay"],
                        "date": results["date"],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    "Edit location",
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                 data["location"],
                  style: const TextStyle(
                    fontSize: 32,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  data["date"],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  data["time"],
                  style: const TextStyle(
                    fontSize: 64,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
                IconButton(
                  onPressed: () async {
                    WorldTime instance = WorldTime(location: data["location"], url: data["url"], flag: "flag.png");
                    await instance.getTime();
                    setState(() {
                      data = {
                        "location": instance.location,
                        "time": instance.time,
                        "url": instance.url,
                        "flag": instance.flag,
                        "isDay": instance.isDay,
                        "date": instance.date,
                      };
                    });
                  },
                  padding: const EdgeInsets.all(3),
                  iconSize: 30,
                  color: Colors.grey[300],
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
