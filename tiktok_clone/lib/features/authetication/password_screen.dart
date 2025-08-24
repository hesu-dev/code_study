import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authetication/birthday_screen.dart';
import 'package:tiktok_clone/features/authetication/widgets/auth_button.dart';
import 'package:tiktok_clone/features/authetication/widgets/form_btn.dart';
import 'package:tiktok_clone/features/authetication/password_screen.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userRePasswordController =
      TextEditingController();

  final FocusNode _PasswordFocusNode = FocusNode();
  final FocusNode _rePasswordFocusNode = FocusNode();

  String _userPassword = "";
  String _userRePassword = "";
  String _warningMsg = "";

  bool _obscureText = true;
  bool _rePasswordVisble = false;
  bool _msgVisibility = false;

  @override
  void initState() {
    super.initState();
    _PasswordFocusNode.addListener(_msgfn);
    _rePasswordFocusNode.addListener(_msgfn);
    _userPasswordController.addListener(_msgfn);
    _userRePasswordController.addListener(_msgfn);

    _userPasswordController.addListener(() {
      setState(() {
        _userPassword = _userPasswordController.text;
      });
    });
  }

  @override
  void dispose() {
    _userPasswordController.dispose();
    super.dispose();
  }

  void _msgfn() {
    bool hasFocus = _PasswordFocusNode.hasFocus;
    bool hasText = _userPasswordController.text.isNotEmpty;
    bool rehasFocus = _rePasswordFocusNode.hasFocus;
    bool rehasText = _userRePasswordController.text.isNotEmpty;

    if (!hasFocus && !rehasFocus) {
      _warningMsg = "";
      _msgVisibility = false;
      return;
    }

    if (hasFocus && hasText && !rehasText) {
      _warningMsg = "8 to 20 characters.";
      _msgVisibility = true;
      print("hey1");
      return;
    }

    if (rehasFocus && hasText) {
      print("hey2");
      if (_userPasswordController.text == _userRePasswordController.text) {
        _warningMsg = "8 to 20 characters.";
      } else {
        _warningMsg = "Two passwords do not match.";
      }
      _msgVisibility = true;
      return;
    }

    _msgVisibility = true;
    // if (_userPasswordController.text.isNotEmpty) {
    //   _msgVisibility = true;
    // } else if (_userPasswordController.text == _userRePasswordController.text) {
    //   _rePasswordFocusNode.addListener(
    //     () => setState(() {
    //       _warningMsg = "Two passwords do not match.";
    //     }),
    //   );
    // } else {
    //   _warningMsg = "8 to 20 characters.";
    // }
  }

  //비밀번호 초기화
  void _onClearTap() {
    _userPasswordController.clear();
  }

  //비밀번호 아이콘
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  //글자 제한 함수
  bool _isPasswordValid() {
    return _userPassword.isNotEmpty && _userPassword.length > 3;
  }

  _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (!_isPasswordValid()) return;
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const BirthdayScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Sign Up(3)"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "Create User Password",
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
                controller: _userPasswordController,
                focusNode: _PasswordFocusNode,
                // onEditingComplete: _onSubmdfit,
                obscureText: _obscureText,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "User PassWord",
                  // prefixIcon: Icon(Icons.ac_unit),
                  // suffixIcon: Icon(Icons.ac_unit),
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _onClearTap();
                        },
                        child: FaIcon(
                          FontAwesomeIcons.solidCircleXmark,
                          color: Colors.grey,
                          size: Sizes.size20,
                        ),
                      ),
                      Gaps.h10,
                      GestureDetector(
                        onTap: _toggleObscureText,
                        child: FaIcon(
                          _obscureText == true
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          color: Colors.grey,
                          size: Sizes.size20,
                        ),
                      ),
                    ],
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                cursorColor: Theme.of(context).primaryColor,
              ),
              Gaps.v5,
              Visibility(
                visible: _rePasswordVisble,
                child: TextField(
                  controller: _userRePasswordController,
                  obscureText: _obscureText,
                  autocorrect: false,
                  focusNode: _rePasswordFocusNode,
                  decoration: InputDecoration(
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _onClearTap();
                          },
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleXmark,
                            color: Colors.grey,
                            size: Sizes.size20,
                          ),
                        ),
                        Gaps.h10,
                        GestureDetector(
                          onTap: _toggleObscureText,
                          child: FaIcon(
                            _obscureText == true
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: Colors.grey,
                            size: Sizes.size20,
                          ),
                        ),
                      ],
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  cursorColor: Theme.of(context).primaryColor,
                ),
              ),
              Gaps.v10,
              Visibility(
                visible: _msgVisibility,
                child: Row(
                  children: [
                    FaIcon(
                      _isPasswordValid()
                          ? FontAwesomeIcons.circleCheck
                          : FontAwesomeIcons.x,
                      size: Sizes.size16,
                      color: _isPasswordValid() ? Colors.cyan : Colors.black,
                    ),
                    Gaps.h12,
                    Text(_warningMsg),
                  ],
                ),
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () {
                  if (_isPasswordValid() &&
                      _userPassword.isNotEmpty &&
                      _rePasswordVisble == false) {
                    setState(() {
                      _rePasswordVisble = true;
                    });
                  }
                  _onSubmit();
                },
                child: FormButton(disable: !_isPasswordValid()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
