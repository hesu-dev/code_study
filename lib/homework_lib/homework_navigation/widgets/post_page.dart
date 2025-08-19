import 'package:flutter/material.dart';
import 'package:faker/faker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // void main() {
  //   print(faker.company.name());
  //   print(faker.job.title());
  //   print(faker.sport.name());
  //   print(faker.date.dateTime(minYear: 2000, maxYear: 2020));
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: Sizes.size80),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(children: [Container()]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(faker.sport.name()),
                      FaIcon(FontAwesomeIcons.check),
                      SizedBox(width: Sizes.size10),
                      Text(
                        '',
                      ), //faker.date.dateTime(minYear: 2000, maxYear: 2020)
                      FaIcon(FontAwesomeIcons.spinner),
                    ],
                  ),
                  Gaps.v10,
                  Text(faker.job.title()), //제목
                  Container(
                    color: Colors.black,
                    height: Sizes.size20,
                    width: Sizes.size20,
                  ), //이미지
                  Row(
                    children: [
                      Row(
                        children: [
                          FaIcon(FontAwesomeIcons.heart),
                          FaIcon(FontAwesomeIcons.message),
                          FaIcon(FontAwesomeIcons.retweet),
                          FaIcon(FontAwesomeIcons.paperPlane),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
