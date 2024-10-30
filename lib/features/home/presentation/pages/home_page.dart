import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:teach/features/home/presentation/bloc/home_bloc/home_page_bloc.dart';
import 'package:teach/features/home/presentation/pages/mixin/home_mixin.dart';
import 'package:teach/features/home/presentation/pages/widgets/home_item_widget.dart';
import 'package:teach/features/profile/presentation/model/task_model.dart';
import 'package:teach/router/app_routes.dart';
import 'package:teach/service/auth_service.dart';
import 'package:widget_lifecycle/widget_lifecycle.dart';
import '../../../../core/custom_snackbar/custom_snack_bar.dart';
import '../../../../core/custom_snackbar/top_snack_bar.dart';
import '../../../api/repository_impl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with HomeMixin {
  final Permission permission = Permission.storage;

  @override
  Widget build(BuildContext context) => BlocListener<HomePageBloc,
          HomePageState>(
      listener: (BuildContext context, HomePageState state) async {
        if (state.status == StatusEnum.upload) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message: 'uploadded file',
              backgroundColor: Colors.green,
            ),
          );
        } else if (state.status == StatusEnum.deleted) {
          showTopSnackBar(
            Overlay.of(context),
            CustomSnackBar.success(
              message: state.message ?? "",
              backgroundColor: Colors.green,
            ),
          );
        }
      },
      listenWhen: (HomePageState p, HomePageState c) => p.status != c.status,
      child: LifecycleAware(
        observer: LifecycleObserver(
            onCreate: (l) {},
            onVisible: (l) {
              context.read<HomePageBloc>().add(HomePageTasksEvent());
            }),
        builder: (BuildContext context, Lifecycle lifecycle) => Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                localSource.type == 'Teacher'
                    ? TextButton(
                        onPressed: () async {
                          await context.pushNamed(Routes.addTask);
                        },
                        child: const Text('Add Task'))
                    : const SizedBox.shrink(),
                BlocBuilder<HomePageBloc, HomePageState>(
                  buildWhen: (p, n) => p.status != n.status,
                  builder: (BuildContext context, state) {
                    if (state.status == StatusEnum.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state.status == StatusEnum.error) {
                      return Center(
                        child: Text(state.message ?? 'error occoured'),
                      );
                    } else if (state.status == StatusEnum.success ||
                        state.status == StatusEnum.deleted ||
                        state.status == StatusEnum.unDelete) {
                      return ListView.separated(
                        itemCount: state.taskModelList?.length ?? 0,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 12),
                        itemBuilder: (BuildContext context, int index) {
                          final TaskModel taskModel =
                              state.taskModelList![index];
                          print('documenttttttttt id ${taskModel.documentId}');
                          print('file path ${taskModel.path}');

                          return HomeItemsWidget(
                            lesson: taskModel,
                            id: taskModel.documentId,
                            onTap: () async {
                              state.taskModelList!.removeAt(index);
                              context.read<HomePageBloc>().add(
                                  HomePageDeleteTasksEvent(
                                      id: taskModel.documentId,
                                      filePath: taskModel.path));
                            },
                            onDownload: () {
                              context.read<HomePageBloc>().add(HomePageDownloadTasksEvent(fileName: taskModel.fileName));
                            },
                            onUpload: () async {
                              if (await permission.status.isDenied) {
                                await permission.request();
                                if (await permission.status.isGranted) {
                                  final Map<String, dynamic>? map =
                                      await getDataFile();

                                  fileName = map!['fileName'];
                                  file = map['file'];
                                }
                              } else {
                                final Map<String, dynamic>? map =
                                    await getDataFile();
                                fileName = map?['fileName'] ?? "";
                                file = map?['file'] ?? File('');
                              }
                             if(fileName.isNotEmpty&& context.mounted){
                               context.read<HomePageBloc>().add(
                                   HomePageUploadTasksEvent(
                                       file: file, fileName: fileName));
                             }
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          height: 12,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ));
}
