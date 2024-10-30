import 'package:flutter/material.dart';

import '../../../../../core/colors/app_colors.dart';
class BottomNavigationButtonWidget extends StatelessWidget {
  const BottomNavigationButtonWidget({super.key, required this.bottomName,required this.onTap,this.boxShadowList,this.topPadding=24});
final VoidCallback onTap;
  final String bottomName;
  final List<BoxShadow>? boxShadowList;
  final double topPadding;

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    decoration: BoxDecoration(color: AppColors.white, boxShadow: boxShadowList),
    child: InkWell(
      highlightColor: AppColors.opacity,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            left: 24, right: 24,
            top: topPadding, bottom: 21
        ),

        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.baseColor),
        child: Text(
          bottomName,
          style: const TextStyle(color: AppColors.white),
        ),
      ),
    ),
  );
}
