import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_app/core/enum/auth_error.dart';
import 'package:movie_app/modules/Auth/utils/auth_firebase_service.dart';

part 'login_cubit.dart';

sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final User? user;

  LoginSuccess({required this.user});
}

class LoginFailure extends LoginState {
  final String errorMessage;

  LoginFailure({required this.errorMessage});
}
