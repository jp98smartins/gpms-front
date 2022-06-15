import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/adapters/svg_image_adapter.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_assets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () => Modular.to.popAndPushNamed(AppRoutes.gameRoute),
    );
    return Scaffold(
      body: Center(
        child: SvgImageAdapter.fromAsset(
          AppAssets.whiteIcon,
          key: const Key("AppIcon"),
          width: 175.0,
          semantics: "Icone do Aplicativo",
        ),
      ),
    );
  }
}
