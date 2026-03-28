import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final TextEditingController _controller = TextEditingController();

  void _insertEmoji(String emoji) {
    final text = _controller.text;
    final selection = _controller.selection;

    final newText = text.replaceRange(selection.start, selection.end, emoji);

    final emojiLength = emoji.length;
    _controller.text = newText;
    _controller.selection = TextSelection.collapsed(
      offset: selection.start + emojiLength,
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
          "🔥 MOOD 트래커 🔥",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How do you feel?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Write it down here!",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "What's your mood?",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: ["😊", "😍", "🥳", "🥲", "😡", "🤔", "🤢"].map((emoji) {
                return GestureDetector(
                  onTap: () => _insertEmoji(emoji),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Text(emoji, style: const TextStyle(fontSize: 24)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Post",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
