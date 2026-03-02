part of 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> userLogin(String email, String password) async {
    try {
      emit(LoginLoading());
      var token = await AuthApi.loginRequest(email, password);
      emit(LoginSuccess(data: token));
    } catch (error) {
      emit(LoginFailure(errorMessage: error.toString()));
    }
  }
}
