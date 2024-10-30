part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();
}

final class ProfileInfoEvent extends ProfileEvent {
  @override
  List<Object?> get props => [];
}

final class ProfileUpdateEvent extends ProfileEvent {
  const ProfileUpdateEvent({required this.profileRequestModel});

  final String profileRequestModel;

  @override
  List<Object?> get props => [profileRequestModel];
}
