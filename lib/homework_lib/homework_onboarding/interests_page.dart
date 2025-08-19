import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/mokup.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/appbar.dart';
import 'package:tiktok_clone/homework_lib/homework_onboarding/Interests_detail_page.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({super.key});

  @override
  State<InterestsPage> createState() => _InterestsPageState();
}

String? _selectedCategory;

class _InterestsPageState extends State<InterestsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersonalAppbar(title: "관심분야"),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Sizes.size24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gaps.v16,
            Text(
              "내 관심분야 PICK!", //Choose your interests
              style: TextStyle(
                fontSize: Sizes.size28,
                fontWeight: FontWeight.bold,
              ),
            ), //Choose your interests
            Gaps.v16,
            Text("선택한 취향에 맞춰 추천 피드에 게시 됩니다"), //Get better video recommendations
            Gaps.v64,
            Expanded(
              child: SingleChildScrollView(
                child: Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    for (var interest in interestsWithSub.keys)
                      ChoiceChip(
                        label: Text(interest),
                        selected: _selectedCategory == interest,
                        onSelected: (bool selected) {
                          setState(() {
                            _selectedCategory = selected ? interest : null;
                          });
                          if (selected) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    InterestsDetailPage(category: interest),
                              ),
                            );
                          }
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
