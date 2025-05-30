import 'package:bitstone_contest/common/widgets/history_photo_card.dart';
import 'package:bitstone_contest/models/photo_model.dart';
import 'package:bitstone_contest/models/user_details_model.dart';
import 'package:bitstone_contest/services/user_service.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final UserService _userService = new UserService();
  late UserModel? _user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = await _userService.getCurrentUser();
      setState(() {
        print(user);
        _user = user;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print("Error fetching user data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
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
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // If no user data or error, show a message
    if (_user == null || _user!.images.isEmpty) {
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
        body: Center(
          child: Text("Could not fetch user data or no uploads yet."),
        ),
      );
    }

    final List<PhotoModel> images = _user!.images;

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
      backgroundColor: Color.fromARGB(255, 245, 78, 123),
      body: ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: ImageHistoryCard(image: images[index]),
          );
        },
      ),
    );
  }
}
