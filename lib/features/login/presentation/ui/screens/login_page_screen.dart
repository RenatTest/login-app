import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:login_app/features/app/page_names.dart';
import 'package:login_app/features/login/presentation/cubit/auth_cubit.dart';
import 'package:login_app/features/login/presentation/cubit/auth_state.dart';

// class LoginPageScreen extends StatefulWidget {
//   const LoginPageScreen({super.key});

//   @override
//   State<LoginPageScreen> createState() => _LoginPageScreenState();
// }

// class _LoginPageScreenState extends State<LoginPageScreen> {
//   final formKey = GlobalKey<FormState>();
//   final blankFocusNode = FocusNode();
//   String? email;
//   String? password;
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   Future<void> chackAuth() async {
//     final userFromStorage = await SecureStorage.instance.getToken();
//     if (userFromStorage != '') {
//       context.goNamed(ScreenNames.homePage);
//     }
//   }

//   @override
//   void initState() {
//     chackAuth();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         title: Text('Login Page', style: TextStyle(color: Colors.white)),
//         centerTitle: true,
//       ),
//       body: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTap: () {
//           FocusScope.of(context).requestFocus(blankFocusNode);
//         },
//         child: Center(
//           child: Form(
//             key: formKey,
//             child: Padding(
//               padding: EdgeInsets.all(10),
//               child: Column(
//                 spacing: 10,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   FormField<String>(
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Email cannot be empty';
//                       }

//                       return RegExp(
//                             r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
//                           ).hasMatch(value)
//                           ? null
//                           : 'Please enter a valid email';
//                     },
//                     builder: (FormFieldState<String> field) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextField(
//                             controller: emailController,
//                             onChanged: (emailValue) {
//                               field.didChange(emailValue);
//                               email = emailValue;
//                             },
//                             style: const TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               labelText: 'Email',
//                               labelStyle: const TextStyle(color: Colors.grey),
//                               hintText: 'Enter email',
//                               hintStyle: const TextStyle(color: Colors.grey),
//                               errorText: field.errorText,
//                               enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white54),
//                               ),
//                               focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                               errorBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),

//                   FormField<String>(
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Password cannot be empty';
//                       }
//                       return value.length > 5
//                           ? null
//                           : 'Please enter a password of at least 6 characters';
//                     },
//                     builder: (FormFieldState<String> field) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           TextField(
//                             controller: passwordController,
//                             onChanged: (passwordValue) {
//                               field.didChange(passwordValue);
//                               password = passwordValue;
//                             },
//                             style: const TextStyle(color: Colors.white),
//                             decoration: InputDecoration(
//                               labelText: 'Password',
//                               labelStyle: const TextStyle(color: Colors.grey),
//                               hintText: 'Enter password',
//                               hintStyle: const TextStyle(color: Colors.grey),
//                               errorText: field.errorText,
//                               enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white54),
//                               ),
//                               focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.white),
//                               ),
//                               errorBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.red),
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   ),

//                   ElevatedButton(
//                     onPressed: () async {
//                       if (formKey.currentState!.validate()) {
//                         FocusScope.of(context).requestFocus(blankFocusNode);
//                         try {
//                           await LoginRegisterApiFirebase().loginRegister(
//                             email: emailController.text,
//                             password: passwordController.text,
//                           );
//                           emailController.clear();
//                           passwordController.clear();
//                           email = null;
//                           password = null;
//                           formKey.currentState!.reset();
//                           context.goNamed(ScreenNames.homePage);
//                         } catch (e) {
//                           ScaffoldMessenger.of(
//                             context,
//                           ).showSnackBar(SnackBar(content: Text(e.toString())));
//                         }
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.transparent,
//                       shadowColor: Colors.transparent,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       side: BorderSide(width: 2.0, color: Colors.white),
//                     ),
//                     child: Text(
//                       'Login / Register',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
          if (state.user != null) {
            context.goNamed(ScreenNames.homePage);
          }
        },
        builder: (context, state) {
          return
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: Column(
          //     children: [
          //       TextField(
          //         controller: emailController,
          //         decoration: InputDecoration(labelText: 'Email'),
          //       ),
          //       TextField(
          //         controller: passwordController,
          //         decoration: InputDecoration(labelText: 'Password'),
          //         obscureText: true,
          //       ),
          //       const SizedBox(height: 16),
          //     state.loading
          //         ? const CircularProgressIndicator()
          //         : ElevatedButton(
          //             onPressed: () {
          //               context.read<AuthCubit>().signIn(
          //                 emailController.text,
          //                 passwordController.text,
          //               );
          //             },
          //             child: const Text('Sign In'),
          //           ),
          //     if (state.error != null)
          //       Text(state.error!, style: const TextStyle(color: Colors.red)),
          //   ],
          // ),
          // );
          GestureDetector(
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
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
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
                                  // context.goNamed(ScreenNames.homePage);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                side: BorderSide(
                                  width: 2.0,
                                  color: Colors.white,
                                ),
                              ),
                              child: Text(
                                'Login / Register',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                      if (state.error != null)
                        Text(
                          state.error!,
                          style: const TextStyle(color: Colors.red),
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
