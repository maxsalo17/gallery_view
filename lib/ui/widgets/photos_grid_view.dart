import 'package:flutter/material.dart';
import 'package:gallery_view/models/image_model.dart';

class GalleryGrid extends StatelessWidget {
  final int itemCount;
  final Widget Function(BuildContext context, int index) itemBuilder;

  const GalleryGrid(
      {Key? key, required this.itemCount, required this.itemBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: itemCount,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return AspectRatio(
          aspectRatio: 1,
          child: Container(
            child: itemBuilder(context, index),
          ),
        );
      },
    );
  }
}
