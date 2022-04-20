import 'package:flutter_modular/flutter_modular.dart';
import 'package:gpms/app/modules/game/bloc/game_bloc.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  GamePageState createState() => GamePageState();
}

class GamePageState extends State<GamePage> {
  final GameBloc bloc = Modular.get();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Game")),
      body: Column(children: const <Widget>[]),
    );
  }
}
