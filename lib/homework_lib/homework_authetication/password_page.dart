import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authetication/birthday_screen.dart';
import 'package:tiktok_clone/features/authetication/widgets/form_btn.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/appbar.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final TextEditingController _userPasswordController = TextEditingController();
  final TextEditingController _userRePasswordController =
      TextEditingController();

  final FocusNode _passwordFocusNode = FocusNode();
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
    _passwordFocusNode.addListener(_msgfn);
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
    bool hasFocus = _passwordFocusNode.hasFocus;
    bool hasText = _userPasswordController.text.isNotEmpty;
    bool rehasFocus = _rePasswordFocusNode.hasFocus;
    bool rehasText = _userRePasswordController.text.isNotEmpty;

    if (!hasFocus && !rehasFocus) {
      _warningMsg = "";
      _msgVisibility = false;
      return;
    }

    if (hasFocus && hasText && !rehasText) {
      _warningMsg = "비밀번호는 8자 이상으로 기입해주세요.";
      _msgVisibility = true;
      return;
    }

    if (rehasFocus && hasText) {
      if (_userPasswordController.text == _userRePasswordController.text) {
        _warningMsg = "비밀번호는 8자 이상으로 기입해주세요.";
      } else {
        _warningMsg = "두개의 비밀번호가 맞지 않습니다";
      }
      _msgVisibility = true;
      return;
    }

    _msgVisibility = true;
  }

  //비밀번호 초기화
  void _onClearTap(TextEditingController controller) {
    controller.clear();
  }

  //비밀번호 아이콘
  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _isPasswordValid(bool rePasswordVisble) {
    if (rePasswordVisble == false) {
      rePasswordVisble = true;
      return _userPasswordController.text.length > 3;
    } else {
      return _userRePasswordController.text.length > 3;
    }
  }

  _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onSubmit() {
    if (_rePasswordVisble == true && _isPasswordValid(_rePasswordVisble)) {
      Navigator.pushNamed(context, "/interest");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PersonalAppbar(title: "회원가입"),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.size28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gaps.v40,
              const Text(
                "비밀번호 입력",
                style: TextStyle(
                  fontSize: Sizes.size20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Gaps.v10,
              const Text(
                "입력한 비밀번호는 차후에 다시 변경할 수 있습니다",
                style: TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              Gaps.v16,
              TextField(
                controller: _userPasswordController,
                focusNode: _passwordFocusNode,
                obscureText: _obscureText,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: "비밀번호 입력",
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _onClearTap(_userPasswordController);
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
                            _onClearTap(_userRePasswordController);
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
                      _isPasswordValid(_rePasswordVisble)
                          ? FontAwesomeIcons.circleCheck
                          : FontAwesomeIcons.x,
                      size: Sizes.size16,
                      color: _isPasswordValid(_rePasswordVisble)
                          ? Colors.cyan
                          : Colors.black,
                    ),
                    Gaps.h12,
                    Text(_warningMsg),
                  ],
                ),
              ),
              Gaps.v40,
              GestureDetector(
                onTap: () {
                  if (_isPasswordValid(_rePasswordVisble) &&
                      _userPassword.isNotEmpty &&
                      _rePasswordVisble == false) {
                    setState(() {
                      _rePasswordVisble = true;
                    });
                  }
                  _onSubmit();
                },
                child: FormButton(
                  disable: !_isPasswordValid(_rePasswordVisble),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
