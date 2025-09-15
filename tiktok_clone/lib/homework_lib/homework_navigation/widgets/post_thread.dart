import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/widgets/post_header.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/widgets/post_replie.dart';

import '../../homework_common/theme_provider.dart';

class ThreadPost extends StatelessWidget {
  const ThreadPost({
    super.key,
    required this.avatarUrl,
    required this.username,
    required this.userId,
    required this.isVerified,
    required this.minutes,
    required this.text,
    this.mediaUrl,
    this.replies = 0,
    this.likes = 0,
  });

  final String avatarUrl;
  final String username;
  final String userId;
  final bool isVerified;
  final int minutes;
  final String text;
  final String? mediaUrl;
  final int replies;
  final int likes;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostHeader(
            avatarUrl: avatarUrl,
            username: username,
            userId: userId,
            isVerified: isVerified,
            minutesAgo: minutes,
          ),
          const SizedBox(height: 8),
          Text(text, style: TextStyle(color: themeProvider.textColor)),
          const SizedBox(height: 10),
          mediaUrl != null ? Media(url: mediaUrl!) : Container(),
          const SizedBox(height: 10),
          const ActionRow(),
          const SizedBox(height: 6),
          StatsRow(replies: replies, likes: likes),
        ],
      ),
    );
  }
}
