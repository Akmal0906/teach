import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:teach/features/auth/data/model/user_model.dart';
import 'package:teach/features/auth/presentation/mixin/auth_mixin.dart';
import 'package:teach/service/auth_service.dart';
import '../../../../constants/image_constants.dart';
import '../../../../core/bottom_sheet/bottom_sheet_widget.dart';
import '../../../../core/bottom_sheet/show_modal_bottom_sheet.dart';
import '../../../../core/colors/app_colors.dart';
import '../../../../core/custom_snackbar/custom_snack_bar.dart';
import '../../../../core/custom_snackbar/top_snack_bar.dart';
import '../../../../core/custom_textfield/custom_textfield.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with AuthMixin {
  final _formKey = GlobalKey<FormState>();
  int selectedType = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                  labelText: "User email",
                  hintText: "akmal1@gmail.com",
                  textInputAction: TextInputAction.next,
                  controller: emailController,
                  onChanged: (String value) {},
                  focusNode: userNameFocus,
                  hintStyle: TextStyle(
                      color: AppColors.activeTestButton.withOpacity(0.5)),
                  labelTextStyle: const TextStyle(
                      fontSize: 14,
                      color: AppColors.activeTestButton,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.3),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        // color: Colors.yellow
                        color: AppColors.testItemBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        // color: Colors.deepPurpleAccent
                        color: AppColors.testItemBorder),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                        // color: Colors.deepPurpleAccent
                        color: AppColors.red),
                  ),
                  validator: (String? email) {
                    if (email == null || email.isEmpty) {
                      return "email cannot empty";
                    } else if (!RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                        .hasMatch(email)) {
                      return "email_is_not_valid";
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: "Password",
                hintText: "Password1234",
                textInputAction: TextInputAction.next,
                controller: passwordController,
                onChanged: (String value) {},
                focusNode: passwordFocus,
                hintStyle: TextStyle(
                    color: AppColors.activeTestButton.withOpacity(0.5)),
                labelTextStyle: const TextStyle(
                    fontSize: 14,
                    color: AppColors.activeTestButton,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      // color: Colors.deepPurpleAccent
                      color: AppColors.testItemBorder),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      // color: Colors.yellow
                      color: AppColors.testItemBorder),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                      // color: Colors.deepPurpleAccent
                      color: AppColors.red),
                ),
                validator: (String? password) {
                  if (password == null || password.length < 6) {
                    return "Password Invalid";
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                highlightColor: AppColors.opacity,
                splashColor: AppColors.opacity,
                onTap: () async {
                  await showModalMottomSheet(
                    userTypeList,
                    () async {
                      context.pop(context);

                      if (checkList.contains(true)) {
                        setState(() {
                          userType = userTypeList[checkList.indexOf(true)].name;
                          checkList[checkList.indexOf(true)] = false;
                        });
                      }
                    },
                    'User Type',
                    context,
                  );
                },
                child: Container(
                  height: 52,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      border: Border.all(
                        color: selectedType == 2
                            ? AppColors.red
                            : AppColors.testItemBorder,
                      ),
                      color: AppColors.baseGrayScale.withOpacity(0.5)),
                  child: Row(
                    children: <Widget>[
                      Text(
                        userType,
                        style: TextStyle(
                          color: AppColors.activeTestButton.withOpacity(0.8),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const Spacer(),
                      SvgPicture.asset(SvgIcons.icDown),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 56,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: InkWell(
                        highlightColor: AppColors.opacity,
                        splashColor: AppColors.opacity,
                        onTap: () async {
                          if (
                              // passwordController.text.length>4&& RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(emailController.text)
                              _formKey.currentState!.validate() &&
                                  userType != 'User Type') {
                            final auth = AuthService();
                            final userModel = UserModel(
                                email: emailController.text.trim(),
                                userType: userType,
                                password: passwordController.text.trim());
                            final user = await auth
                                .createUserWithEmailPassword(userModel);
                            if (user != null) {
                              auth.route(context, userModel);
                            }

                          } else {
                            if (userType == 'User Type' && selectedType != 2) {
                              setState(() {
                                selectedType = 2;
                              });
                            }
                            if (userType != 'User Type' && selectedType == 2) {
                              setState(() {
                                selectedType = 1;
                              });
                            }
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                icon: SvgPicture.asset(SvgIcons.icWarning,
                                    color: Colors.red),
                                message: "Fill them all in",
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(6),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 11),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.baseColor,
                          ),
                          child: Text(
                            'Create Profile',
                            style:
                                TextStyle(color: AppColors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: InkWell(
                        highlightColor: AppColors.opacity,
                        splashColor: AppColors.opacity,
                        onTap: () async {
                          if (_formKey.currentState!.validate() &&
                              userType != 'User Type') {
                            final auth = AuthService();
                            final userModel = UserModel(
                                email: emailController.text.trim(),
                                userType: userType,
                                password: passwordController.text.trim());
                            final user = await auth
                                .loginUserWithEmailPassword(userModel);
                            if (user!=null) {
                              await auth.checkUserType(userModel,context);
                            } else {
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  icon: SvgPicture.asset(SvgIcons.icWarning,
                                      color: Colors.red),
                                  message: "Fill them all correct",
                                ),
                              );
                            }
                          } else {
                            if (userType == 'User Type' && selectedType != 2) {
                              setState(() {
                                selectedType = 2;
                              });
                            }
                            if (userType != 'User Type' && selectedType == 2) {
                              setState(() {
                                selectedType = 1;
                              });
                            }
                            showTopSnackBar(
                              Overlay.of(context),
                              CustomSnackBar.error(
                                icon: SvgPicture.asset(SvgIcons.icWarning,
                                    color: Colors.red),
                                message: "Fill them all in",
                              ),
                            );
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.all(6),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 11),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.baseColor,
                          ),
                          child: const Text(
                            'Login Profile',
                            style:
                                TextStyle(color: AppColors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
