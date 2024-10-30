part of 'profile_bloc.dart';

final class ProfileState extends Equatable {
  const ProfileState({this.profileModel, required this.status, this.message});

  final String? message;
  final String? profileModel;
  final StatusEnum status;

  ProfileState copyWith({String? message,
      StatusEnum? status,
      String? profileModel}) =>
      ProfileState(status: status ?? this.status,
          message: message ?? this.message,
          profileModel: profileModel ?? this.profileModel);

  @override
  List<Object?> get props => [status, message, profileModel];
}


