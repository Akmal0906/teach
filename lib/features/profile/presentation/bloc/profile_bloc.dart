import "package:equatable/equatable.dart";
import "package:flutter_bloc/flutter_bloc.dart";

import "../../../api/repository.dart";
import "../../../home/presentation/bloc/home_bloc/home_page_bloc.dart";


part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.repository})
      : super(const ProfileState(status: StatusEnum.initial)) {
  //  on<ProfileInfoEvent>(_profileInfo);


  }

  final Repository repository;

  // Future<void> _profileInfo(
  //     ProfileInfoEvent event, Emitter<ProfileState> emit) async {
  //   emit(state.copyWith(status: StatusEnum.loading));
  //   final Either<Failure, ProfileModel> result =
  //       await repository.getProfileInfo();
  //   result.fold(
  //       (Failure failure) => emit(
  //           state.copyWith(message: failure.message, status: StatusEnum.error)),
  //       (ProfileModel right) {
  //          final List<Results> result=[right.results];
  //
  //        return emit(
  //           state.copyWith(profileModel: right, status: StatusEnum.success));}
  //   );
  // }


}
