import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/homework_lib/homework_common/theme_provider.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/widgets/post_bottom_sheet.dart';

// ignore: unused_element
class PostHeader extends StatelessWidget {
  final String avatarUrl;
  final String username;
  final String userId;
  final bool isVerified;
  final int minutesAgo;

  const PostHeader({
    super.key,
    required this.avatarUrl,
    required this.username,
    required this.userId,
    required this.isVerified,
    required this.minutesAgo,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final textStyle = Theme.of(context).textTheme.bodyMedium!;
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            avatarUrl,
            width: 44,
            height: 44,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(width: 44, height: 44, color: Colors.grey[300]);
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 44,
                height: 44,
                color: Colors.grey[400],
                child: const Icon(Icons.person, color: Colors.white),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            username,
            style: textStyle.copyWith(
              fontWeight: FontWeight.w700,
              color: themeProvider.textColor,
            ),
          ),
        ),
        Row(
          children: [
            if (isVerified) ...[const SizedBox(width: 5), _VerifiedBadge()],
            const SizedBox(width: 20),
            Text(
              '• ${minutesAgo}m',
              style: textStyle.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(CupertinoIcons.ellipsis_vertical),
          onPressed: () {
            showModalBottomSheet<void>(
              backgroundColor: Colors.white,
              showDragHandle: true,
              context: context,
              builder: (BuildContext context) {
                return CustomBottomSheet(userId: userId);
              },
            );
          },
          tooltip: '더보기',
        ),
      ],
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 18,
      height: 18,
      decoration: const BoxDecoration(
        // color: olor(0xFF1DA1F2),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.check, size: 12, color: Colors.white),
    );
  }
}
