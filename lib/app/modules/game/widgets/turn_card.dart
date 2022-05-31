import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gpms/app/core/theme/app_colors.dart';

class TurnCard extends StatefulWidget {
  const TurnCard({Key? key}) : super(key: key);

  @override
  State<TurnCard> createState() => _TurnCardState();
}

class _TurnCardState extends State<TurnCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(5)),
      height: Get.width / 12,
      width: Get.width - 10,
      child: const Center(
        child: Text(
          'Vez das brancas',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
