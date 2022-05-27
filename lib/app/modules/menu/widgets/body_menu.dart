import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:get/get.dart';

import '../../../core/adapters/svg_image_adapter.dart';
import '../../../core/theme/app_assets.dart';
import '../menu_controller.dart';
import 'form_menu.dart';

class BodyMenu extends StatelessWidget {
  BodyMenu({Key? key}) : super(key: key);

  final controller = Modular.get<MenuController>();

  @override
  Widget build(BuildContext context) {
    if (controller.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgImageAdapter.fromAsset(
          AppAssets.whiteIcon,
          key: const Key("AppIcon"),
          width: 175.0,
          semantics: "Icone do Aplicativo",
        ),
        Text('xadrez', style: Theme.of(context).textTheme.headline1),
        const SizedBox(height: 10),
        FormMenu(onSubmit: (configData) => controller.saveConfigs(configData))
      ],
    );
  }
}
