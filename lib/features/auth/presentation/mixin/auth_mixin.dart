import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:teach/features/auth/data/model/userType_model.dart";

import "../../../../constants/image_constants.dart";
import "../../../../core/custom_snackbar/custom_snack_bar.dart";
import "../../../../core/custom_snackbar/top_snack_bar.dart";
import "../../../../router/app_routes.dart";
import "../bloc/auth_bloc.dart";
import "../pages/auth_page.dart";

mixin AuthMixin on State<AuthPage> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode userNameFocus;
  late FocusNode passwordFocus;
  late List<UserTypeModel> userTypeList;
  String userType='User Type';

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  void initControllers() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    passwordFocus = FocusNode();
    userTypeList = [
      UserTypeModel(id: 1, name: "Student"),
      UserTypeModel(id: 2, name: "Teacher"),
    ];
    userNameFocus = FocusNode();
  }

  Future<void> pageMovement(AuthState state) async {
    if (state.status == LoginStatus.success) {
      context.goNamed(Routes.explore);
      await localSource.setHasProfile(value: true);
    } else if (state.status == LoginStatus.error) {
      showTopSnackBar(
        Overlay.of(context),
        CustomSnackBar.error(
          icon: SvgPicture.asset(SvgIcons.icClose, color: Colors.red),
          message: state.result ?? "",
        ),
      );
    }
  }

  void disposeControllers() {
    emailController.dispose();
    passwordController.dispose();
    passwordFocus.dispose();
    userNameFocus.dispose();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}
