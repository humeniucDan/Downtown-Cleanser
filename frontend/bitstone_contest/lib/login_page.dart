import 'package:bitstone_contest/common/widgets/custom_button.dart';
import 'package:bitstone_contest/common/widgets/custom_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

//change the insets to be responsive
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFFF3066),
      body: Stack(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 28, top: 28),
              child: Text(
                "Let's save the city",
                style: TextStyle(color: Colors.white, fontSize: 64),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 220),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFFFFCFC),
                borderRadius: BorderRadius.only(topRight: Radius.circular(108)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20.0,
                  top: 24.0,
                  bottom: 0.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 42.0),
                      child: Text(
                        "Log in",
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
                      padding: const EdgeInsets.only(bottom: 24),
                      child: CustomInputField(
                        label: 'Email Address',
                        controller: _emailController,
                      ),
                    ),
                    CustomInputField(
                      label: 'Password',
                      isPassword: true,
                      controller: _passwordController,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.50),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/forgot_password');
                        },
                        child: Text(
                          'Forgot password?',
                          style: GoogleFonts.interTight(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 12.0),
                      child: CustomButton(
                        text: 'Log In',
                        onPressed: () {
                          Navigator.pushNamed(context, '/map');
                        },
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Container(
                    //       color: Color(0xFFD8DADC),
                    //       height: 2,
                    //       width: screenWidth * 0.35,
                    //     ),
                    //     Padding(
                    //       padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    //       child: Text(
                    //         "Or Login with",
                    //         style: TextStyle(
                    //           fontSize: 14,
                    //           fontWeight: FontWeight.w400,
                    //           color: const Color.fromARGB(180, 0, 0, 0),
                    //         ),
                    //       ),
                    //     ),
                    //     Container(
                    //       color: Color(0xFFD8DADC),
                    //       height: 2,
                    //       width: screenWidth * 0.30,
                    //     ),
                    //   ],
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    //           icon: FaIcon(FontAwesomeIcons.facebook, size: 24),
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
                    //           icon: FaIcon(FontAwesomeIcons.google, size: 24),
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
                    //           icon: FaIcon(FontAwesomeIcons.apple, size: 24),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: TextStyle(
                              fontSize: 14,
                              color: const Color.fromARGB(189, 0, 0, 0),
                              fontWeight: FontWeight.w400,
                            ),
                            children: [
                              TextSpan(
                                text: "Sign up",
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
                                          '/signup_selection',
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
        ],
      ),
    );
  }
}
