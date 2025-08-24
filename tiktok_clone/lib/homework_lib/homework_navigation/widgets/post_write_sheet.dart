import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:tiktok_clone/homework_lib/homework_authetication/widget/appbar.dart';

class PostWriteSheet extends StatelessWidget {
  const PostWriteSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PersonalAppbar(title: "새 글 작성"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(
                      faker.image.image(random: true),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'You username',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      decoration: const InputDecoration(
                        // labelText: '포스트 내용을 입력하세요',
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        alignLabelWithHint: true,
                      ),
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
              IconButton(icon: const Icon(Icons.attach_file), onPressed: () {}),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Post', style: TextStyle(fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
