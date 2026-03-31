import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_hub/core/di/di.dart';
import 'package:food_hub/core/utils/app_colors.dart';
import 'package:food_hub/core/validator/app_validators.dart';
import 'package:food_hub/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:food_hub/features/auth/presentation/cubit/auth_state.dart';
import 'package:food_hub/features/auth/presentation/screen/login_screen.dart';
import 'package:food_hub/shared/app_button.dart';
import 'package:food_hub/shared/app_text_field.dart';
import 'package:food_hub/shared/bottom_text.dart';
import 'package:food_hub/shared/sub_title_text.dart';
import 'package:food_hub/shared/title_text.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  AuthCubit authCubit = getIt<AuthCubit>();
  var formKey = GlobalKey<FormState>();

  bool secure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<AuthCubit,AuthState>(
          bloc: authCubit,
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Account created successfully')),
              );
            }
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }

          },
          builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    const TitleText(text: "Create Account"),
                    const SizedBox(height: 10),
                    const SubtitleText(text: "Sign up to get started!"),
                    const SizedBox(height: 80),

                    // Text Fields
                    AppTextField(
                      hint: "Full Name",
                      controller: nameController,
                      suffixIcon: Icon(Icons.drive_file_rename_outline),
                      obscureText: false,
                      keyboardType: TextInputType.name,
                      validator: (_) => AppValidators.displayNameValidator(nameController.text),
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      hint: "Email Address",
                      controller: emailController,
                      suffixIcon: Icon(Icons.email_outlined),
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (_) => AppValidators.emailValidator(emailController.text),
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      hint: "Password",
                      obscureText: secure,
                      controller: passwordController,
                      keyboardType: TextInputType.number,
                      validator: (_) => AppValidators.passwordValidator(passwordController.text),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            secure = !secure;
                          });
                        },
                        icon: Icon(secure ? Icons.visibility_off : Icons.visibility),
                      ),
                    ),
                    const SizedBox(height: 80),

                    // Register Button
                    AppButton(
                        title: state is AuthLoading? "Loading..." : "Register",
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                            authCubit.register(
                                nameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim()
                            );
                          }
                        }
                    ),

                    const SizedBox(height: 20),

                    // Bottom Text
                    BottomText(
                      normalText: "Already have an account?",
                      actionText: "Login",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ) ;
        },
      ),
    );
  }
}
