import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';

import '../../core/adapters/svg_image_adapter.dart';
import '../../core/theme/app_assets.dart';
import 'bloc/menu_bloc.dart';
import 'widgets/dropdown_form_field_app.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends State<MenuPage> {
  final MenuBloc bloc = Modular.get();

  var itemsGameMode = <String>['PvP', 'PvE', 'EvE']
      .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(value),
    );
  }).toList();
  String? valueGameMode;

  void changeModeValue(newValue) {
    valueGameMode = newValue;
  }

  var itemsGameLevel = <String>['Fácil', 'Médio', 'Difícil']
      .map<DropdownMenuItem<String>>((String value) {
    return DropdownMenuItem<String>(value: value, child: Text(value));
  }).toList();
  String? valueGameLevel;

  void changeGameValue(newValue) {
    valueGameLevel = newValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgImageAdapter.fromAsset(
              AppAssets.whiteIcon,
              key: const Key("AppIcon"),
              width: 175.0,
              semantics: "Icone do Aplicativo",
            ),
            Text(
              'xadrez',
              style: Theme.of(context).textTheme.headline1,
            ),
            const SizedBox(height: 10),
            DropdownFormFieldApp(
              label: "Modo de Jogo",
              value: valueGameMode,
              items: itemsGameMode,
              changeValue: (newValue) => changeModeValue(newValue),
            ),
            const SizedBox(height: 10),
            DropdownFormFieldApp(
              label: "Nível do Jogo",
              value: valueGameLevel,
              items: itemsGameLevel,
              changeValue: (newValue) => changeGameValue(newValue),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print(valueGameLevel);
                print(valueGameMode);
              },
              child: const Text(
                "Iniciar Jogo",
              ),
            )
          ],
        ),
      ),
    );
  }
}
