// ignore_for_file: deprecated_member_use

import 'package:faker/faker.dart' hide Image;
import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  List<Map<String, dynamic>> searchs = [];
  List<String> tabs = ["All", "replies", "Mentions", "test"];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _getSearchData();
  }

  void _getSearchData() {
    searchs = List.generate(3, (index) {
      return {
        "avatarUrl": faker.image.image(random: true),
        "username": faker.person.name(),
        "minutes": faker.randomGenerator.integer(59),
        "address": faker.address.cityPrefix(),
        "isFollower": faker.randomGenerator.boolean(),
        "message": faker.lorem.sentence(),
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(Sizes.size20),
          child: SafeArea(
            child: Column(
              children: [
                Text(
                  "Activity",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
                // Wrap(
                //   spacing: 10,
                //   children: List.generate(tabs.length, (index) {
                //     return ChoiceChip(
                //       label: Text(tabs[index]),
                //       selected: selectedIndex == index,
                //       selectedColor: Colors.black,
                //       backgroundColor: Colors.white,
                //       labelStyle: TextStyle(
                //         color: selectedIndex == index
                //             ? Colors.white
                //             : Colors.black,
                //       ),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(20),
                //         side: BorderSide(color: Colors.grey),
                //       ),
                //       onSelected: (_) {
                //         setState(() {
                //           selectedIndex = index;
                //         });
                //       },
                //     );
                //   }),
                // ),
                Gaps.v32,
                ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: Sizes.size20),
                  itemCount: searchs.length,
                  itemBuilder: (context, index) {
                    final search = searchs[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.network(
                            search['avatarUrl'],
                            width: 44,
                            height: 44,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: 44,
                                height: 44,
                                color: Colors.grey[300],
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 44,
                                height: 44,
                                color: Colors.grey[400],
                                child: const Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                        Gaps.h20,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  search["username"],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Gaps.h5,
                                Text(
                                  "4h", //search["minutes"],
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                            Text(
                              search["address"],
                              style: TextStyle(color: Colors.grey),
                            ),
                            Gaps.v10,
                            // Text(search["message"]),
                            const Divider(height: 50, thickness: 0.5),
                          ],
                        ),
                        Column(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  search['isFollower'] = !search['isFollower'];
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: search['isFollower'] == true
                                    ? Colors.blueAccent
                                    : Colors.white,
                                side: BorderSide(
                                  color: search['isFollower'] == true
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                search['isFollower'] == true
                                    ? "follow"
                                    : "unfollow",
                                style: TextStyle(
                                  color: search['isFollower'] == true
                                      ? Colors.white
                                      : Colors.red,
                                ), // 글자색
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
