import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/homework_page/homework0811_2.dart';

class Homework0811 extends StatefulWidget {
  const Homework0811({super.key});

  @override
  State<Homework0811> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<Homework0811> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _birtdayController = TextEditingController();

  String _username = "";
  String _userEmail = "";
  String _userbirtday = "";

  DateTime initialDate = DateTime.now();

  bool signcheck = false;

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);

    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
        _userEmail = _emailController.text;
        _userbirtday = _birtdayController.text;
      });
    });
  }

  void _setTextFieldDate(DateTime date) {
    final textDate =
        "${date.year.toString().padLeft(4, '0')}"
        "-${date.month.toString().padLeft(2, '0')}"
        "-${date.day.toString().padLeft(2, '0')}";
    _birtdayController.value = TextEditingValue(text: textDate);
  }

  void _NextPageTap() async {
    final result = await Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => Homework0811_2()));
    if (result == true) {
      setState(() {
        // print('가입');
        signcheck = true;
      });
    }
  }

  @override
  void dispose() {
    _birtdayController.dispose();
    super.dispose();
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
            Gaps.v16,
            TextField(
              onChanged: (value) {
                setState(() {
                  _userEmail = value;
                });
              },
              controller: _emailController,
              decoration: InputDecoration(
                labelText: _userEmail.isNotEmpty ? "" : "Email",
                // hintText: "UserEmail",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                suffixIcon: _userEmail.isNotEmpty
                    ? Icon(Icons.check_circle, color: Colors.green)
                    : null,
              ),
              cursorColor: Theme.of(context).primaryColor,
            ),
            Gaps.v16,
            Gaps.v16,
            TextField(
              onChanged: (value) {
                setState(() {
                  _userbirtday = value;
                });
              },
              controller: _birtdayController,
              decoration: InputDecoration(
                labelText: _userbirtday.isNotEmpty ? "" : "BirtDay",
                // hintText: "UserEmail",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                suffixIcon: _userbirtday.isNotEmpty
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
                  color: _username.isEmpty || _userEmail.isEmpty
                      ? Colors.grey.shade400
                      : signcheck == true
                      ? Colors.blue
                      : Theme.of(context).primaryColor,
                ),
                child: GestureDetector(
                  onTap: () => _NextPageTap(),
                  child: Text(
                    signcheck == true ? 'Signin' : 'Next',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 216,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            onDateTimeChanged: _setTextFieldDate,
          ),
        ),
      ),
    );
  }
}
