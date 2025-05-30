import 'package:bitstone_contest/common/widgets/custom_button.dart';
import 'package:bitstone_contest/common/widgets/custom_dropdown.dart';
import 'package:bitstone_contest/common/widgets/custom_input.dart';
import 'package:bitstone_contest/models/user_register_model.dart';
import 'package:bitstone_contest/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupUserPage extends StatefulWidget {
  const SignupUserPage({super.key});

  @override
  State<SignupUserPage> createState() => _SignupUserPageState();
}

class _SignupUserPageState extends State<SignupUserPage> {
  @override
  //data for the API
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  //The signup function that uses the AuthService
  Future<void> _handleSignup() async {
    final fullName = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (fullName.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill all fields')));
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Passwords do not match')));
      return;
    }

    final newUser = UserRegisterModel(
      fullName: fullName,
      email: email,
      password: password,
    );

    final authService = AuthService();
    final success = await authService.signup(newUser);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup successful! Please log in.')),
      );
      Navigator.pushNamed(context, '/');
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Signup failed!')));
    }
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 78, 123),
      body: Stack(
        children: [
          Container(
            child: Padding(padding: EdgeInsets.only(left: 28, top: 48)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Container(
                  height: constraints.maxHeight,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFCFC),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(108),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 20.0,
                      top: 58.0,
                      bottom: 0.0,
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 24.0),
                              child: Text(
                                "Sign up",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: CustomInputField(
                                controller: _nameController,
                                label: 'Full Name',
                                placeholder: "First name Last name",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18),
                              child: CustomInputField(
                                controller: _emailController,
                                label: 'Email',
                                placeholder: "example@gmail.com",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: CustomInputField(
                                controller: _passwordController,
                                label: 'Create password',
                                isPassword: true,
                                placeholder: "must be 8 characters",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 18.0),
                              child: CustomInputField(
                                controller: _confirmPasswordController,
                                label: 'Confirm password',
                                isPassword: true,
                                placeholder: "repeat password",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: CustomButton(
                                text: 'Sign Up',
                                onPressed: _handleSignup,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [],
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Already have an account? ",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: const Color.fromARGB(189, 0, 0, 0),
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Log In",
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.pushNamed(
                                                  context,
                                                  '/',
                                                );
                                              },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
