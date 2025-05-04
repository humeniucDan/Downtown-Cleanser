import 'package:bitstone_contest/common/widgets/custom_button.dart';
import 'package:bitstone_contest/common/widgets/custom_dropdown.dart';
import 'package:bitstone_contest/common/widgets/custom_input.dart';
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
  String selectedRole = "Sporter";

  /*void _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords do not match!")));
      return;
    }

    bool succes = await Services.signUpUser(
        name: _nameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        role: selectedRole);
    if (succes) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Signup successful!")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Signup failed. Please try again.")));
    }
  }
  */
  //Replace with our signup function

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            child: Padding(padding: EdgeInsets.only(left: 28, top: 48)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: LayoutBuilder(
              // Added to manage height dynamically
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
                    child: SingleChildScrollView(
                      child: ConstrainedBox(
                        // Ensures full height
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
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: CustomDropdownField(
                                  onChanged:
                                      (role) =>
                                          setState(() => selectedRole = role),
                                  label: "Role",
                                  options: ["Sporter", "Coach"],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 34.0),
                                child: CustomButton(
                                  text: 'Sign Up',
                                  onPressed: () {} /*signup here*/,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    color: Color(0xFFD8DADC),
                                    height: 2,
                                    width: screenWidth * 0.29,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8.0,
                                      right: 8.0,
                                    ),
                                    child: Text(
                                      "Or Register with",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: const Color.fromARGB(
                                          180,
                                          0,
                                          0,
                                          0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Color(0xFFD8DADC),
                                    height: 2,
                                    width: screenWidth * 0.29,
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 16.0,
                                  bottom: 16.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 56,
                                      width: screenWidth * 0.28,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.facebook,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 56,
                                      width: screenWidth * 0.28,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.google,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 56,
                                      width: screenWidth * 0.28,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: FaIcon(
                                          FontAwesomeIcons.apple,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Already have an account? ",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: const Color.fromARGB(
                                          189,
                                          0,
                                          0,
                                          0,
                                        ),
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
