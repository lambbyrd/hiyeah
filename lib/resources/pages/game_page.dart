import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class GamePage extends NyStatefulWidget {

  static RouteView path = ("/game", (_) => GamePage());
  
  GamePage({super.key}) : super(child: () => _GamePageState());
}

class _GamePageState extends NyPage<GamePage> {

  @override
  get init => () {

  };

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game")
      ),
      body: SafeArea(
         child: Container(),
      ),
    );
  }
}
