import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(ForgetPasswordInitial());

  Future<void> sendResetEmail(String email) async {
    emit(ForgetPasswordLoading());

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: email.trim(),
      );

      emit(ForgetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ForgetPasswordError(
          e.message ?? "Something went wrong"));
    } catch (e) {
      emit(ForgetPasswordError("Unexpected error"));
    }
  }
}
