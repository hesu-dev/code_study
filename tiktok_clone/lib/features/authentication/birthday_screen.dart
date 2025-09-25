import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/view_models/signup_view_model.dart';
import 'package:tiktok_clone/features/authentication/widgets/form_btn.dart';
import 'package:tiktok_clone/features/onboarding/interests_screen.dart';

class BirthdayScreen extends ConsumerStatefulWidget {
  const BirthdayScreen({super.key});

  @override
  ConsumerState<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends ConsumerState<BirthdayScreen> {
  final TextEditingController _birthDayController = TextEditingController();

  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _setTextFieldDate(initialDate);
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _birthDayController.value = TextEditingValue(text: textDate);
  }

  @override
  void dispose() {
    _birthDayController.dispose();
    super.dispose();
  }

  void _onNextPageTap() {
    // print('--------');
    // print(ref.read(signUpForm));
    // print(ref.read(signUpProvider));
    // Navigator.of(
    //   context,
    // ).push(MaterialPageRoute(builder: (context) => const InterestsScreen()));
    ref.read(signUpProvider.notifier).signUp();
    // context.goNamed(InterestsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, title: Text("Sign Up(4)")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.size28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v40,
            Text(
              "Create User Birthday",
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
              enabled: false,
              controller: _birthDayController,
              decoration: const InputDecoration(
                hintText: "BirthDay",
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
                _onNextPageTap();
              },
              child: FormButton(disable: ref.watch(signUpProvider).isLoading),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        height: Sizes.size350,
        child: CupertinoDatePicker(
          maximumDate: initialDate,
          initialDateTime: initialDate,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: _setTextFieldDate,
        ),
      ),
    );
  }
}
