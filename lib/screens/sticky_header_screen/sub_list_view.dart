import 'package:flutter/material.dart';

class SubListView extends StatelessWidget {
  const SubListView({
    Key? key,
    this.padding,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.itemCount,
    required this.onSelected,
    required this.onPressedMore,
  }) : super(key: key);

  final EdgeInsetsGeometry? padding;
  final Widget? Function(BuildContext context, int index) itemBuilder;
  final Widget Function(BuildContext context, int index) separatorBuilder;
  final int itemCount;
  final void Function(int index) onSelected;
  final void Function() onPressedMore;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: padding,
            itemBuilder: (context, index) => InkWell(
              onTap: () => onSelected(index),
              child: itemBuilder(context, index),
            ),
            separatorBuilder: (context, index) => separatorBuilder(context, index),
            itemCount: itemCount),
        InkWell(
          onTap: onPressedMore,
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey, width: 1),
                bottom: BorderSide(color: Colors.grey, width: 1),
              ),
              color: Colors.blueGrey,
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
            width: double.infinity,
            child: const Text(
              "More +",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}

class SubListItemView extends StatelessWidget {
  const SubListItemView({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 제목
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 6),
          IntrinsicHeight(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Container(
                    color: Colors.white70,
                    width: 120,
                    height: 106,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// 내용
                      Text(
                        "$title의 내용",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),

                      /// 날짜
                      Text(
                        DateTime.now().toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      const Spacer(),

                      /// 카피라이트
                      const Text(
                        "Copyright: ~",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),

                      /// 주소 링크
                      const Text(
                        "https://~~",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

