import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/widgets/post_thread.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  List<Map<String, dynamic>> posts = [];

  @override
  void initState() {
    super.initState();
    _getPostData();
  }

  void _getPostData() {
    posts = List.generate(10, (index) {
      return {
        "avatarUrl": faker.image.image(random: true),
        "username": faker.person.name(),
        "userId": "${index + 1}",
        "isVerified": faker.randomGenerator.boolean(),
        "minutes": faker.randomGenerator.integer(59),
        "text": faker.lorem.sentence(),
        "mediaUrl": faker.randomGenerator.boolean()
            ? faker.image.image(random: true)
            : null,
        "replies": faker.randomGenerator.integer(100),
        "likes": faker.randomGenerator.integer(500),
      };
    });
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      _getPostData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Column(
            children: [
              ThreadPost(
                avatarUrl: post["avatarUrl"],
                username: post["username"],
                userId: post["userId"],
                isVerified: post["isVerified"],
                minutes: post["minutes"],
                text: post["text"],
                mediaUrl: post["mediaUrl"],
                replies: post["replies"],
                likes: post["likes"],
              ),
              const Divider(height: 50, thickness: 0.5),
            ],
          );
        },
      ),
    );
  }
}
