import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;

  final ScrollController _scrollController = ScrollController();

  void _onClosePressed() {
    Navigator.of(context).pop();
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  final List<Map<String, dynamic>> replies = [
    {
      "nickname": "user1",
      "comment":
          "츄 진짜 너무 귀여워~내가 불행해하고 있으면 츄가 행복전도사처럼 달려와서 행복하신가요? 하고 물어봐주는거 같음 나는 정말 무력하게 네 행복해요! 밖에 할 수 없도록 만든",
      "likes": 132,
    },
    {
      "nickname": "lovelove",
      "comment": "네가 행복이고 여신이고 귀여움이란다 츄야😄",
      "likes": 367,
    },
    {
      "nickname": "guest123",
      "comment": "인생은 츄 영상을 보기 전과 본 후로 나뉜다, 좋은 영상 감사합니다 🙏",
      "likes": 777,
    },
    {
      "nickname": "user1",
      "comment":
          "츄 진짜 너무 귀여워~내가 불행해하고 있으면 츄가 행복전도사처럼 달려와서 행복하신가요? 하고 물어봐주는거 같음 나는 정말 무력하게 네 행복해요! 밖에 할 수 없도록 만든",
      "likes": 132,
    },
    {
      "nickname": "lovelove",
      "comment": "네가 행복이고 여신이고 귀여움이란다 츄야😄",
      "likes": 367,
    },
    {
      "nickname": "guest123",
      "comment": "인생은 츄 영상을 보기 전과 본 후로 나뉜다, 좋은 영상 감사합니다 🙏",
      "likes": 777,
    },
    {
      "nickname": "user1",
      "comment":
          "츄 진짜 너무 귀여워~내가 불행해하고 있으면 츄가 행복전도사처럼 달려와서 행복하신가요? 하고 물어봐주는거 같음 나는 정말 무력하게 네 행복해요! 밖에 할 수 없도록 만든",
      "likes": 132,
    },
    {
      "nickname": "lovelove",
      "comment": "네가 행복이고 여신이고 귀여움이란다 츄야😄",
      "likes": 367,
    },
    {
      "nickname": "guest123",
      "comment": "인생은 츄 영상을 보기 전과 본 후로 나뉜다, 좋은 영상 감사합니다 🙏",
      "likes": 777,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.75,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        drawerScrimColor: Colors.white,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Text("22796 개의 comments"),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  padding: const EdgeInsets.only(
                    left: Sizes.size16,
                    right: Sizes.size16,
                    bottom: Sizes.size96 + Sizes.size20,
                    top: Sizes.size10,
                  ),
                  separatorBuilder: (context, index) => Gaps.v20,
                  itemBuilder: (context, index) {
                    final replie = replies[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(radius: 18, child: Text("")),
                        Gaps.h10,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                replie['nickname'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Sizes.size14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              Gaps.v3,
                              Text(replie['comment']),
                            ],
                          ),
                        ),
                        Gaps.h10,
                        Column(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.heart,
                              size: Sizes.size20,
                              color: Colors.grey.shade500,
                            ),
                            Gaps.v2,
                            Text(
                              replie['likes'].toString(),
                              style: TextStyle(color: Colors.grey.shade500),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  itemCount: replies.length,
                ),
              ),
              Positioned(
                bottom: 0,
                width: size.width,
                child: BottomAppBar(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Sizes.size16,
                      vertical: Sizes.size10,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade500,
                          foregroundColor: Colors.white,
                          child: const Text("넬님"),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: SizedBox(
                            height: Sizes.size44,
                            child: TextField(
                              onTap: _onStartWriting,
                              expands: true,
                              minLines: null,
                              maxLines: null,
                              textInputAction: TextInputAction.newline,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText: "Add comment...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size12,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size12,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    right: Sizes.size14,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.at,
                                        color: Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      FaIcon(
                                        FontAwesomeIcons.gift,
                                        color: Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      if (_isWriting)
                                        GestureDetector(
                                          onTap: _stopWriting,
                                          child: FaIcon(
                                            FontAwesomeIcons.circleArrowUp,
                                            color: Theme.of(
                                              context,
                                            ).primaryColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
