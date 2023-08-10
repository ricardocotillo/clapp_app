import 'package:flutter/material.dart';

class CarouselComponent extends StatelessWidget {
  const CarouselComponent({
    super.key,
    this.title,
    this.onSeeAll,
    required this.count,
    required this.height,
    required this.builder,
    this.gap,
  });

  final VoidCallback? onSeeAll;
  final Widget? title;
  final Widget? Function(BuildContext, int) builder;
  final double height;
  final int count;
  final double? gap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: count,
        separatorBuilder: (context, index) => VerticalDivider(
          color: Colors.transparent,
          width: gap,
        ),
        itemBuilder: builder,
      ),
    );
  }
}
