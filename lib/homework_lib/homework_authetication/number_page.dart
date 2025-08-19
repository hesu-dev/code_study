import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authetication/widgets/form_btn.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/appbar.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/otp_box.dart';

class HomeworkPinCheck extends StatefulWidget {
  const HomeworkPinCheck({super.key, required this.email, this.length = 4});

  final String email;
  final int length;

  @override
  State<HomeworkPinCheck> createState() => _HomeworkPinCheckState();
}

class _HomeworkPinCheckState extends State<HomeworkPinCheck> {
  final TextEditingController _OtpTxtcontroller = TextEditingController();

  bool clear = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String emailTxt = widget.email;

    return Scaffold(
      appBar: PersonalAppbar(title: "회원가입"),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {},
          child: Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: Sizes.size40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Gaps.v32,
                Text(
                  '입력하신 이메일로 코드를 보냈습니다.', //We sent you a code
                  style: TextStyle(color: Colors.black, fontSize: Sizes.size20),
                ),
                Gaps.v20,
                Text(
                  '$emailTxt로 전송된 코드를 입력해주세요.\n', //Enter it below to verify

                  style: TextStyle(color: Colors.grey),
                ),
                Gaps.v20,
                Center(
                  child: OtpBox(
                    txtController: _OtpTxtcontroller,
                    fieldlength: widget.length,
                  ),
                ),

                Gaps.v20,
                Visibility(
                  visible: clear == true,
                  child: FaIcon(
                    FontAwesomeIcons.circleCheck,
                    color: Colors.grey,
                    size: Sizes.size20,
                  ),
                ),
                Gaps.v20,
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, "/receive");
                  },
                  child: Text(
                    "Didn't receive email?",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                // FormButton(disable: true),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/password");
          },
          child: FormButton(disable: false),
        ),
      ),
    );
  }
}
