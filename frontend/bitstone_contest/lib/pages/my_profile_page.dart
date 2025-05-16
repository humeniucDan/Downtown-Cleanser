import 'package:bitstone_contest/common/profile_info.dart';
import 'package:bitstone_contest/models/user_details_model.dart';
import 'package:bitstone_contest/services/user_service.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  UserModel? _user;

  Future<void> getCurrentUser() async {
    final user = await UserService().getCurrentUser();
    if (user != null) {
      setState(() {
        _user = user;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color.fromARGB(255, 254, 55, 108),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 32),
            child: Image.asset("assets/logo-500x500.png", height: 200),
          ),
        ),
        elevation: 2,
      ),
      body:
          _user == null
              ? const Center(
                child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 167, 62, 55),
                ),
              )
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 46,
                        ),
                      ),
                      const Divider(),
                      ProfileInfoComponent(
                        description: "Email",
                        information: _user!.email,
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
