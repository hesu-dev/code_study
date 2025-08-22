import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({super.key, required this.userId});

  final String userId;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

bool _change = false;

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    void change() {
      setState(() {
        _change = !_change;
      });
    }

    final List<String> reportReasons = [
      '관심 없는 게시물입니다',
      '전기통신사업법에 의거한 불법을 신고합니다',
      '의심스럽거나 스팸입니다',
      '오해의 소지를 담고 있습니다.',
      // '자해 또는 자살의도를 표현하고 있습니다.',
    ];

    return SizedBox(
      // height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Offstage(
                  offstage: _change == true,
                  child: IconButton(
                    onPressed: () => change(),
                    icon: FaIcon(FontAwesomeIcons.arrowLeft),
                  ),
                ),
                Expanded(
                  child: Text(
                    _change == false ? '이 스레드의 신고사유가 어떻게 되시나요?' : '유저 설정',
                    style: TextStyle(
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const Divider(height: 50, thickness: 1.5),
            Offstage(
              offstage: _change == false,
              child: Column(
                children: [
                  _buildActionGroup(context, [
                    _ActionItem(
                      label: 'Unfollow',
                      onTap: () => print('Unfollow'),
                    ),
                    _ActionItem(label: 'Mute', onTap: () => print('Mute')),
                  ]),
                  _buildActionGroup(context, [
                    _ActionItem(label: 'Hide', onTap: () => print('Hide')),
                    _ActionItem(
                      label: 'Report',
                      onTap: () {
                        change();
                      },
                    ),
                  ]),
                ],
              ),
            ),
            Offstage(
              offstage: _change == true,
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: reportReasons.length,
                    separatorBuilder: (context, index) =>
                        const Divider(thickness: 0.5),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => print('${reportReasons[index]} 클릭'),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: Sizes.size18,
                            vertical: 16,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(reportReasons[index]),
                              const FaIcon(FontAwesomeIcons.arrowRight),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),

              //               Why are you reporting this thread?
              // Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.
              // I just don't like it

              // It's unlawful content under NetzDG

              // It's spam

              // Hate speech or symbols
              // >
              // Nudity or sexual activity
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildActionGroup(BuildContext context, List<_ActionItem> items) {
  return Column(
    children: items
        .map(
          (item) => InkWell(
            onTap: item.onTap,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
                  child: Center(child: Text(item.label)),
                ),
                Divider(thickness: 0.5),
              ],
            ),
          ),
        )
        .toList(),
  );
}

class _ActionItem {
  final String label;
  final VoidCallback onTap;
  _ActionItem({required this.label, required this.onTap});
}
