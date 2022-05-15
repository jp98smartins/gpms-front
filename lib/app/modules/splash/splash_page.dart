import 'package:flutter/material.dart';

import '../../core/theme/app_assets.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_fonts.dart';
import '../../core/adapters/svg_image_adapter.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // não consegui usar a merda do tema, trocar quando souber
    const headline1 = TextStyle(
      color: AppColors.foregroundPrimary,
      fontFamily: AppFonts.title,
      fontSize: 96.0,
      fontWeight: FontWeight.w700,
    );

    const button = TextStyle(
      color: AppColors.backgroundSecondary,
      fontFamily: AppFonts.primary,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    );

    var itemsGameMode = <String>['PvP', 'PvE', 'EvE']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();
    var valueGameMode = 'PvP';

    var itemsGameLevel = <String>['Fácil', 'Médio', 'Difícil']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(value: value, child: Text(value));
    }).toList();
    var valueGameLevel = 'Fácil';

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
            const Text(
              'xadrez',
              style: headline1,
            ),
            const SizedBox(height: 10),
            DropdownButton(
              value: valueGameMode,
              items: itemsGameMode,
              onChanged: (String? newValue) {},
            ),
            const SizedBox(height: 10),
            DropdownButton(
              value: valueGameLevel,
              items: itemsGameLevel,
              onChanged: (String? newValue) {},
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                "Iniciar Jogo",
                style: button,
              ),
            )
          ],
        ),
      ),
    );
  }
}
