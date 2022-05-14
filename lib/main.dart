import 'package:flutter/material.dart';
import "package:world_time/pages/home.dart";
import "package:world_time/pages/choose_location.dart";
import "package:world_time/pages/loading.dart";

// add region separator functionality http://www.worldtimeapi.org/api/timezone/Africa, dropdown list style, expansionTileCard
// add circle avatar functionality

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => const Loading(),
      "/home": (context) => const Home(),
      "/chooseLocation": (context) => const ChooseLocation(),
    },
  ));
}
