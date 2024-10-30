part of "home_page_bloc.dart";

sealed class HomePageEvent extends Equatable {
  const HomePageEvent();
}
final class HomePageTasksEvent extends HomePageEvent{
  @override
  List<Object?> get props =>[];
}
final class HomePageDeleteTasksEvent extends HomePageEvent{
  final String id;final String filePath;
 const HomePageDeleteTasksEvent({required this.id,required this.filePath});
  @override
  List<Object?> get props =>[filePath,id];
}

final class HomePageDownloadTasksEvent extends HomePageEvent{
  final String fileName;
  const HomePageDownloadTasksEvent({required this.fileName});
  @override
  List<Object?> get props =>[fileName];
}

final class HomePageUploadTasksEvent extends HomePageEvent{
  final String fileName;final File file;
  const HomePageUploadTasksEvent({required this.file,required this.fileName});
  @override
  List<Object?> get props =>[file,fileName];
}
final class HomePageChangeIndexEvent extends HomePageEvent{
  const HomePageChangeIndexEvent({required this.currentIndex});
  final int currentIndex;

  @override
  List<Object?> get props => [currentIndex];

}
