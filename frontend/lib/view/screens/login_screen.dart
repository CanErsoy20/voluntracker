import 'package:voluntracker/router.dart';
import 'package:voluntracker/view/widgets/custom_text_form_field.dart';
import 'package:voluntracker/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../../cubit/help_centers/help_center_cubit.dart';
import '../../cubit/login/login_cubit.dart';
import '../../models/user/user_info.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_snackbars.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("remember me is: ${context.read<LoginCubit>().rememberMe}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocConsumer<LoginCubit, LoginState>(
            bloc: context.read<LoginCubit>()..checkPrefs(),
            listener: (context, state) {
              if (state is LoginError) {
                CustomSnackbars.errorSnackbar(
                    context, state.title, state.description);
              } else if (state is LoginSuccess) {
                CustomSnackbars.successSnackbar(
                    context, state.title, state.description);
                context.read<HelpCenterCubit>().getHelpCenters();
                if (UserInfo.loggedUser!.volunteer!.helpCenterId != null) {
                  context.read<HelpCenterCubit>().getMyCenter();
                }
                Navigator.pushReplacementNamed(context, Routes.landingRoute);
              }
            },
            builder: (context, state) {
              if (state is LoginFirstTime || state is LoginLoggedOut) {
                context.read<LoginCubit>().updatePrefRememberMe();
              }
              if (state is LoginLoading) {
                return const Center(child: LoadingWidget());
              } else {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/home.png",
                        height: MediaQuery.of(context).size.height / 4,
                      ),
                      _buildForm(context),
                    ],
                  ),
                );
              }
            }),
      ),
      endDrawer: CustomDrawer(loggedIn: false),
    );
  }

  Padding _buildForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(
          children: [
            CustomTextFormField(
              controller: context.read<LoginCubit>().emailController,
              label: "Email",
              hint: "Email",
              prefixIcon: const Icon(Icons.mail),
              customValidator: (value) {
                if (value == null || value.isEmpty) {
                  return "Email cannot be blank";
                } else if (!isEmail(value)) {
                  return "Please enter a valid email";
                } else {
                  return null;
                }
              },
            ),
            CustomTextFormField(
              controller: context.read<LoginCubit>().passwordController,
              label: "Password",
              hint: "Password",
              prefixIcon: const Icon(Icons.lock_outlined),
              suffixIcon: IconButton(
                icon: Icon(!context.read<LoginCubit>().isObscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined),
                onPressed: () {
                  context.read<LoginCubit>().changeVisible();
                },
              ),
              isObscure: context.read<LoginCubit>().isObscure,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.forgotPassword);
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white),
                    )),
                Expanded(
                  child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 25),
                      side: const BorderSide(color: Colors.blue, width: 3),
                      checkColor: Colors.white,
                      title: Text(
                        "Remember Me",
                        style: TextStyle(color: Colors.white),
                      ),
                      value: context.read<LoginCubit>().rememberMe,
                      tristate: true,
                      onChanged: (value) {
                        context.read<LoginCubit>().changeRememberMe();
                        print(
                            "changed to: ${context.read<LoginCubit>().rememberMe}");
                      }),
                ),
                TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  context.read<LoginCubit>().login();
                }
              },
              style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: const Text("Login"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Do not have an account?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, Routes.registerRoute);
                    },
                    child: const Text("Sign Up"))
              ],
            ),
            TextButton(
                onPressed: () {
                  context.read<HelpCenterCubit>().getHelpCenters().then(
                      (value) =>
                          Navigator.pushNamed(context, Routes.helpCenterList));
                },
                child: const Text("Continue as guest"))
          ],
        ),
      ),
    );
  }
}
