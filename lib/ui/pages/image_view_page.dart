import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

class ImagesViewPage extends StatefulWidget {
  final List<ImageProvider> images;
  final int initialImage;
  final Function(int)? onImageChanged;
  const ImagesViewPage(
      {Key? key,
      required this.images,
      this.initialImage = 0,
      this.onImageChanged})
      : super(key: key);
  @override
  _ImagesViewPageState createState() => _ImagesViewPageState();
}

class _ImagesViewPageState extends State<ImagesViewPage> {
  final Duration _scrollDuration = Duration(milliseconds: 200);
  final Curve _scrollCurve = Curves.ease;
  late PageController _controller;
  double _currentImage = 0.0;

  @override
  void initState() {
    _currentImage = widget.initialImage.toDouble();
    _controller = PageController(initialPage: widget.initialImage);
    _controller.addListener(() {
      setState(() {
        _currentImage = _controller.page ?? 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: _onKeyboardKeyPressed,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
              child: PageView.builder(
                controller: _controller,
                itemCount: widget.images.length,
                onPageChanged: widget.onImageChanged,
                itemBuilder: (context, index) => Stack(
                  children: [
                    Positioned.fill(
                      child: PhotoView(
                        maxScale: 10.0,
                        imageProvider: widget.images[index],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: _onClose,
              ),
            ),
          ),
          if (_currentImage > 0.5)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _onPreviousPage,
                ),
              ),
            ),
          if (_currentImage < widget.images.length - 1.5)
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _onNextPage,
                ),
              ),
            )
        ],
      ),
    );
  }

  void _onNextPage() =>
      _controller.nextPage(duration: _scrollDuration, curve: _scrollCurve);

  void _onPreviousPage() =>
      _controller.previousPage(duration: _scrollDuration, curve: _scrollCurve);

  void _onKeyboardKeyPressed(key) {
    if (key.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
      _onPreviousPage();
    } else if (key.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
      _onNextPage();
    }
  }

  void _onClose() {
    Navigator.maybePop(context);
  }
}
