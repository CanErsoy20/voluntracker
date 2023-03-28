import 'package:afet_takip/services/auth_service.dart';
import 'package:bloc/bloc.dart';

import '../../models/auth/login_model.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.service) : super(LoginInitial());
  LoginModel loginModel = LoginModel();
  AuthService service;

  Future<void> login() async {
    emit(LoginLoading());
    // TODO: user model
    await service.login(loginModel);
    if (true) {
      emit(LoginSuccess("Login Successful", "Succesfully Logged In"));
    } else {
      emit(
          LoginError("Login Failed", "Your username or password is incorrect"));
    }
  }
}
