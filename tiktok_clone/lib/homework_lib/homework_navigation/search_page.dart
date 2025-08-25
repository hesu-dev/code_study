// ignore_for_file: deprecated_member_use

import 'package:faker/faker.dart' hide Image;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Image;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Map<String, dynamic>> searchs = [];

  @override
  void initState() {
    super.initState();
    _getSearchData();
  }

  void _getSearchData() {
    searchs = List.generate(11, (index) {
      return {
        "avatarUrl": faker.image.image(random: true),
        "username": faker.person.name(),
        "address": faker.address.cityPrefix(),
        "isFollower": faker.randomGenerator.boolean(),
        "followers": faker.randomGenerator.integer(100000),
      };
    });
  }

  String formatWithK(int number) {
    if (number < 1000) {
      return number.toString();
    } else {
      double result = number / 1000;
      return "${result.toStringAsFixed(1)}K";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Sizes.size20),
      child: SafeArea(
        child: Column(
          children: [
            CupertinoSearchTextField(),
            Gaps.v32,
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: Sizes.size20),
                itemCount: searchs.length,
                itemBuilder: (context, index) {
                  final search = searchs[index];
                  final random = formatWithK(
                    faker.randomGenerator.integer(10000),
                  );
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
                      Expanded(
                        child: Column(
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
                                FaIcon(
                                  FontAwesomeIcons.checkCircle,
                                  size: Sizes.size14,
                                  color: Colors.blueAccent,
                                ),
                              ],
                            ),
                            Text(
                              search["address"],
                              style: TextStyle(color: Colors.grey),
                            ),
                            Gaps.v10,
                            Text("$random followers"),
                            const Divider(height: 50, thickness: 0.5),
                          ],
                        ),
                      ),

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
                          search['isFollower'] == true ? "follow" : "unfollow",
                          style: TextStyle(
                            color: search['isFollower'] == true
                                ? Colors.white
                                : Colors.red,
                          ), // 글자색
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
