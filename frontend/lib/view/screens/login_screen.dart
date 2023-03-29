import 'package:afet_takip/router.dart';
import 'package:afet_takip/view/widgets/custom_text_form_field.dart';
import 'package:afet_takip/view/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';

import '../../cubit/help_centers/help_center_cubit.dart';
import '../../cubit/login/login_cubit.dart';
import '../../models/user/user_info.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_snackbars.dart';
import '../widgets/profile_avatar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocConsumer<LoginCubit, LoginState>(listener: (context, state) {
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
        }, builder: (context, state) {
          if (state is LoginLoading) {
            return const Center(child: LoadingWidget());
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/loading.gif",
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

  Form _buildForm(BuildContext context) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      key: formKey,
      child: Column(
        children: [
          CustomTextFormField(
            initialValue: "",
            label: "Email",
            hint: "Email",
            suffixIcon: const Icon(Icons.mail),
            onChanged: (value) {
              context.read<LoginCubit>().loginModel.email = value;
            },
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
            initialValue: "",
            label: "Password",
            hint: "Password",
            suffixIcon: const Icon(Icons.lock_outlined),
            isObscure: true,
            onChanged: (value) {
              context.read<LoginCubit>().loginModel.password = value;
            },
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.white),
                )),
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
                context.read<HelpCenterCubit>().getHelpCenters().then((value) =>
                    Navigator.pushNamed(context, Routes.helpCenterList));
              },
              child: const Text("Continue as guest"))
        ],
      ),
    );
  }
}
