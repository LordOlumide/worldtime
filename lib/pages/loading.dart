import 'package:flutter/material.dart';
import "package:world_time/services/world_time.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  String time = "Loading...";

  // function to create a WorldTime instance and set "time"
  void setupWorldTime() async {
    WorldTime instance = await getWorldTimeObjectAfterDelay();
    await instance.getTime();

    // change directory to the home page
    Navigator.pushReplacementNamed(context, "/home", arguments: {
      "location": instance.location,
      "time": instance.time,
      "url": instance.url,
      "flag": instance.flag,
      "isDay": instance.isDay,
      "date": instance.date,
    });
  }

  Future<WorldTime> getWorldTimeObjectAfterDelay () async {
    WorldTime output =  await Future.delayed(const Duration(seconds: 0), ()
    {
      return WorldTime(location: "Lagos, Africa",
          url: "Africa/Lagos",
          flag: "flag.png");
    });
    return output;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: const Center(
        child: SpinKitPouringHourGlass(
          color: Colors.white,
          size: 100.0,
        ),
      )
    );
  }
}
