import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:teach/features/auth/data/model/userType_model.dart";
import "package:teach/features/home/presentation/pages/add_task/add_task_page.dart";
import "package:teach/features/profile/presentation/model/task_model.dart";


mixin AddTaskMixin on State<AddTaskPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late FocusNode userNameFocus;
  late FocusNode passwordFocus;
   String dateTime='';
   late TaskModel taskModel;
     File file=File('');

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  void initControllers() {
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    passwordFocus = FocusNode();
    userNameFocus = FocusNode();
  }


  void disposeControllers() {
    titleController.dispose();
    descriptionController.dispose();
    passwordFocus.dispose();
    userNameFocus.dispose();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }
}
