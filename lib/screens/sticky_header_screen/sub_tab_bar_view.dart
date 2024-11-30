import 'package:flutter/material.dart';

class SubTabBarView extends StatefulWidget {
  const SubTabBarView({super.key});

  @override
  State<SubTabBarView> createState() => _SubTabBarViewState();
}

class _SubTabBarViewState extends State<SubTabBarView> with SingleTickerProviderStateMixin {
  late TabController? _tabController;
  int _currentTab = 0;

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
    return Column(
      children: [
        TabBar(
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
        _currentTab == 0

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
      ],
    );
  }
}
