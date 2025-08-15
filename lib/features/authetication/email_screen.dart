import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FaIcon;
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authetication/widgets/auth_button.dart';
import 'package:tiktok_clone/features/authetication/widgets/form_btn.dart';
import 'package:tiktok_clone/features/authetication/password_screen.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController _useremailController = TextEditingController();
  String _userEmail = "";

  @override
  void initState() {
    super.initState();
    _useremailController.addListener(() {
      setState(() {
        _userEmail = _useremailController.text;
      });
    });
  }

  @override
  void dispose() {
    _useremailController.dispose();
    super.dispose();
  }

  String? _isEmailValid() {
    if (_userEmail.isEmpty) return null;
    //이메일 형식 체크 정규식
    final regExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!regExp.hasMatch(_useremailController.text)) {
      return "이메일 형식이 아닙니다 | Not valid";
    }
    return null;
  }

  _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_userEmail.isEmpty || _isEmailValid() != null) return;
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const PasswordScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Sign Up(2)"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "Create User Email",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v10,
              const Text(
                "You Can alaways chage this later",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _useremailController,
                onEditingComplete: _onSubmit,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "User Email",
                  errorText: _isEmailValid(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () {
                  _onSubmit();
                },
                child: FormButton(
                  disable: _userEmail.isEmpty || _isEmailValid() != null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
