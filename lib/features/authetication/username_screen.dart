import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _usernameController = TextEditingController();

  String _username = "";
  String _userEmail = "";

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
        _userEmail = _emailController.text;
      });
      // _usernameEdit = !_usernameEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: Text("Sign Up")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            Text(
              "Create Usrname",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "You Can alaways chage this later",
              style: TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gaps.v16,
            TextField(
              onChanged: (value) {
                setState(() {
                  _username = value;
                });
              },
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: _username.isNotEmpty ? "" : "Username",
                hintText: "Username",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                suffixIcon: _username.isNotEmpty
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : null,
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),

            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
                decoration: BoxDecoration(
                  color: _username.isEmpty
                      ? Colors.grey.shade400
                      : Theme.of(context).primaryColor,
                ),
                child: const Text(
                  'Next',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
