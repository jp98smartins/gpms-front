import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpms/app/core/adapters/svg_image_adapter.dart';
import 'package:gpms/app/core/theme/app_assets.dart';
import 'package:gpms/app/core/theme/app_colors.dart';

class PlayerCardWhite extends StatefulWidget {
  const PlayerCardWhite({Key? key}) : super(key: key);

  @override
  State<PlayerCardWhite> createState() => _PlayerCardWhiteState();
}

class _PlayerCardWhiteState extends State<PlayerCardWhite> {
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
          SvgImageAdapter.fromAsset(AppAssets.whiteAvatar,
              alignment: Alignment.centerLeft, width: 50),
          Column(
            children: [
              const Text(
                'JOGADOR DE BRANCAS',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  SvgImageAdapter.fromAsset(AppAssets.blackQueen,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackRook,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackRook,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackKnight,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackKnight,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackBishop,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackBishop,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackPawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackPawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackPawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackPawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackPawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackPawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackPawn,
                      alignment: Alignment.centerLeft, width: 20),
                  SvgImageAdapter.fromAsset(AppAssets.blackPawn,
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
