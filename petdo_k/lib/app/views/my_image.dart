import 'package:flutter/material.dart';

import '../common/const.dart';

class MyImage extends StatelessWidget {
  final String link;

  const MyImage({
    required this.link,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      link,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      frameBuilder: (_, child, frame, wasSynchronouslyLoaded) =>
          wasSynchronouslyLoaded
              ? child
              : AnimatedOpacity(
                  child: child,
                  opacity: frame == null ? 0 : 1,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeOut,
                ),
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress == null
              ? child
              // : Center(child: CircularProgressIndicator.adaptive()),
              : Center(
                  child: CircularProgressIndicator(
                    color: subPrimaryColor,
                    backgroundColor: primaryColor,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                ),
      errorBuilder: (context, error, stackTrace) => Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset('assets/no_image.png', height: 30),
      ),
    );
  }
}
