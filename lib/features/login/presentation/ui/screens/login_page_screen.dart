import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_app/features/app/page_names.dart';
import 'package:login_app/features/login/presentation/cubit/auth_cubit.dart';
import 'package:login_app/features/login/presentation/cubit/auth_state.dart';
import 'package:login_app/features/login/presentation/ui/widgets/login_button.dart';

class LoginPageScreen extends StatefulWidget {
  const LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageScreen> {
  final formKey = GlobalKey<FormState>();

  final blankFocusNode = FocusNode();
  String email = '';
  String password = '';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Login Page', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.user?.token != null) {
            context.goNamed(ScreenNames.homePage);
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Center(
                  child: Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).requestFocus(blankFocusNode);
            },
            child: Center(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email cannot be empty';
                          }

                          return RegExp(
                                r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                              ).hasMatch(value)
                              ? null
                              : 'Please enter a valid email';
                        },
                        builder: (FormFieldState<String> field) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: emailController,
                                onChanged: (emailValue) {
                                  field.didChange(emailValue);
                                  email = emailValue;
                                },
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Enter email',
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  errorText: field.errorText,
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white54,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      FormField<String>(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return value.length > 5
                              ? null
                              : 'Please enter a password of at least 6 characters';
                        },
                        builder: (FormFieldState<String> field) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                controller: passwordController,
                                onChanged: (passwordValue) {
                                  field.didChange(passwordValue);
                                  password = passwordValue;
                                },
                                obscureText: true,
                                obscuringCharacter: '*',
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  hintText: 'Enter password',
                                  hintStyle: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                  errorText: field.errorText,
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.white54,
                                    ),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      state.loading
                          ? const CircularProgressIndicator(
                              color: Colors.black,
                              backgroundColor: Colors.white,
                            )
                          : LoginButton(
                              buttonText: 'Login / Register',
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  FocusScope.of(
                                    context,
                                  ).requestFocus(blankFocusNode);
                                  context.read<AuthCubit>().signIn(
                                    emailController.text,
                                    passwordController.text,
                                  );
                                  emailController.clear();
                                  passwordController.clear();
                                  formKey.currentState!.reset();
                                  email = '';
                                  password = '';
                                }
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
