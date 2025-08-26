import 'package:faker/faker.dart' as f;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/homework_lib/homework_user/widgets/user_setting.dart';
import 'package:tiktok_clone/homework_lib/homework_user/widgets/user_tab_bar.dart';
import 'package:tiktok_clone/homework_lib/homework_user/widgets/user_tab_page.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  final String _userLink = "https://github.com/hesu-dev/";

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    String avatarLink = f.faker.image.image(random: true);
    String userName = "Nell";
    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: Colors.white,
                leading: IconButton(
                  onPressed: () {},
                  icon: FaIcon(FontAwesomeIcons.earth, size: Sizes.size20),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.instagram,
                      size: Sizes.size20,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      print('test');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => UserSettingPage()),
                      );
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.bars,
                      size: Sizes.size20,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Gaps.v20,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: Sizes.size24,
                                ),
                              ),
                              Gaps.h5,
                              Row(
                                children: [
                                  const Text(
                                    "nell_14",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: Sizes.size16,
                                    ),
                                  ),
                                  Gaps.h5,
                                  Container(
                                    padding: const EdgeInsets.all(Sizes.size8),
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(118, 225, 225, 225),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(Sizes.size24),
                                      ),
                                    ),
                                    child: const Text(
                                      'threads.net',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w200,
                                        fontSize: Sizes.size14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              const Text(
                                "20 / FUB Free",
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: Sizes.size16,
                                ),
                              ),
                              Gaps.h5,
                            ],
                          ),
                          CircleAvatar(
                            radius: 35,
                            foregroundImage: NetworkImage(avatarLink),
                            // foregroundImage: NetworkImage(
                            //   "https://avatars.githubusercontent.com/u/3612017",
                            // ),
                          ),
                        ],
                      ),
                      Gaps.v14,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const FaIcon(
                            FontAwesomeIcons.mapPin,
                            size: Sizes.size12,
                          ),
                          Gaps.h4,
                          Text(
                            "대한민국 서울시",
                            style: TextStyle(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gaps.h4,
                          const VerticalDivider(
                            width: Sizes.size8,
                            thickness: Sizes.size1,
                            color: Colors.grey,
                            indent: Sizes.size14,
                            endIndent: Sizes.size14,
                          ),
                          const FaIcon(
                            FontAwesomeIcons.link,
                            size: Sizes.size12,
                          ),
                          Gaps.h4,
                          GestureDetector(
                            onTap: () => _launchUrl(_userLink),
                            child: Text(
                              _userLink,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.blue, // 링크 느낌
                                decoration: TextDecoration.underline, // 밑줄
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Gaps.v24,
                      SizedBox(
                        height: Sizes.size48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "999K",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Sizes.size18,
                                  ),
                                ),
                                Gaps.h5,
                                Text(
                                  "Followers",
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Gaps.v14,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(Sizes.size12),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Edit profile',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: Sizes.size12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(Sizes.size12),
                                ),
                                border: Border.all(
                                  color: Colors.grey,
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Share profile',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Gaps.v20,
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(delegate: UserTabBar(), pinned: true),
            ];
          },
          body: TabBarView(
            children: [
              UserTabPage(
                linkTxt: avatarLink,
                userName: userName,
                replie: false,
              ),
              // ThreadPost(
              //   avatarUrl: avatarLink
              //   username: userName,
              //   userId: userName,
              //   isVerified: false,
              //   minutes: 3,
              //   text: post["document"],
              //   mediaUrl: post["picture"],
              // ),
              UserTabPage(
                linkTxt: avatarLink,
                userName: userName,
                replie: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
