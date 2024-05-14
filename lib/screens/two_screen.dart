import 'package:flutter/material.dart';

class TwoScreen extends StatelessWidget {
  const TwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const TwoView();
  }
}

class TwoView extends StatefulWidget {
  const TwoView({super.key});

  @override
  State<TwoView> createState() => _TwoViewState();
}

class _TwoViewState extends State<TwoView> {
  final ScrollController _controller = ScrollController();
  List<String> _headers = ['Header 1', 'Header 2', 'Header 3', 'Header 4'];
  int _selectedHeaderIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.removeListener(_scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _selectedHeaderIndex = (_controller.offset / 200).round(); // 각 항목의 높이가 200이라고 가정
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Two"),
      ),
      body: SafeArea(
        child: Row(
          children: [
            Container(
              width: 100.0, // 좌측 헤더의 너비
              child: ListView.builder(
                itemCount: _headers.length,
                itemBuilder: (context, index) {
                  return HeaderItem(
                    header: _headers[index],
                    isSelected: _selectedHeaderIndex == index,
                    onTap: () {
                      setState(() {
                        // _selectedHeaderIndex = index;
                        _controller.animateTo(
                          index * 200.0, // 헤더 위치로 스크롤
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      });
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: _controller,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Item $index'),
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

class HeaderItem extends StatelessWidget {
  final String header;
  final bool isSelected;
  final VoidCallback onTap;

  const HeaderItem({
    Key? key,
    required this.header,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isSelected ? Colors.blue : null,
        padding: EdgeInsets.all(8.0),
        child: Text(
          header,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
