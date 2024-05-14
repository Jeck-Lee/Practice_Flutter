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
  final controller = ScrollController();
  final dataKey = GlobalKey();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
                return InkWell(
                  onTap: () {
                    debugPrint("----------${dataKey.currentContext}");
                    Scrollable.ensureVisible(dataKey.currentContext!);
                  },
                  child: Container(
                    color: Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    child: Text('item $index'),
                  ),
                );
              },
              itemCount: 10,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            flex: 3,
            child: CustomScrollView(
              controller: controller,
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
                SliverToBoxAdapter(
                  child: Container(
                    color: Colors.purple,
                    height: 100,
                  ),
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
                MultiSliver(
                  pushPinnedChildren: true,
                  children: [
                    SliverPinnedHeader(
                      child: ColoredBox(
                        key: dataKey,
                        color: Colors.yellow,
                        child: ListTile(
                          textColor: Colors.grey,
                          title: Text('Category #2'),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate.fixed(
                        List.generate(
                            20,
                            (index) => ListTile(
                                  title: Text('Item #${index + 11}'),
                                )),
                      ),
                    ),
                  ],
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

class FirstWidget extends StatelessWidget {
  const FirstWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Text("First Widget"), ...List.generate(33, (index) => Text("item $index"))],
    );
  }
}
