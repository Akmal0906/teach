import 'package:flutter/material.dart';
import "package:go_router/go_router.dart";
import 'package:teach/features/auth/data/model/userType_model.dart';
import '../../features/auth/presentation/pages/widgets/bottom_navigation_button_widget.dart';
import '../colors/app_colors.dart';
import 'choose_item_widget.dart';
class BottomSheeWidget extends StatefulWidget {
  const BottomSheeWidget(
      {super.key,
        required this.regionsModel,
        required this.menuName,
        required this.height,required this.selectedName,
        required this.onTap});

  final List<UserTypeModel> regionsModel;
  final String menuName;
  final double height;
  final VoidCallback onTap;
  final String selectedName;

  @override
  State<BottomSheeWidget> createState() => _BottomSheeWidgetState();
}

class _BottomSheeWidgetState extends State<BottomSheeWidget> {
  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    initialChildSize: widget.height / MediaQuery.sizeOf(context).height,
    maxChildSize: widget.height / MediaQuery.sizeOf(context).height,
    minChildSize: widget.height / MediaQuery.sizeOf(context).height,
    expand: false,
    builder: (context, controller) {
      return Container(
        height: widget.height,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        ),
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(left: 24, right: 24, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.menuName,
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                        color: AppColors.activeTestButton),
                  ),
                  IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.close,color: AppColors.activeTestButton,)),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: controller,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                children: [
                  ...List.generate(
                    widget.regionsModel.length,
                        (index) => Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 8),
                      child: ChooseItemWidget(
                        onTap: () {
                          setState(() {
                            if (checkList.contains(true)) {
                              checkList[checkList.indexOf(true)] = false;
                            }

                            checkList[index] = true;
                          });
                        },
                        itemName: widget.regionsModel[index].name,
                        isSelected: checkIsSelected(widget.regionsModel,index,widget.selectedName),
                      ),
                    ),
                  )
                ],
              ),
            ),
            BottomNavigationButtonWidget(
              bottomName: "Apply",
              onTap: widget.onTap,
              topPadding: 16,
            ),
          ],
        ),
      );
    },
  );
}
bool checkIsSelected(List<UserTypeModel> userTypeModel,int index,String selectedName){
  if(checkList.contains(true)){
    return checkList[index];
  }else{
    return userTypeModel[index].name==selectedName;
  }
}

List<bool> checkList=[false,false];