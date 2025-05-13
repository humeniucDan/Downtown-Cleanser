import 'package:bitstone_contest/common/widgets/custom_button.dart';
import 'package:bitstone_contest/common/widgets/select_register_box.dart';
import 'package:flutter/material.dart';

class SignupSelectionWeb extends StatefulWidget {
  const SignupSelectionWeb({super.key});

  @override
  State<SignupSelectionWeb> createState() => _SignupSelectionWebState();
}

class _SignupSelectionWebState extends State<SignupSelectionWeb> {
  int selectedIndex = -1;

  void selectBox(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text("Creare Cont"))),
      backgroundColor: Color(0xfffff3f3),
      body: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14.0),
        child: SingleChildScrollView(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Voi utiliza aplicatia ca:",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 16,
                      left: 2,
                      right: 2,
                    ),
                    child: GestureDetector(
                      onTap: () => selectBox(0),
                      child: RegisterBox(
                        title: "Institutie publica",
                        description: "Veti putea vedea toate problemele gasite",
                        imagePath: "assets/institution_il.png",
                        isSelected: selectedIndex == 0,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    child: GestureDetector(
                      onTap: () => selectBox(1),
                      child: RegisterBox(
                        title: "Utilizator",
                        description:
                            "Vei putea face poze la problemele din oras",
                        imagePath: "assets/user_il.png",
                        isSelected: selectedIndex == 1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2, right: 2, top: 16),
                    child: CustomButton(
                      text: "Confirm",
                      onPressed: () {
                        if (selectedIndex == 1) {
                          Navigator.pushNamed(context, '/signup_user');
                        } else {
                          Navigator.pushNamed(context, '/signup_company');
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
