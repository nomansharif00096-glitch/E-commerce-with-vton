import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_side/core/common/widgets/widgets.dart';
import 'package:frontend_side/core/utils/utils.dart';
import 'package:frontend_side/features/authentication/authentication.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool check = false;
  var obsecureText = true;
  var obsecureText2 = true;

  _signUp() {
    if (_formKey.currentState!.validate()) {
      if (!check) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Please accept the terms and condition")));
      } else if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password doesn't match")));
      } else {
        var signupParam = SignupParams(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            address: 'none');
        BlocProvider.of<AuthBloc>(context).add(CreateUser(params: signupParam));
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontFamily: 'Inter', fontSize: 25),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  TextFormField(
                    controller: nameController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Name is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Enter name',
                        label: Text('Your Name'),
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
                    height: 10,
                  ),
                  TextFormField(
                    controller: confirmPasswordController,
                    obscureText: obsecureText2,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Confirm password is required';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Confirm password',
                        label: Text('Confirm Password'),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obsecureText2 = !obsecureText2;
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
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            setState(() {
                              check = !check;
                            });
                          },
                          icon: check
                              ? const Icon(
                                  Icons.check_box_rounded,
                                  size: 24,
                                  color: Palette.mainColorLightMode,
                                )
                              : const Icon(
                                  Icons.check_box_outline_blank_rounded,
                                  size: 24,
                                  color: Colors.grey,
                                )),
                      Text.rich(TextSpan(
                          text: "I agree to shopping ",
                          style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 15,
                              color: Colors.grey),
                          children: <TextSpan>[
                            TextSpan(
                                text: "Terms & Conditions",
                                style: const TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    decoration: TextDecoration.none,
                                    color: Palette.mainColorLightMode),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {})
                          ]))
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  BlocConsumer<AuthBloc, AuthState>(builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      child: CustomButton(
                          height: 45,
                          width: double.infinity,
                          fontSize: 20,
                          tap: _signUp,
                          text: 'Sign Up',
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
                      context.read<AuthBloc>().add(ToggleLogin());
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
                        text: 'Have an account? ',
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Login",
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
              )),
        ),
      )),
    );
  }
}
