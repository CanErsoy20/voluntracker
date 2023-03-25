import 'package:afet_takip/api.dart';
import 'package:afet_takip/services/auth_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../models/auth/sign_up_model.dart';
import '../../models/auth/tokens_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.service) : super(SignUpInitial());
  AuthService service;
  SignUpModel signUpModel = SignUpModel();
  Future<void> signUp() async {
    emit(SignUpLoading());
    Tokens? tokens = await service.signUp(signUpModel);
    if (tokens == null) {
      emit(SignUpError("Sign Up Failed", ""));
    } else {
      emit(SignUpSuccess("Successful", "Signed Up Successfully"));
    }
  }
}
