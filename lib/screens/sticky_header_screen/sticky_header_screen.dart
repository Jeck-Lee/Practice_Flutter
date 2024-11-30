import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:practice_flutter/screens/sticky_header_screen/sub_list_view.dart';
import 'package:practice_flutter/screens/sticky_header_screen/sub_widget.dart';

class StickyHeadersScreen extends StatefulWidget {
  const StickyHeadersScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StickyHeadersScreen> createState() => _StickyHeadersScreenState();
}

class _StickyHeadersScreenState extends State<StickyHeadersScreen> {
  int _listCount = 3;

  void _incrementCounter() {
    setState(() {
      _listCount += 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Sticky Headers'),
      ),
      body: CustomScrollView(
        slivers: [
          SliverStickyHeader(
            header: Container(
              height: 60.0,
              color: Colors.lightBlue,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Header #0',
                style: TextStyle(color: Colors.white),
              ),
            ),
            sliver: const SliverToBoxAdapter(
              /// 일반 위젯을 SliverToBoxAdapter로 감쌈
              child: SubWidget(),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              height: 60.0,
              color: Colors.lightBlue,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Header #1',
                style: TextStyle(color: Colors.white),
              ),
            ),
            sliver: const SliverToBoxAdapter(
              child: SubWidget2(),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              height: 60.0,
              color: Colors.lightBlue,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Header #2',
                style: TextStyle(color: Colors.white),
              ),
            ),
            sliver: SliverToBoxAdapter(
              child: SubListView(
                itemBuilder: (context, index) {
                  return SubListItemView(title: "$index 제목");
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black38,
                ),
                itemCount: _listCount,
                onSelected: (index) {},
                onPressedMore: _incrementCounter,
              ),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              height: 60.0,
              color: Colors.lightBlue,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Header #3',
                style: TextStyle(color: Colors.white),
              ),
            ),
            sliver: const SliverToBoxAdapter(
              child: SubWidget2(),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              height: 60.0,
              color: Colors.lightBlue,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Header #4',
                style: TextStyle(color: Colors.white),
              ),
            ),
            sliver: SliverToBoxAdapter(
              child: SubListView(
                itemBuilder: (context, index) {
                  return SubListItemView(title: "$index 제목");
                },
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.black38,
                ),
                itemCount: 2,
                onSelected: (index) {},
                onPressedMore: () {},
              ),
            ),
          ),

          /// 패키지 문서 공식 Example
          SliverStickyHeader(
            header: Container(
              height: 60.0,
              color: Colors.lightBlue,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Header #5',
                style: TextStyle(color: Colors.white),
              ),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) => ListTile(
                  leading: const CircleAvatar(
                    child: Text('0'),
                  ),
                  title: Text('List tile #$i'),
                ),
                childCount: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
