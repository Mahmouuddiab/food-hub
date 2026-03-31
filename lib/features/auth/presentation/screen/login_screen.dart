import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_hub/core/di/di.dart';
import 'package:food_hub/core/utils/app_colors.dart';
import 'package:food_hub/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_hub/features/auth/presentation/cubit/auth_state.dart';
import 'package:food_hub/features/auth/presentation/screen/register_screen.dart';
import 'package:food_hub/root.dart';
import 'package:food_hub/shared/app_button.dart';
import 'package:food_hub/shared/app_text_field.dart';
import 'package:food_hub/shared/bottom_text.dart';
import 'package:food_hub/shared/sub_title_text.dart';
import 'package:food_hub/shared/title_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthCubit authCubit = getIt<AuthCubit>();
  var formKey = GlobalKey<FormState>();
  bool secure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: authCubit,
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),

                    const TitleText(text: "Welcome Back 👋"),
                    const SizedBox(height: 10),
                    const SubtitleText(text: "Login to your account"),
                    const SizedBox(height: 80),

                    // Email
                    AppTextField(
                      hint: "Email Address",
                      controller: emailController,
                      suffixIcon: const Icon(Icons.email_outlined),
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    const SizedBox(height: 20),

                    // Password
                    AppTextField(
                      hint: "Password",
                      obscureText: secure,
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            secure = !secure;
                          });
                        },
                        icon: Icon(
                          secure ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // TODO: Navigate to forgot password
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Login Button
                    AppButton(
                      title: state is AuthLoading ? "Loading..." : "Login",
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          authCubit.login(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                        }
                      },
                    ),

                    const SizedBox(height: 20),

                    // Bottom Text
                    BottomText(
                      normalText: "Don’t have an account?",
                      actionText: "Register",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Root()),
            );
          }
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
      ),
    );
  }
}
