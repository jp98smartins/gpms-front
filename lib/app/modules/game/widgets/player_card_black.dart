import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpms/app/core/adapters/svg_image_adapter.dart';
import 'package:gpms/app/core/theme/app_assets.dart';
import 'package:gpms/app/core/theme/app_colors.dart';

class PlayerCardBlack extends StatefulWidget {
  const PlayerCardBlack({Key? key}) : super(key: key);

  @override
  State<PlayerCardBlack> createState() => _PlayerCardBlackState();
}

class _PlayerCardBlackState extends State<PlayerCardBlack> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(5)),
      height: Get.width / 8,
      width: Get.width - 10,
      child: Row(
        children: [
          SvgImageAdapter.fromAsset(AppAssets.blackAvatar,
              alignment: Alignment.centerLeft, width: 50),
          Column(
            children: [
              const Text(
                'JOGADOR DE PRETAS',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              Row(
                children: [
                  SvgImageAdapter.fromAsset(AppAssets.whiteQueen,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whiteRook,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whiteRook,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whiteKnight,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whiteKnight,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whiteBishop,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whiteBishop,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whitePawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whitePawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whitePawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whitePawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whitePawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whitePawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whitePawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.whitePawn,
                      alignment: Alignment.centerLeft, width: 20),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
