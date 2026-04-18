import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/common/widgets/widgets.dart';
import 'package:frontend_side/core/routes/app_routes.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/authentication/authentication.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var obsecureText = true;
  _login() {
    if (_formKey.currentState!.validate()) {
      var loginParam = Loginparam(
          email: emailController.text, password: passwordController.text);
      BlocProvider.of<AuthBloc>(context).add(LoginUser(params: loginParam));
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 25,
                          color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter email',
                      label: Text('Your Email'),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Palette.mainColorLightMode,
                          width: 1.5,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: obsecureText,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter password',
                      label: Text('Password'),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obsecureText = !obsecureText;
                            });
                          },
                          icon: Icon(
                            !obsecureText
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Palette.mainColorLightMode,
                          )),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Palette.mainColorLightMode,
                          width: 1.5,
                        ),
                      )),
                ),
                const SizedBox(
                  height: 15,
                ),
                BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: CustomButton(
                        height: 45,
                        width: double.infinity,
                        fontSize: 20,
                        tap: _login,
                        text: 'Login',
                        textColor: Colors.white),
                  );
                }, listener: (context, state) {
                  if (state.userStatus == UserStatus.loading) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return LoadingDialog();
                        });
                  } else if (state.userStatus == UserStatus.loaded) {
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Login Successfully")));
                    context.goNamed(AppRoutes.homeView.name);
                  } else if (state.userStatus == UserStatus.error) {
                    context.pop();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error!)));
                  }
                }),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text.rich(TextSpan(
                      text: "Don't have an account? ",
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                            text: "Sign Up",
                            style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                decoration: TextDecoration.none,
                                color: Palette.mainColorLightMode),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                context.read<AuthBloc>().add(ToggleLogin());
                              })
                      ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
