import 'package:afet_takip/cubit/sign_up/sign_up_cubit.dart';
import 'package:afet_takip/view/widgets/custom_text_form_field.dart';
import 'package:afet_takip/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../widgets/custom_snackbars.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpError) {
              CustomSnackbars.errorSnackbar(
                  context, state.title, state.description);
              //Navigator.pop(context);
            } else if (state is SignUpSuccess) {
              CustomSnackbars.successSnackbar(
                  context, state.title, state.description);
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if (state is SignUpLoading) {
              return const Center(child: LoadingWidget());
            } else {
              return Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextFormField(
                        initialValue: "",
                        label: "Name",
                        hint: "Ex: Can",
                        onChanged: (value) {
                          context.read<SignUpCubit>().signUpModel.firstname =
                              value;
                        },
                      ),
                      CustomTextFormField(
                        initialValue: "",
                        label: "Surname",
                        hint: "Ex: Ersoy",
                        onChanged: (value) {
                          context.read<SignUpCubit>().signUpModel.surname =
                              value;
                        },
                      ),
                      CustomTextFormField(
                        initialValue: "",
                        label: "Email",
                        hint: "Ex: example@voluntracker.com",
                        onChanged: (value) {
                          context.read<SignUpCubit>().signUpModel.email = value;
                        },
                        customValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return "E-mail cannot be blank";
                          } else if (!isEmail(value)) {
                            return "Please enter a valid e-mail adress";
                          } else {
                            return null;
                          }
                        },
                      ),
                      CustomTextFormField(
                        initialValue: "",
                        label: "Phone",
                        hint: "Ex: 05300861306",
                        onChanged: (value) {
                          context.read<SignUpCubit>().signUpModel.phone = value;
                        },
                      ),
                      CustomTextFormField(
                        isObscure: true,
                        initialValue: "",
                        label: "Password",
                        hint: "Password",
                        onChanged: (value) {
                          context.read<SignUpCubit>().signUpModel.password =
                              value;
                        },
                      ),
                      CustomTextFormField(
                        isObscure: true,
                        initialValue: "",
                        label: "Repeat Password",
                        hint: "Password",
                        onChanged: (value) {},
                        customValidator: (value) {
                          if (value == null || value.isEmpty) {
                            return "E-mail cannot be blank";
                          } else if (context
                                  .read<SignUpCubit>()
                                  .signUpModel
                                  .password !=
                              value) {
                            return "Passwords do not match";
                          } else {
                            return null;
                          }
                        },
                      ),
                      ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              context.read<SignUpCubit>().signUp();
                            }
                          },
                          child: Text("Sign Up"))
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
