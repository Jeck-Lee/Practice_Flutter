import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class OneScreen extends StatelessWidget {
  const OneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const OneView();
  }
}

class OneView extends StatefulWidget {
  const OneView({super.key});

  @override
  State<OneView> createState() => _OneViewState();
}

class _OneViewState extends State<OneView> {
  final ScrollController _controller = ScrollController();
  List<String> _headers = ['Header 1', 'Header 2', 'Header 3', 'Header 4'];
  int _selectedHeaderIndex = 0;

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
      _selectedHeaderIndex = (_controller.offset / 1180).round(); // 각 항목의 높이가 1180 이라고 가정
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("One"),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            fit: FlexFit.tight,
            flex: 1,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return HeaderItem(
                  header: _headers[index],
                  isSelected: _selectedHeaderIndex == index,
                  onTap: () {
                    setState(() {
                      _controller.animateTo(
                        index * 1180.0, // 헤더 위치로 스크롤
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                );
              },
              itemCount: _headers.length,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: CustomScrollView(
              controller: _controller,
              slivers: [
                Section(
                  title: 'Category #1',
                  headerColor: Colors.blue,
                  items: List.generate(
                      10,
                      (index) => ListTile(
                            title: Text('Item #${index + 1}'),
                          )),
                ),
                Section(
                  title: 'Category #2',
                  headerColor: Colors.red,
                  items: List.generate(
                      20,
                      (index) => ListTile(
                            title: Text('Item #${index + 11}'),
                          )),
                ),
                Section(
                  title: 'Category #3',
                  headerColor: Colors.green,
                  items: List.generate(
                      20,
                      (index) => ListTile(
                            title: Text('Item #${index + 21}'),
                          )),
                ),
                // SliverFillRemaining(
                //   child: Center(
                //     child: Text('This is the remaining content.'),
                //   ),
                // ),
                Section(
                  title: 'Category #4',
                  headerColor: Colors.orange,
                  items: List.generate(
                      20,
                      (index) => ListTile(
                            title: Text('Item #${index + 31}'),
                          )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Section extends MultiSliver {
  Section({
    Key? key,
    required String title,
    Color headerColor = Colors.white,
    Color titleColor = Colors.black,
    required List<Widget> items,
  }) : super(
          key: key,
          pushPinnedChildren: true,
          children: [
            SliverPinnedHeader(
              child: ColoredBox(
                color: headerColor,
                child: ListTile(
                  textColor: titleColor,
                  title: Text(title),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                items,
              ),
            ),
          ],
        );
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
    return InkWell(
      onTap: onTap,
      child: Container(
        color: isSelected ? Colors.grey : null,
        padding: const EdgeInsets.all(8.0),
        child: Text(
          header,
        ),
      ),
    );
  }
}
