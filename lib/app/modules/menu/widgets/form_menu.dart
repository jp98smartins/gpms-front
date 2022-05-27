import 'package:flutter/material.dart';

import 'dropdown_form_field_app.dart';

class FormMenu extends StatefulWidget {
  const FormMenu({Key? key, required this.onSubmit}) : super(key: key);

  final Future<void> Function(Map<String, String>) onSubmit;

  @override
  State<FormMenu> createState() => _FormMenuState();
}

class _FormMenuState extends State<FormMenu> {
  final _formKey = GlobalKey<FormState>();

  // Game Mode
  String? _gameMode;
  void _changeMode(String mode) => setState(() => _gameMode = mode);
  final _gameModeItems = <Map<String, String>>[
    {"id": "0", "name": "PvP"},
    {"id": "1", "name": "PvE"},
    {"id": "2", "name": "EvE"},
  ];

  // Game Difficulty
  String? _gameDifficulty;
  void _changeDifficulty(String difficulty) => setState(
        () => _gameDifficulty = difficulty,
      );
  final _gameDifficultyItems = <Map<String, String>>[
    {"id": "0", "name": "Fácil"},
    {"id": "1", "name": "Médio"},
    {"id": "2", "name": "Difícil"},
  ];

  void _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      await widget.onSubmit({
        "game_mode": _gameMode.toString(),
        "game_difficulty": _gameDifficulty.toString(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownFormFieldApp(
            label: "Modo de Jogo",
            value: _gameMode,
            items: _gameModeItems
                .map<DropdownMenuItem<String>>(
                  (Map<String, String> oneMode) => DropdownMenuItem<String>(
                    value: oneMode["id"].toString(),
                    child: Text(oneMode["name"].toString()),
                  ),
                )
                .toList(),
            changeValue: (mode) => _changeMode(mode),
          ),
          const SizedBox(height: 10),
          DropdownFormFieldApp(
            label: "Nível do Jogo",
            value: _gameDifficulty,
            items: _gameDifficultyItems
                .map<DropdownMenuItem<String>>(
                  (Map<String, String> oneDifficulty) =>
                      DropdownMenuItem<String>(
                    value: oneDifficulty["id"].toString(),
                    child: Text(oneDifficulty["name"].toString()),
                  ),
                )
                .toList(),
            changeValue: (difficulty) => _changeDifficulty(difficulty),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _onSubmit,
            child: const Text(
              "Iniciar Jogo",
            ),
          ),
        ],
      ),
    );
  }
}
