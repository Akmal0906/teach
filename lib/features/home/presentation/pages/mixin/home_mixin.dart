import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_svg/svg.dart";
import "package:go_router/go_router.dart";
import "package:teach/features/auth/data/model/userType_model.dart";
import "package:teach/features/home/presentation/pages/add_task/add_task_page.dart";
import "package:teach/features/home/presentation/pages/home_page.dart";
import "package:teach/features/profile/presentation/model/task_model.dart";


mixin HomeMixin on State<HomePage> {

  String  fileName='';
  File file=File('');

  @override
  void initState() {
    super.initState();
  }



  @override
  void dispose() {
    super.dispose();
  }
}
