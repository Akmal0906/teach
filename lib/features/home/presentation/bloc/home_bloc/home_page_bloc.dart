import "dart:io";

import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:teach/features/profile/presentation/model/task_model.dart";

import "../../../../../core/either/either.dart";
import "../../../../../core/error/failure.dart";
import "../../../../api/repository.dart";

part "home_page_event.dart";

part "home_page_state.dart";

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc({required this.repository})
      : super(
            const HomePageState(status: StatusEnum.loading, currentIndex: 0)) {
    on<HomePageTasksEvent>(_getLessons);
    on<HomePageDeleteTasksEvent>(_deleteTask);
    on<HomePageUploadTasksEvent>(_uploadFile);
    on<HomePageDownloadTasksEvent>(_download);
  }

  final Repository repository;

  Future<void> _getLessons(
      HomePageTasksEvent event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(status: StatusEnum.loading));
    final Either<Failure, List<Map<String, dynamic>>> lessons =
        await repository.getTasks();
    await Future.delayed(Duration(seconds: 2));
    final List<String>? filePath = await repository.getFilePath();

    lessons.fold((Failure failure) {
      emit(state.copyWith(status: StatusEnum.error, message: failure.message));
    }, (List<Map<String, dynamic>> right) {
      List<TaskModel> list = [];
      print('roghttttttt ${right}');
      for (int i = 0; i < right.length; i++) {
        if (filePath != null && filePath.length >= i && filePath.isNotEmpty) {
          right[i]['path'] = filePath[i];
        }
        list.add(TaskModel.fromJson(right[i]));
      }
      ;
      print('Listtttttttttt $list');
      emit(state.copyWith(status: StatusEnum.success, taskModelList: list));
    });
  }

  Future<void> _deleteTask(
      HomePageDeleteTasksEvent event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(status: StatusEnum.loading));
    final Either<Failure, String> result =
        await repository.deleteTasks(event.id, event.filePath);
    result.fold(
        (Failure fail) => emit(
            state.copyWith(status: StatusEnum.unDelete, message: fail.message)),
        (String right) =>
            emit(state.copyWith(status: StatusEnum.deleted, message: right)));
  }

  Future<void> _uploadFile(
      HomePageUploadTasksEvent event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(status: StatusEnum.loading));
    final Either<Failure, String> result =
    await repository.uploadFile(event.file, event.fileName);
    result.fold(
            (Failure fail) => emit(
            state.copyWith(status: StatusEnum.success, message: fail.message)),
            (String right) =>
            emit(state.copyWith(status: StatusEnum.upload, message: right)));
  }

  Future<void> _download(
      HomePageDownloadTasksEvent event, Emitter<HomePageState> emit) async {
    emit(state.copyWith(status: StatusEnum.loading));
    final Either<Failure, String> result =
    await repository.downloadFile(event.fileName);
    result.fold(
            (Failure fail) => emit(
            state.copyWith(status: StatusEnum.success, message: fail.message)),
            (String right) =>
            emit(state.copyWith(status: StatusEnum.success, message: right)));
  }


}
