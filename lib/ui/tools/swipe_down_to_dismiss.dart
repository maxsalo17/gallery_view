import 'package:flutter/material.dart';

showSwipeDownToDismiss(BuildContext context,
    {required Widget Function(BuildContext) builder,
    Color barrierColor = Colors.black}) {
  showGeneralDialog(
    barrierColor: Colors.transparent,
    context: context,
    barrierLabel: 'Label',
    barrierDismissible: true,
    transitionDuration: const Duration(milliseconds: 10),
    pageBuilder: (context, anim1, anim2) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: barrierColor,
        child: Dismissible(
            direction: DismissDirection.vertical,
            behavior: HitTestBehavior.deferToChild,
            key: const Key('key'),
            onDismissed: (_) => Navigator.of(context).pop(),
            child: builder(context)),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(anim1),
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        ),
      );
    },
  );
}
