part of 'home_page_bloc.dart';
enum StatusEnum {
  initial,
  loading,
  error,
  success,
  upload,
  deleted,
  unDelete
}

class HomePageState extends Equatable {
  const HomePageState({this.taskModelList, required this.status,this.message,required this.currentIndex});

  final StatusEnum status;
  final List<TaskModel>? taskModelList;
  final String? message;
  final int currentIndex;

  @override
  List<Object?> get props => [taskModelList,status,message,currentIndex];

  HomePageState copyWith({ List<TaskModel>? taskModelList, required StatusEnum? status,String? message,int? currentIndex}) =>
      HomePageState(taskModelList: taskModelList ?? this.taskModelList,
          status: status?? this.status,
        message: message?? this.message,
        currentIndex: currentIndex?? this.currentIndex
      );
}
