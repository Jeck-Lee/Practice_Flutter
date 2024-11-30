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

class _StickyHeadersScreenState extends State<StickyHeadersScreen> with SingleTickerProviderStateMixin {
  late TabController? _tabController;
  int _currentTab = 0;
  int _listCount = 3;

  void _incrementCounter() {
    setState(() {
      _listCount += 3;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
      animationDuration: Duration.zero,
    );
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
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
            /// 일부 섹션에서 헤더 제거
            header: const SizedBox.shrink(),
            sliver: const SliverToBoxAdapter(
              /// 일반 위젯을 SliverToBoxAdapter로 감쌈
              child: SubWidget(),
            ),
          ),
          SliverStickyHeader(
            header: const SizedBox.shrink(),
            sliver: const SliverToBoxAdapter(
              child: SubWidget2(),
            ),
          ),
          SliverStickyHeader(
            header: const SizedBox.shrink(),
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
            header: const SizedBox.shrink(),
            sliver: const SliverToBoxAdapter(
              child: SubWidget(),
            ),
          ),
          SliverStickyHeader(
            header: Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(icon: Icon(Icons.home), text: 'Home'),
                  Tab(icon: Icon(Icons.settings), text: 'Settings'),
                ],
                onTap: (value) {
                  setState(() {
                    _currentTab = value;
                  });
                },
              ),
            ),
            sliver: SliverToBoxAdapter(
              child: _currentTab == 0

                  /// 첫 번째 탭이 선택됐을 때
                  ? Container(
                      color: Colors.yellow,
                      height: 600,
                      child: const Center(child: Text('Home Screen', style: TextStyle(fontSize: 24))),
                    )

                  /// 두 번째 탭이 선택됐을 때
                  : Container(
                      color: Colors.green,
                      height: 400,
                      child: const Center(child: Text('Settings Screen', style: TextStyle(fontSize: 24))),
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
