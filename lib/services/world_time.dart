import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time = "";
  String url;
  String flag;
  String date = "";
  bool isDay = true;

  WorldTime({ required this.location, required this.url, required this.flag });

  Future<void> getTime() async {
    Map data = {};

    try {
      // var response = await http.get(Uri.http("https://jsonplaceholder.typicode.com", "/todos/1"));

      // get the time information
      var response = await http.get(Uri.http("www.worldtimeapi.org", "/api/timezone/$url"));
      data = jsonDecode(response.body);

      // // api not working, so replace with map for now
      // Map data = {};
      // await Future.delayed(Duration(seconds: 5
      // ), () {data = {
      //   "abbreviation": "WAT",
      //   "client_ip": "102.89.34.35",
      //   "datetime": "2022-03-25T11:27:32.637569+01:00",
      //   "day_of_week": 5,
      //   "day_of_year": 84,
      //   "dst": false,
      //   "dst_from": null,
      //   "dst_offset": 0,
      //   "dst_until": null,
      //   "raw_offset": 3600,
      //   "timezone": "Africa/Lagos",
      //   "unixtime": 1648204052,
      //   "utc_datetime": "2022-03-25T10:27:32.637569+00:00",
      //   "utc_offset": "+01:00",
      //   "week_number": 12
      // };});

      DateTime now = DateTime.parse(data["datetime"]);

      // correct for the time difference
      int offset = int.parse(data["utc_offset"].substring(1, 3));
      now = now.add(Duration(hours: offset));

      // assign variables
      isDay = (now.hour > 6 && now.hour < 18) ? true : false;
      time = DateFormat.jm().format(now);
      date = DateFormat.MMMMEEEEd().format(now);
    }
    catch (e) {
      // print(e);

      date = "Error: Check your internet connection";
      time = "No Internet";
    }
  }
}
