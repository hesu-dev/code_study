import 'package:flutter/material.dart';

final List<Map<String, dynamic>> cardData = [
  {
    "title": "DESIGN MEETING",
    "startTime": "11",
    "startMinute": "30",
    "endTime": "12",
    "endMinute": "20",
    "members": ["ALEX", "HELENA", "NANA"],
    "color": Color(0xfffdf771),
  },
  {
    "title": "DAILY PROJECT",
    "startTime": "12",
    "startMinute": "35",
    "endTime": "14",
    "endMinute": "10",
    "members": ["ME", "RICHARD", "CIRY", "+4"],
    "color": Color(0xff956dc8),
  }, //c6ed67
  {
    "title": "WEEKLY PLANNING",
    "startTime": "15",
    "startMinute": "00",
    "endTime": "16",
    "endMinute": "30",
    "members": ["DEN", "NANA", "MARK"],
    "color": Color(0xffc6ed67),
  },
  {
    "title": "MOKUP TEST TEXT",
    "startTime": "1",
    "startMinute": "2",
    "endTime": "3",
    "endMinute": "4",
    "members": ["NELL", "NICO", "HESU"],
    "color": Colors.orangeAccent,
  },
];

class Homework extends StatelessWidget {
  const Homework({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: CircleAvatar(
            radius: 18,
            backgroundImage: NetworkImage(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTSGj3NafcsbWnNQ5hT6ZVuky-TTVgaCHF4oQ&s',
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MONDAY 16',
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              Row(
                children: [
                  Text(
                    'TODAY ',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ),
                  Text(
                    '•',
                    style: TextStyle(fontSize: 35, color: Colors.purpleAccent),
                  ),
                  ...List.generate(5, (index) {
                    final day = index + 17;
                    return Expanded(
                      child: Text(
                        ' $day ',
                        style: TextStyle(fontSize: 35, color: Colors.grey[500]),
                      ),
                    );
                  }),
                ],
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: cardData.length,
                  itemBuilder: (context, index) {
                    final data = cardData[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ListCardView(
                        title: data['title'],
                        startTime: data['startTime'],
                        startMinute: data['startMinute'],
                        endTime: data['endTime'],
                        endMinute: data['endMinute'],
                        members: data['members'],
                        colors: data['color'],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ListCardView extends StatelessWidget {
  final String title;
  final String startTime;
  final String startMinute;
  final String endTime;
  final String endMinute;
  final List<String> members;
  final Color colors;

  const ListCardView({
    super.key,
    required this.title,
    required this.startTime,
    required this.startMinute,
    required this.endTime,
    required this.endMinute,
    required this.members,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      decoration: BoxDecoration(
        color: colors,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(startTime, style: TextStyle(fontSize: 30)),
                Text(startMinute, style: TextStyle(fontSize: 15)),
                SizedBox(height: 4),
                Text("|", style: TextStyle(fontSize: 15)),
                SizedBox(height: 4),
                Text(endTime, style: TextStyle(fontSize: 30)),
                Text(endMinute, style: TextStyle(fontSize: 15)),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 55)),
                  SizedBox(height: 8),
                  Wrap(
                    spacing: 40,
                    children: members
                        .map(
                          (m) => Text(
                            m,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black38,
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
