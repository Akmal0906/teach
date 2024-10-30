import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";


import "../../constants/image_constants.dart";
import "../colors/app_colors.dart";
class ChooseItemWidget extends StatelessWidget {
  const ChooseItemWidget(
      {super.key,
        required this.onTap,
        required this.itemName,
        required this.isSelected,this.borderColor=AppColors.baseGrayScale});

  final VoidCallback onTap;
  final String itemName;
  final bool isSelected;
  final Color borderColor;


  @override
  Widget build(BuildContext context) {
    print("issELCTEDD $isSelected");
    return InkWell(
      highlightColor: AppColors.opacity,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
        decoration: BoxDecoration(
          color:isSelected?  AppColors.baseGrayScale:AppColors.white,
          borderRadius: borderColor==Colors.transparent? null:BorderRadius.circular(12),
          border: Border.all(
            color: isSelected? Colors.transparent:borderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              itemName,
              style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.activeTestButton,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3),
            ),
            Container(
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.white,
                  border: isSelected
                      ? Border.all(width: 5, color: AppColors.baseColor)
                      : Border.all(color: AppColors.color7),
                ))
          ],
        ),
      ),
    );
  }
}

class ChooseWidget extends StatelessWidget {
  const ChooseWidget(
      {super.key,
        required this.onTap,
        required this.itemName,
        required this.labelName,this.isNeedRed=false});

  final VoidCallback onTap;
  final String itemName;
  final String labelName;
   final bool isNeedRed;
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        labelName,
        style:  const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.3,color: AppColors.activeTestButton),
      ),
      const SizedBox(
        height: 10,
      ),
      InkWell(
        highlightColor: AppColors.opacity,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          decoration: BoxDecoration(
            color: AppColors.baseGrayScale,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isNeedRed?Colors.red: Colors.transparent
              //AppColors.testItemBorder,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemName,
                style:  TextStyle(
                    fontSize: 14,color: AppColors.activeTestButton.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.3),
              ),
              SvgPicture.asset(SvgIcons.icDown,color: AppColors.activeTestButton,)
            ],
          ),
        ),
      ),
    ],
  );
}