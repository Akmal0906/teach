import 'package:equatable/equatable.dart';
import "package:flutter_bloc/flutter_bloc.dart";

import '../../../../core/error/failure.dart';
import '../../../api/repository.dart';
import '../../data/login/login_user_request.dart';


part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository})
      : super(const AuthState(status: LoginStatus.initial)) {
    on<AuthLoginEvent>(_login);
  }

  final Repository authRepository;

 Future<void> _login(AuthLoginEvent event, Emitter<AuthState> emit) async {
   emit(const AuthState(status: LoginStatus.loading));
    final  result =
        await authRepository.login(LoginUserRequest(
            password: event.password,
            username: event.username,
            authtype: event.authType));
    await result.fold(
          (Failure left)async{ emit(const AuthState(status: LoginStatus.error,result: 'Something went wrong')); },
          (String right) async {
       // await setTokens(loginResponse: right);
        emit(const AuthState(status: LoginStatus.success,result:"Login Successfully"));
      },
    );
  }
}
