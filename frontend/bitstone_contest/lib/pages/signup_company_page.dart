import 'package:bitstone_contest/common/widgets/custom_button.dart';
import 'package:bitstone_contest/common/widgets/custom_dropdown.dart';
import 'package:bitstone_contest/common/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupCompanyPage extends StatefulWidget {
  const SignupCompanyPage({super.key});

  @override
  State<SignupCompanyPage> createState() => _SignupCompanyPageState();
}

class _SignupCompanyPageState extends State<SignupCompanyPage> {
  @override
  //data for the API
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  String selectedRole = "Company";

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
                                  label: 'Company Name',
                                  placeholder: "Full Company Name",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18),
                                child: CustomInputField(
                                  controller: _emailController,
                                  label: 'Company Email',
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
                                  label: "What field is the company in?",
                                  options: [
                                    "Road maintenance",
                                    " Electrical services",
                                    "Plumbing & water systems",
                                    "Waste management",
                                    " Pest control",
                                    "Other",
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 18.0),
                                child: CustomInputField(
                                  controller: _confirmPasswordController,
                                  label:
                                      'If other was selected please write here',
                                  isPassword: false,
                                  placeholder: "ex: Public safety equipment:",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: CustomButton(
                                  text: 'Sign Up',
                                  onPressed: () {} /*signup here*/,
                                ),
                              ),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   children: [
                              //     Container(
                              //       color: Color(0xFFD8DADC),
                              //       height: 2,
                              //       width: screenWidth * 0.29,
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.only(
                              //         left: 8.0,
                              //         right: 8.0,
                              //       ),
                              //       child: Text(
                              //         "Or Register with",
                              //         style: TextStyle(
                              //           fontSize: 14,
                              //           fontWeight: FontWeight.w400,
                              //           color: const Color.fromARGB(
                              //             180,
                              //             0,
                              //             0,
                              //             0,
                              //           ),
                              //         ),
                              //       ),
                              //     ),
                              //     Container(
                              //       color: Color(0xFFD8DADC),
                              //       height: 2,
                              //       width: screenWidth * 0.29,
                              //     ),
                              //   ],
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.only(
                              //     top: 16.0,
                              //     bottom: 16.0,
                              //   ),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceEvenly,
                              //     crossAxisAlignment: CrossAxisAlignment.center,
                              //     children: [
                              //       Container(
                              //         height: 56,
                              //         width: screenWidth * 0.28,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(16),
                              //           border: Border.all(color: Colors.grey),
                              //         ),
                              //         child: IconButton(
                              //           onPressed: () {},
                              //           icon: FaIcon(
                              //             FontAwesomeIcons.facebook,
                              //             size: 24,
                              //           ),
                              //         ),
                              //       ),
                              //       Container(
                              //         height: 56,
                              //         width: screenWidth * 0.28,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(16),
                              //           border: Border.all(color: Colors.grey),
                              //         ),
                              //         child: IconButton(
                              //           onPressed: () {},
                              //           icon: FaIcon(
                              //             FontAwesomeIcons.google,
                              //             size: 24,
                              //           ),
                              //         ),
                              //       ),
                              //       Container(
                              //         height: 56,
                              //         width: screenWidth * 0.28,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(16),
                              //           border: Border.all(color: Colors.grey),
                              //         ),
                              //         child: IconButton(
                              //           onPressed: () {},
                              //           icon: FaIcon(
                              //             FontAwesomeIcons.apple,
                              //             size: 24,
                              //           ),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: 8,
                                  bottom: 16,
                                ),
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
