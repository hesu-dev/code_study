import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/mokup.dart';

class InterestsDetailPage extends StatelessWidget {
  const InterestsDetailPage({super.key, required this.category});

  final String category;

  @override
  Widget build(BuildContext context) {
    final subCategories = interestsWithSub[category] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text("$category 세부 카테고리")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            for (var sub in subCategories)
              ChoiceChip(
                label: Text(sub),
                selected: false,
                onSelected: (selected) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("$sub 선택됨")));
                },
              ),
          ],
        ),
      ),
    );
  }
}
