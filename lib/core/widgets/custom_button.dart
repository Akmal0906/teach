// import 'package:flutter/material.dart';
//
// import '../colors/app_colors.dart';
// class CustomButton extends StatelessWidget {
//   const CustomButton({
//     required this.label,
//     super.key,
//     this.onPressed,
//     this.height = 52,
//     this.shadowEnabled = true,
//     this.backgroundColor,
//     this.isActivated = true,
//     this.width = double.infinity,
//     this.borderRadius = const BorderRadius.all(Radius.circular(12)),
//     this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//     this.borderColor,
//     this.borderButton = false
//   });
//
//   final Widget label;
//
//   final VoidCallback? onPressed;
//   final double height;
//   final double width;
//   final bool shadowEnabled;
//   final bool isActivated;
//   final Color? backgroundColor;
//   final Color? borderColor;
//   final BorderRadius borderRadius;
//   final EdgeInsetsGeometry padding;
//   final bool borderButton;
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: isActivated ? onPressed : null,
//       borderRadius: borderRadius,
//       highlightColor: Colors.transparent,
//       splashColor: Colors.transparent,
//       child: DecoratedBox(
//         decoration: const BoxDecoration(
//           color: Colors.transparent,
//         ),
//         child: Container(
//           margin: const EdgeInsets.all(7),
//           height: height,
//           width: width,
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             borderRadius: borderRadius,
//             color: isActivated ? backgroundColor ?? AppColors.baseColor : const Color(0xff0B0C0E).withOpacity(0.1),
//             border: borderButton ? Border.all(color: borderColor ?? const Color(0xffE2E8F0)) : null,
//             boxShadow: [
//               if (shadowEnabled) BoxShadow(
//                 color: Colors.grey.withOpacity(0.3), // Shadow color
//                 spreadRadius: 5, // Spread radius
//                 blurRadius: 10, // Blur radius
//                 offset: const Offset(0, 3), // Offset
//               ),
//             ],
//           ),
//
//           padding: padding,
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//                Text("user")
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
// }
