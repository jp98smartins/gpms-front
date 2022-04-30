import 'package:flutter/material.dart';

import '../../core/adapters/svg_image_adapter.dart';
import '../../core/theme/app_assets.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
