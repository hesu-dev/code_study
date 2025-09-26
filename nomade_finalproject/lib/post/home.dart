import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nomade_finalproject/post/post_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showActionSheet(BuildContext context, String message) {
    showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CupertinoActionSheet(
        title: const Text("Delete note"),
        message: const Text("Are you sure you want to do this?"),
        actions: [
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(ctx);
              // 실제 삭제 로직 추가 가능
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("게시글을 삭제하였습니다.")));
            },
            child: const Text("Delete"),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.pop(ctx),
          isDefaultAction: true,
          child: const Text("Cancel"),
        ),
      ),
    );
  }

  Widget _buildMoodCard(
    BuildContext context,
    String emoji,
    String text,
    String timeAgo,
  ) {
    return GestureDetector(
      onLongPress: () {
        _showActionSheet(context, text);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF8FD3C9),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mood: $emoji",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(text),
            const SizedBox(height: 8),
            Text(
              timeAgo,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8DFB6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8DFB6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "🔥 MOOD 🔥",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMoodCard(
              context,
              "😍",
              "Today I feel amazing! I really like Flutter, I love building beautiful things!",
              "30 minutes ago",
            ),
            _buildMoodCard(context, "🥺", "서울에 비가 많이 와요 ㅠㅠ", "1 day ago"),
            _buildMoodCard(
              context,
              "🥳",
              "It was my birthday today! I feel great!",
              "2 days ago",
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFE8DFB6),
        onTap: (index) {
          if (index == 0) {
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PostPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.edit), label: ''),
        ],
      ),
    );
  }
}
