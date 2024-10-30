import "package:flutter/material.dart";

import "../colors/app_colors.dart";

/// Popup widget that you can use by default to show some information
class CustomSnackBar extends StatefulWidget {
  const CustomSnackBar.success({
    Key? key,
    required this.message,
    this.type = false,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.icon = const Icon(
      Icons.ac_unit,
      color: Color(0x15000000),
      size: 24,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.black,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = AppColors.white,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  const CustomSnackBar.info({
    Key? key,
    this.type = false,
    required this.message,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.icon = const Icon(
      Icons.sentiment_neutral,
      color: Color(0x15000000),
      size: 24,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.black,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = const Color(0xff2196F3),
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  const CustomSnackBar.error({
    Key? key,
    required this.message,
    this.type = false,
    this.messagePadding = const EdgeInsets.symmetric(horizontal: 24),
    this.icon = const Icon(
      Icons.error_outline,
      color: Color(0x15000000),
      size: 24,
    ),
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.black,
    ),
    this.maxLines = 2,
    this.iconRotationAngle = 32,
    this.iconPositionTop = -10,
    this.iconPositionLeft = -8,
    this.backgroundColor = Colors.white,
    this.boxShadow = kDefaultBoxShadow,
    this.borderRadius = kDefaultBorderRadius,
    this.textScaleFactor = 1.0,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  final String message;
  final Widget icon;
  final Color backgroundColor;
  final TextStyle textStyle;
  final int maxLines;
  final bool type;
  final int iconRotationAngle;
  final List<BoxShadow> boxShadow;
  final BorderRadius borderRadius;
  final double iconPositionTop;
  final double iconPositionLeft;
  final EdgeInsetsGeometry messagePadding;
  final double textScaleFactor;
  final TextAlign textAlign;

  @override
  CustomSnackBarState createState() => CustomSnackBarState();
}

class CustomSnackBarState extends State<CustomSnackBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 60,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: widget.borderRadius,
        boxShadow: widget.boxShadow,
      ),
      width: double.infinity,
      child: Row(
        children: [
          // SizedBox(
          //   height: 40,
          //   width: 40,
          //   child: widget.icon,
          // ),
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: widget.type
                    ? const Color(0xff26BD6C).withOpacity(0.15)
                    : const Color(0xffE6483D).withOpacity(0.15),
                borderRadius: BorderRadius.circular(12)),
            child: widget.icon,
          ),
          Center(
            child: SizedBox(
              width: 250,
              child: Text(
                widget.message,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: const TextStyle(
                    decoration: TextDecoration.none,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const kDefaultBoxShadow = [
  BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 8),
    spreadRadius: 1,
    blurRadius: 30,
  ),
];

const kDefaultBorderRadius = BorderRadius.all(Radius.circular(12));
