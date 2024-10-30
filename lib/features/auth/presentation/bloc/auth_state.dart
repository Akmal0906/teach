part of 'auth_bloc.dart';

enum LoginStatus { initial, loading, success, error }

class AuthState extends Equatable {
  const AuthState({required this.status,this.result});

  final LoginStatus status;
  final String? result;
  AuthState copyWith(
      {


        LoginStatus? status,
        String? result}) =>
      AuthState(
        result: result ?? this.result,
        status: status ?? this.status,

      );
  @override
  List<Object?> get props => [status,result];

}


