import 'package:flutter/material.dart';
import 'package:gallery_view/api/images_api.dart';
import 'package:gallery_view/models/image_model.dart';
import 'package:gallery_view/ui/pages/gallery_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<ImagesResponse>(
          future: ImagesApi()
              .fetchImages('kqv_-UXC1fpTn7gPCuDBT4Pwk5iiGPd5mJMrfVhiuwY'),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return GalleryPage(
                images: snapshot.data!.images
                        ?.map((e) => NetworkImage(e.image?.regular ?? ''))
                        .toList() ??
                    []);
          }),
    );
  }
}
