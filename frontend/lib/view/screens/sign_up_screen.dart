import 'package:voluntracker/cubit/sign_up/sign_up_cubit.dart';
import 'package:voluntracker/view/widgets/custom_drawer.dart';
import 'package:voluntracker/view/widgets/custom_text_form_field.dart';
import 'package:voluntracker/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../../router.dart';
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
      endDrawer: CustomDrawer(loggedIn: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state is SignUpError) {
              CustomSnackbars.errorSnackbar(
                  context, state.title, state.description);
            } else if (state is SignUpSuccess) {
              CustomSnackbars.successSnackbar(
                  context, state.title, state.description);
              Navigator.pushReplacementNamed(context, Routes.loginRoute);
            } else if (state is SignUpConfirm) {
              Navigator.pushNamed(context, Routes.emailVerification);
            }
          },
          builder: (context, state) {
            if (state is SignUpLoading) {
              return const Center(child: LoadingWidget());
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CustomTextFormField(
                          initialValue: "",
                          label: "Name",
                          hint: "Name",
                          onChanged: (value) {
                            context
                                .read<SignUpCubit>()
                                .signUpModel
                                .user!
                                .firstname = value;
                          },
                        ),
                        CustomTextFormField(
                          initialValue: "",
                          label: "Surname",
                          hint: "Surname",
                          onChanged: (value) {
                            context
                                .read<SignUpCubit>()
                                .signUpModel
                                .user!
                                .surname = value;
                          },
                        ),
                        CustomTextFormField(
                          initialValue: "",
                          label: "Email",
                          hint: "example@voluntracker.com",
                          onChanged: (value) {
                            context
                                .read<SignUpCubit>()
                                .signUpModel
                                .user!
                                .email = value;
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
                          hint: "05xxxxxxxxx",
                          onChanged: (value) {
                            context
                                .read<SignUpCubit>()
                                .signUpModel
                                .user!
                                .phone = value;
                          },
                        ),
                        CustomTextFormField(
                          isObscure: context.read<SignUpCubit>().isObscure,
                          suffixIcon: IconButton(
                            icon: Icon(!context.read<SignUpCubit>().isObscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: () {
                              context.read<SignUpCubit>().changeVisible();
                            },
                          ),
                          label: "Password",
                          hint: "Password",
                          onChanged: (value) {
                            context
                                .read<SignUpCubit>()
                                .signUpModel
                                .user!
                                .password = value;
                          },
                        ),
                        CustomTextFormField(
                          isObscure: context.read<SignUpCubit>().isObscure,
                          label: "Repeat Password",
                          hint: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(!context.read<SignUpCubit>().isObscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined),
                            onPressed: () {
                              context.read<SignUpCubit>().changeVisible();
                            },
                          ),
                          onChanged: (value) {},
                          customValidator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Password cannot be blank";
                            } else if (context
                                    .read<SignUpCubit>()
                                    .signUpModel
                                    .user!
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
                            child: Text("Sign Up")),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Already have an account?"),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.loginRoute);
                                },
                                child: const Text("Login"))
                          ],
                        ),
                      ],
                    ),
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
