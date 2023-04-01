import 'package:voluntracker/models/auth/auth_response_model.dart';
import 'package:voluntracker/services/auth_service.dart';
import 'package:bloc/bloc.dart';
import '../../models/auth/create_user_model.dart';
import '../../models/auth/sign_up_model.dart';
import '../../models/confirm_email_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.service) : super(SignUpInitial());
  AuthService service;
  SignUpModel signUpModel = SignUpModel(user: CreateUserModel());
  bool isVisible = false;

  Future<void> signUp() async {
    emit(SignUpLoading());
    AuthResponseModel? signUpResponseModel = await service.signUp(signUpModel);
    if (signUpResponseModel == null) {
      emit(SignUpError("Sign Up Failed", ""));
    } else {
      emit(SignUpConfirm());
    }
  }

  Future<void> confirmEmail(ConfirmEmailModel bodyModel) async {
    emit(SignUpLoading());
    bool response = await service.confirmEmail(bodyModel);
    if (response) {
      emit(SignUpSuccess("Successful", "Signed Up Successfully"));
    } else {
      emit(SignUpError("Sign Up Failed", ""));
    }
  }

  void changeVisible() {
    emit(SignUpChecking());
    isVisible = !isVisible;
    emit(SignUpDisplay());
  }
}
