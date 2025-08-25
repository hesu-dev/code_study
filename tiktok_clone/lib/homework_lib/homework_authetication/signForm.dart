// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/number_page.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/switchcheck.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/appbar.dart';

class Signform extends StatefulWidget {
  const Signform({super.key});

  @override
  State<Signform> createState() => _SignformState();
}

class _SignformState extends State<Signform> {
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
    ).push(MaterialPageRoute(builder: (context) => SwitchPage()));
    if (result == true) {
      setState(() {
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
      appBar: PersonalAppbar(title: "회원가입"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              Text(
                "회원 정보 입력",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "입력한 정보는 언제든 변경할 수 있습니다.",
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
                  labelText: _username.isNotEmpty ? "" : "이름",
                  hintText: "이름",
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
                  labelText: _userEmail.isNotEmpty ? "" : "E-mail",
                  hintText: "E-mail",
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
                keyboardType: TextInputType.emailAddress,
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

              Visibility(
                visible: signcheck == false,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
                    decoration: BoxDecoration(
                      color: _username.isEmpty || _userEmail.isEmpty
                          ? Colors.grey.shade400
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
              ),
              Visibility(
                visible: signcheck == true,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
                    decoration: BoxDecoration(color: Colors.blue),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                HomeworkPinCheck(email: 'hs0647@naver.com'),
                          ),
                        );
                      },
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: Sizes.size350,
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          initialDateTime: initialDate,
          onDateTimeChanged: _setTextFieldDate,
        ),
      ),
    );
  }
}
