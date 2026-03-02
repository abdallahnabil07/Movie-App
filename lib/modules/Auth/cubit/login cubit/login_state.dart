import 'package:bloc/bloc.dart';
import 'package:movie_app/modules/Auth/network/auth_api.dart';

part 'login_cubit.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String data;

  LoginSuccess({required this.data});
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}
