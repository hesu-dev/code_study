import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Media extends StatelessWidget {
  final String url;
  const Media({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: AspectRatio(
        aspectRatio: 1.2,
        child: Ink.image(image: NetworkImage(url), fit: BoxFit.cover),
      ),
    );
  }
}

class ActionRow extends StatelessWidget {
  const ActionRow();

  @override
  Widget build(BuildContext context) {
    final iconSize = 26.0;
    return Row(
      children: [
        IconButton(
          icon: const Icon(CupertinoIcons.heart),
          onPressed: () {},
          iconSize: iconSize,
          splashRadius: 22,
        ),
        const SizedBox(width: 6),
        IconButton(
          icon: const Icon(CupertinoIcons.chat_bubble),
          onPressed: () {},
          iconSize: iconSize,
          splashRadius: 22,
        ),
        const SizedBox(width: 6),
        IconButton(
          icon: const Icon(CupertinoIcons.arrow_2_squarepath),
          onPressed: () {},
          iconSize: iconSize,
          splashRadius: 22,
        ),
        const SizedBox(width: 6),
        IconButton(
          icon: const Icon(CupertinoIcons.paperplane),
          onPressed: () {},
          iconSize: iconSize,
          splashRadius: 22,
        ),
      ],
    );
  }
}

/// 리플/좋아요 수 표시
class StatsRow extends StatelessWidget {
  final int replies;
  final int likes;

  const StatsRow({required this.replies, required this.likes});

  @override
  Widget build(BuildContext context) {
    final grey = Theme.of(
      context,
    ).textTheme.bodyMedium!.copyWith(color: Colors.grey[700]);
    return Padding(
      padding: const EdgeInsets.only(left: 6.0),
      child: Text(
        '${replies > 0 ? '$replies replies · ' : ''}${likes > 0 ? '$likes likes' : ''}',
        style: grey,
      ),
    );
  }
}
