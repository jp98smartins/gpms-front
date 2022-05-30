import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BoardPositionTile extends StatelessWidget {
  const BoardPositionTile({
    Key? key,
    required this.color,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      width: Get.width / 9.5,
      height: Get.width / 9.5,
      child: child,
    );
  }
}
