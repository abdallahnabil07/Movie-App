part of 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> userLogin(String email, String password) async {
    try {
      emit(LoginLoading());
      var userCredential = await AuthFirebaseService.signInWithEmailAndPassword(
        email,
        password,
      );
      emit(LoginSuccess(user: userCredential.user));
    } on AuthError catch (authError) {
      emit(LoginFailure(errorMessage: authError.message));
    } catch (error) {
      emit(LoginFailure(errorMessage: error.toString()));
    }
  }

  Future<void> userLoginByGoogle() async {
    try {
      emit(LoginLoading());
      var userCredential = await AuthFirebaseService.signInWithGoogle();
      if (userCredential == null) {
        emit(LoginFailure(errorMessage: 'Google Sign-In cancelled'));
        return;
      }
      emit(LoginSuccess(user: userCredential));
    } on AuthError catch (authError) {
      emit(LoginFailure(errorMessage: authError.message));
    } catch (error) {
      emit(LoginFailure(errorMessage: error.toString()));
    }
  }
}
