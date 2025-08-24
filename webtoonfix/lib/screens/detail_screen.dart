import 'package:flutter/material.dart';
// import 'package:webtoonfix/constants/font_data.dart';

class DetailScreen extends StatelessWidget {
  final String title, thumb, id;

  const DetailScreen({
    super.key,
    required this.title,
    required this.thumb,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240.0,
            pinned: true,
            backgroundColor: Colors.orange,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              background: Container(
                color: Colors.orange,
                child: Stack(
                  children: [
                    Positioned(
                      left: 16,
                      right: 16,
                      bottom: 0,
                      child: Hero(
                        tag: id,
                        child: Material(
                          elevation: 5,
                          borderRadius: BorderRadius.circular(12),
                          clipBehavior: Clip.antiAlias,
                          child: SizedBox(
                            height: 180,
                            child: Image.network(
                              thumb,
                              headers: {'Referer': 'https://comic.naver.com'},
                              fit: BoxFit.cover,
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('작가이름 * 요일웹툰'),
                  Text('만화 설명 텍스트'),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(
                // leading: ,
                title: Text("${index}화"),
                subtitle: Text("평점: 9.98"),
              );
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}
