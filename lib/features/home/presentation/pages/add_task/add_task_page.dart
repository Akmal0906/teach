import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teach/core/bottom_sheet/bottom_sheet_widget.dart';
import 'package:teach/features/home/presentation/pages/add_task/mixin/add_task_mixin.dart';

import '../../../../../constants/image_constants.dart';
import '../../../../../core/colors/app_colors.dart';
import '../../../../../core/custom_snackbar/custom_snack_bar.dart';
import '../../../../../core/custom_snackbar/top_snack_bar.dart';
import '../../../../../core/custom_textfield/custom_textfield.dart';
import '../../../../../service/auth_service.dart';
import '../../../../profile/presentation/model/task_model.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> with AddTaskMixin {
  final Permission permission = Permission.storage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Task'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                  labelText: "Title",
                  hintText: "title",
                  textInputAction: TextInputAction.next,
                  controller: titleController,
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
                  validator: (String? title) {
                    if (title != null || title!.isEmpty) {
                      return "email cannot empty";
                    } else if (title.length < 5) {
                      return "email_is_not_valid";
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(height: 16),
              CustomTextField(
                labelText: "Description",
                hintText: "Description",
                textInputAction: TextInputAction.next,
                controller: descriptionController,
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
                validator: (String? description) {
                  if (description == null || description.length < 5) {
                    return "Password Invalid";
                  }
                  return null;
                },
              ),
              InkWell(
                highlightColor: AppColors.opacity,
                splashColor: AppColors.opacity,
                onTap: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2027),
                          initialDate: DateTime.now())
                      .then((value) {
                    setState(() {
                      dateTime = value.toString();
                    });
                  });
                },
                child: Container(
                  height: 38,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.baseColor,
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: AppColors.baseColor.withOpacity(0.5)),
                  ),
                  child: Text('Choose Date ${dateTime}',style: TextStyle(color: AppColors.white),),
                ),
              ),
              TextButton(
                  onPressed: () async {
                    if (await permission.status.isDenied) {
                      await permission.request();
                      if (await permission.status.isGranted) {
                        final result = await FilePicker.platform.pickFiles();
                        if (result != null) {
                          final auth = AuthService();
                          final File file1 = File(result.files.single.path!);
                          final String fileName1 = file1.path.split("/").last;
                          final String path1 = file1.path;
                          taskModel = TaskModel(
                              title: titleController.text,
                              dateTime: dateTime,
                              description: descriptionController.text,
                              fileName: fileName1,
                              path:'/Fizika/$fileName1' ,
                              documentId: "");
                          file = file1;
                        }
                      }
                    } else {
                      final result = await FilePicker.platform.pickFiles();
                      if (result != null) {
                        final File file1 = File(result.files.single.path!);
                        final String fileName1 = file1.path.split("/").last;
                        final String path1 = file1.path;
                        taskModel = TaskModel(
                            title: titleController.text,
                            dateTime: dateTime,
                            description: descriptionController.text,
                            fileName: fileName1,
                            path:'/Fizika/$fileName1',
                            documentId: "");
                        file = file1;
                      }
                    }
                  },
                  child: const Text('Choose file')),
              InkWell(
                highlightColor: AppColors.opacity,
                splashColor: AppColors.opacity,
                onTap: () async {
                  print('pathhhh ${taskModel.path}');
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      dateTime.isNotEmpty &&
                      file.path.isNotEmpty) {
                    final auth = AuthService();
                  await   auth.uploadFile(
                        file, "Fizika/${taskModel.fileName}", taskModel).whenComplete((){
                          if(context.mounted){
                            context.pop();

                          }

                     });
                  }else{
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
                  height: 38,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors.baseColor,
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(color: AppColors.baseColor.withOpacity(0.5)),
                  ),
                  child: const Text('Upload file',style: TextStyle(color: Colors.white),),
                ),
              ),
              // TextButton(
              //     onPressed: () async {
              //       if (await permission.status.isDenied) {
              //         await permission.request();
              //         if (await permission.status.isGranted) {
              //           final result = await FilePicker.platform.pickFiles();
              //           if (result != null) {
              //             final auth = AuthService();
              //             final File file1 = File(result.files.single.path!);
              //             final String fileName1 = file1.path.split("/").last;
              //             final String path1 = file1.path;
              //
              //             await auth.uploadFile(
              //                 file1,
              //                 "Fizika/$fileName1",
              //                 TaskModel(
              //                     title: titleController.text,
              //                     dateTime: dateTime,
              //                     description: descriptionController.text,
              //                     fileName: fileName1));
              //           }
              //         }
              //       } else {
              //         final result = await FilePicker.platform.pickFiles();
              //         if (result != null) {
              //           final auth = AuthService();
              //           final File file1 = File(result.files.single.path!);
              //           final String fileName1 = file1.path.split("/").last;
              //           final String path1 = file1.path;
              //
              //           await auth.uploadFile(
              //               file1,
              //               "Fizika/$fileName1",
              //               TaskModel(
              //                   title: titleController.text,
              //                   dateTime: dateTime,
              //                   description: descriptionController.text,
              //                   fileName: fileName1));
              //         }
              //       }
              //       // final auth=AuthService();
              //       // await auth.createSubCollection('sub world');
              //     },
              //     child: const Text('add collection')),
            ],
          ),
        ),
      ),
    );
  }
}
