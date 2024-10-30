import 'package:flutter/material.dart';
import 'package:teach/features/auth/data/model/userType_model.dart';

import 'bottom_sheet_widget.dart';

Future<void> showModalMottomSheet(
    List<UserTypeModel> list, VoidCallback onTap, String menuName,BuildContext context) async {
  final double itemLength =
      (MediaQuery.sizeOf(context).height * 0.35 - 72) + list.length * 72;

  final size = MediaQuery.sizeOf(context);
  await showModalBottomSheet(
      context: context,
      showDragHandle: false,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: false,
      builder: (BuildContext context) {
        print('');
        return BottomSheeWidget(
          regionsModel:list,
          menuName: menuName,
          height: size.height <= itemLength ? size.height - 100 : itemLength,
          onTap: () {
            onTap();
          }, selectedName: "",
        );
      });
}