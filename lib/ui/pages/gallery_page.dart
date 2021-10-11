import 'package:flutter/material.dart';
import 'package:gallery_view/models/image_model.dart';
import 'package:gallery_view/ui/pages/image_view_page.dart';
import 'package:gallery_view/ui/tools/swipe_down_to_dismiss.dart';
import 'package:gallery_view/ui/widgets/photos_grid_view.dart';

class GalleryPage extends StatefulWidget {
  final List<ImageProvider> images;

  const GalleryPage({Key? key, this.images = const []}) : super(key: key);
  @override
  _GalleryPageState createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  void _onImageTap(int index) async {
    showSwipeDownToDismiss(context,
        builder: (context) => ImagesViewPage(
              images: widget.images,
              initialImage: index,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
      ),
      body: GalleryGrid(
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            final imageModel = widget.images[index];
            return InkWell(
                onTap: () => _onImageTap(index),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image(image: imageModel, fit: BoxFit.cover),
                ));
          }),
    );
  }
}
