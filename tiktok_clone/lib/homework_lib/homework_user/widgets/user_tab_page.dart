import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/mokup.dart' as mokup;
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/widgets/post_replie.dart';
import 'package:tiktok_clone/homework_lib/homework_navigation/widgets/post_thread.dart';
import 'package:tiktok_clone/homework_lib/homework_user/widgets/user_set_btn.dart';

class UserTabPage extends StatefulWidget {
  const UserTabPage({
    super.key,
    required this.linkTxt,
    required this.userName,
    required this.replie,
  });

  final String linkTxt;
  final String userName;
  final bool replie;

  @override
  State<UserTabPage> createState() => _UserTabPageState();
}

class _UserTabPageState extends State<UserTabPage> {
  late List<Map<String, dynamic>> postList = [];

  @override
  void initState() {
    super.initState();
    _getPostData();
  }

  void _getPostData() {
    postList = mokup.postList;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.separated(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          final post = postList[index];
          final replies =
              post["replies"] as List? ??
              [
                {"seq": null, "content": "", "userId": "", "date": ""},
              ];
          return Column(
            children: [
              // ThreadPost(
              //   avatarUrl: widget.linkTxt,
              //   username: widget.userName,
              //   userId: widget.userName,
              //   isVerified: false,
              //   minutes: 3,
              //   text: post["document"],
              //   mediaUrl: post["picture"],
              // ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(backgroundImage: NetworkImage(widget.linkTxt)),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.userName),
                            Text(post['document']),
                            if (post['picture'] != null &&
                                post['picture'].toString().isNotEmpty)
                              Image.network(post['picture']),
                            ActionRow(),
                          ],
                        ),
                      ),
                    ),
                    UserSettingBtn(index: index),
                  ],
                ),
              ),
              if (replies.isNotEmpty && widget.replie == true) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: replies.map((reply) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                width: 2,
                                height: 20,
                                color: Colors.grey,
                              ),
                              Gaps.v10,
                              CircleAvatar(
                                radius: 16,
                                backgroundImage: NetworkImage(
                                  'https://picsum.photos/50?random=${reply["seq"]}',
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 25,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (reply["userId"] != null &&
                                      reply["userId"].toString().isNotEmpty)
                                    Text(reply["userId"].toString()),
                                  Gaps.v5,
                                  Text(reply["content"]),
                                  ActionRow(),
                                ],
                              ),
                            ),
                          ),
                          UserSettingBtn(index: index),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ],
          );
        },
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }
}
